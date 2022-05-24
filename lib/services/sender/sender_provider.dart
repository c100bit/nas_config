import 'package:get/get.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';
import 'package:nas_config/services/sender/compute_service.dart';
import 'package:nas_config/services/sender/sender_service.dart';

class SenderProvider {
  final ComputeService _computeService = Get.find<ComputeService>();
  final SenderService _senderService = Get.find<SenderService>();

  void execute(AppModel appModel, RxString logData) {
    final settings = appModel.settings;
    final devices = _filterDevices(appModel.devices);

    for (var ip in devices) {
      final client = _senderService.initClient(ip, settings);
      _addCompute(client, appModel.commands, logData);
    }

    _computeService.execute(settings.threads);
  }

  void stop() => _computeService.stop();

  _addCompute(BaseClient client, Commnads commands, RxString logData) {
    _computeService.add(() async {
      try {
        final result = await client.execute(commands);
        //logData.value += result.join('\n');
      } catch (e) {
        logData.value = e.toString();
      }
    });
  }

  Devices _filterDevices(Devices devices) {
    final filtered = devices.toSet().toList();
    filtered.removeWhere((e) => e.isEmpty);
    return filtered;
  }
}
