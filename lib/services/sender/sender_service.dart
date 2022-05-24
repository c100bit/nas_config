import 'dart:convert';
import 'dart:io';

import 'package:computer/computer.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:get/get.dart';
import 'package:nas_config/services/sender/clients/app_ssh_client.dart';

class SSHService extends GetxService {
  Future<SSHService> init() async {
    return this;
  }
}

  Future<SSHClient> initClient(
      {required ip, required login, required password}) async {
      final client = AppSSHClient(ip: ip, login: login, password: password);
      client.connect();

  }


}
