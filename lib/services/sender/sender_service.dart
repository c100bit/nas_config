import 'package:get/get.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/models/log_data.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/services/sender/clients/app_ssh_client.dart';
import 'package:nas_config/services/sender/clients/app_telnet_client.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';
import 'package:nas_config/services/sender/compute_service.dart';

class SenderService extends GetxService {
  final ComputeService _computeService = Get.find<ComputeService>();

  void run(AppModel appModel, LogData logData) async {
    final settings = appModel.settings;
    final devices = _filterDevices(appModel.devices);

    for (var ip in devices) {
      final client = _initClient(ip, appModel.commands, settings);
      _addCompute(client);
    }

    _computeService.execute(settings.threads, logData);
  }

  void stop() => _computeService.stop();

  _addCompute(BaseClient client) {
    _computeService.add(() async {
      print((await client.execute()).join('\n'));
    });
  }

  Devices _filterDevices(Devices devices) {
    final filtered = devices.toSet().map((e) => e.trim()).toList();
    filtered.removeWhere((e) => e.isEmpty);
    return filtered;
  }

  BaseClient _initClient(String ip, Commands commands, Settings settings) {
    if (settings.protocol == SettingsProtocol.telnet) {
      return AppTelnetClient(
          ip: ip,
          login: settings.login,
          password: settings.password,
          welcome: settings.device.welcome,
          timeout: settings.timeout,
          commands: commands);
    }
    return AppSSHClient(
        ip: ip,
        login: settings.login,
        password: settings.password,
        welcome: settings.device.welcome,
        timeout: settings.timeout,
        commands: commands);
  }
}
