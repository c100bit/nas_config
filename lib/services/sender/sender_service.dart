import 'package:get/get.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/models/log_data.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';
import 'package:nas_config/services/sender/compute_service.dart';

class SenderService extends GetxService {
  final ComputeService _computeService = Get.find<ComputeService>();

  void run(AppModel appModel, LogData logData) async {
    final settings = appModel.settings;
    final devices = _filterDevices(appModel.devices);
    print(devices);
    for (var ip in devices) {
      final client = _initClient(ip, settings);
      _addCompute(client, appModel.commands);
    }
    _computeService.execute(settings.threads, logData);
  }

  void stop() => _computeService.stop();

  _addCompute(BaseClient client, Commnads commands) {
    print(client);
    print(commands);
    _computeService.add(() async {
      try {
        return (await client.execute(commands)).join('\n');
      } catch (e) {
        return e.toString();
      }
    });
  }

  Devices _filterDevices(Devices devices) {
    final filtered = devices.toSet().map((e) => e.trim()).toList();
    filtered.removeWhere((e) => e.isEmpty);
    return filtered;
  }

  BaseClient _initClient(String ip, Settings settings) {
    if (settings.protocol == SettingsProtocol.telnet) {
      return AppTelnetClient(
          ip: ip,
          login: settings.login,
          password: settings.password,
          timeout: settings.timeout);
    }

    return AppSSHClient(
        ip: ip,
        login: settings.login,
        password: settings.password,
        timeout: settings.timeout);
  }
}
