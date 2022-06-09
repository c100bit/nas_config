import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartssh2/dartssh2.dart';
import 'package:nas_config/core/errors.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';

class AppSSHClient extends BaseClient {
  static const _port = 22;
  SSHClient? _client;

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
    try {
      _client = SSHClient(
        await SSHSocket.connect(
          ip,
          port,
          timeout: Duration(seconds: timeout),
        ),
        username: login,
        onPasswordRequest: () => password,
      );
    } on SocketException {
      addError(Errors.connectionFailure);
    }
  }

  @override
  Future<void> run() async {
    if (_client != null) {
      try {
        for (var cmd in commands) {
          final result = await _client!.run(cmd);
          addEvent(
              cmd: cmd, message: utf8.decode(result, allowMalformed: true));
        }
        closeLogData();
      } on SSHAuthFailError {
        addError(Errors.invalidAuth);
      } on SSHError catch (e) {
        addError(Errors.sshError(e));
      } catch (e) {
        addError(e.toString());
      }
    }
  }

  @override
  Future<void> close() async {
    try {
      _client?.close();
      await _client?.done;
    } catch (_) {}
  }
}
