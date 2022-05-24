import 'package:get/get.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/services/sender/compute_service.dart';
import 'package:nas_config/services/sender/sender_service.dart';

class SenderProvider {
  final ComputeService _computeService = Get.find<ComputeService>();
  final SSHService _sshService = Get.find<SSHService>();

  void execute(AppModel appModel) async {
    final settings = appModel.settings;

    for (var ip in appModel.devices) {
      await _sshService.initClient(
          ip: ip, login: settings.login, password: settings.password);
    }
  }
}
