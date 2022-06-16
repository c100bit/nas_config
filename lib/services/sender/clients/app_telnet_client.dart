import 'dart:async';

import 'package:nas_config/core/errors.dart';
import 'package:nas_config/services/sender/clients/app_telnet_client/opt_msg_processor.dart';
import 'package:nas_config/services/sender/clients/app_telnet_client/text_msg_processor.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';
import 'package:telnet/telnet.dart';

class AppTelnetClient extends BaseClient {
  static const _port = 23;

  late final ITelnetClient? _client;

  final _textMsgProcessor = TextMsgProcessor();
  final _optMsgProcessor = OptMsgProcessor();
  final _dataController = StreamController<String>();

  AppTelnetClient(
      {required super.ip,
      required super.login,
      required super.password,
      required super.device,
      required super.timeout,
      required super.commands,
      super.port = _port}) {
    _textMsgProcessor
      ..addCommands(commands)
      ..addDevice(device)
      ..addAccount(login: login, password: password);
  }

  @override
  Future<void> close() async {
    await _client?.terminate();
  }

  @override
  Future<void> connect() async {
    final task = TelnetClient.startConnect(
      host: ip,
      port: port,
      timeout: Duration(seconds: timeout),
      onEvent: _onEvent,
      onError: _onError,
      onDone: _onDone,
    );
    // Wait the connection task finished.
    await task.waitDone();
    _client = task.client;

    if (_client == null) {
      addError(Errors.connectionFailure);
    }
  }

  @override
  Future<List<String>> run() async {
    return await _dataController.stream.toList();
  }

  FutureOr<void> _onEvent(TelnetClient? client, TLMsgEvent event) {
    if (client == null || event.type != TLMsgEventType.read) return null;
    try {
      if (event.msg is TLOptMsg) {
        _optMsgProcessor
          ..updateClient(client)
          ..run(event.msg);
        return null;
      }
      if (event.msg is! TLTextMsg) return null;
      if (_textMsgProcessor.isEmptyCmdList()) {
        closeLogData();
      }
      final cmd = _textMsgProcessor.nextCommand();
      final result = (_textMsgProcessor..updateClient(client)).run(event.msg);
      addEvent(cmd: cmd, message: result);
    } catch (e) {
      addError(e.toString());
    }
  }

  void _onError(TelnetClient? client, dynamic error) {
    print("[ERROR] $error");
  }

  void _onDone(TelnetClient? client) {
    // _dataController.close();
  }
}
