import 'dart:async';

import 'package:nas_config/services/sender/clients/app_telnet_client/opt_msg_processor.dart';
import 'package:nas_config/services/sender/clients/app_telnet_client/text_msg_processor.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';
import 'package:telnet/telnet.dart';

class AppTelnetClient extends BaseClient {
  static const _port = 23;
  late final ITelnetClient? _client;
  late final TextMsgProcessor _textMsgProcessor;
  late final OptMsgProcessor _optMsgProcessor;
  final _data = <String>[];

  final _streamController = StreamController<String>();

  AppTelnetClient(
      {required super.ip,
      required super.login,
      required super.password,
      required super.timeout,
      super.port = _port});

  @override
  Future<void> close() async {
    await _client?.terminate();
  }

  @override
  Future<void> connect() async {
    final task = TelnetClient.startConnect(
      host: ip,
      port: port,
      onEvent: _onEvent,
      onError: _onError,
      onDone: _onDone,
    );
    // Wait the connection task finished.
    await task.waitDone();

    _client = task.client;
    _client?.onEvent;
    if (_client == null) {
      print("Fail to connect to ");
    } else {
      print("Successfully connect");
    }
  }

  @override
  Future<List<String>> run(List<String> commands) async {
    _initProcessors(commands);

    return await _streamController.stream.toList();
  }

  _initProcessors(commands) {
    _textMsgProcessor = TextMsgProcessor(_client!,
        login: login, password: password, commands: commands);
    _optMsgProcessor = OptMsgProcessor(_client!);
  }

  Future<void> _onEvent(TelnetClient? client, TLMsgEvent event) async {
    if (_textMsgProcessor.commands.isEmpty) return _streamController.close();
    if (event.type == TLMsgEventType.read) {
      if (event.msg is TLOptMsg) {
        _optMsgProcessor.run(event.msg);
      } else if (event.msg is TLTextMsg) {
        _streamController.add(_textMsgProcessor.run(event.msg));
      }
    }
  }

  void _onError(TelnetClient? client, dynamic error) {
    print("[ERROR] $error");
  }

  void _onDone(TelnetClient? client) {
    print("[DONE]");
  }
}
