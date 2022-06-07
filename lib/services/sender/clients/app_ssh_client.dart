import 'dart:async';
import 'dart:io';
import 'package:dartssh2/dartssh2.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';

class AppSSHClient extends BaseClient {
  static const _port = 22;
  SSHClient? _client;
  final _dataController = StreamController<String>();

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
      _dataController.add('Connection failure');
      _dataController.close();
    }
  }

  @override
  Future<List<String>> run() async {
    if (_client != null) {
      try {
        await _client?.run('quit');
        _dataController.add('[Mikrotik] Successful connection');
        _dataController.close();
      } on SSHAuthFailError {
        _dataController.add('[Mikrotik] Invalid auth for login=$login');
        _dataController.close();
      } on SSHAuthAbortError {
        _dataController
            .add('[Mikrotik] Connection closed before authentication');
        _dataController.close();
      }
    }
    return await _dataController.stream.toList();
  }

  @override
  Future<void> close() async {
    try {
      _client?.close();
      await _client?.done;
    } catch (e) {}
  }
}
