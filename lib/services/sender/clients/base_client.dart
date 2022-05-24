import 'dart:convert';
import 'package:dartssh2/dartssh2.dart';

part 'app_ssh_client.dart';
part 'app_telnet_client.dart';

abstract class BaseClient {
  final String ip;
  final String login;
  final String password;
  final int port;
  final int timeout;

  Future<void> _connect();
  Future<void> _close();
  Future<String> _run(String command);

  BaseClient(
      {required this.ip,
      required this.login,
      required this.password,
      required this.timeout,
      required this.port});

  Future<List<String>> execute(List<String> commands) async {
    await _connect();
    final totalResult = <String>[];
    for (var command in commands) {
      final result = await _run(command);
      totalResult.add(result);
    }
    await _close();
    return totalResult;
  }
}
