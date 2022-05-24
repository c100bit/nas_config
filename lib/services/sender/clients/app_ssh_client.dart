import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';

class AppSSHClient extends BaseClient {
  static const _port = 22;
  late final SSHClient client;

  AppSSHClient(
      {required super.ip,
      required super.login,
      required super.password,
      super.port = _port});

  Future<void> _init() async {
    client = SSHClient(
      await SSHSocket.connect(ip, port),
      username: login,
      onPasswordRequest: () => password,
    );
  }

  Future<String> _run(String command) async {
    final result = await client.run(command);
    return utf8.decode(result);
  }

  Future<List<String>> execute(List<String> commands) async {
    final result = super.execute(commands);
    client.close();
    await client.done;
    return result;
  }
}
