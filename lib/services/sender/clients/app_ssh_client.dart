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
      required super.device,
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
    } catch (e) {
      addError(e.toString());
    }
  }

  @override
  Future<void> run() async {
    if (_client != null) {
      try {
        final validDevice = await _checkDevice();
        if (!validDevice) throw InvalidDeviceError();
        for (var cmd in commands) {
          addEvent(cmd: cmd, message: await _runCmd(cmd));
        }
        closeLogData();
      } on InvalidDeviceError catch (e) {
        addError(e.toString());
      } on SSHAuthFailError {
        addError(Errors.invalidAuth);
      } on TimeoutException {
        addError(Errors.timeoutError);
      } on SSHError catch (e) {
        addError(e.toString());
      } catch (e) {
        addError(e.toString());
      }
    }
  }

  Future<String> _runCmd(String cmd) async {
    final result = await _client!.run(cmd).timeout(Duration(seconds: timeout));
    return utf8.decode(result, allowMalformed: true);
  }

  Future<bool> _checkDevice() async {
    final result = await _runCmd(device.checkCmd);
    return result.toLowerCase().contains(device.checkStr.toLowerCase());
  }

  @override
  Future<void> close() async {
    try {
      _client?.close();
      await _client?.done;
    } catch (_) {}
  }
}
