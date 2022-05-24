import 'package:get/get.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';

class SenderService extends GetxService {
  BaseClient initClient(String ip, Settings settings) {
    return AppSSHClient(
        ip: ip,
        login: settings.login,
        password: settings.password,
        timeout: settings.timeout);
  }
}
