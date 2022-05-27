import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';

class AppSSHClient extends BaseClient {
  static const _port = 22;
  late final SSHClient _client;

  AppSSHClient(
      {required super.ip,
      required super.login,
      required super.password,
      required super.timeout,
      required super.welcome,
      required super.commands,
      super.port = _port});

  @override
  Future<void> connect() async {
    _client = SSHClient(
      await SSHSocket.connect(
        ip,
        port,
        timeout: Duration(seconds: timeout),
      ),
      username: login,
      onPasswordRequest: () => password,
    );
  }

  @override
  Future<List<String>> run() async {
    final totalResult = <String>[];
    for (var command in commands) {
      final result = await _client.run(command);
      totalResult.add(utf8.decode(result));
    }

    return totalResult;
  }

  @override
  Future<void> close() async {
    _client.close();
    await _client.done;
  }
}
