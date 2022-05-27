import 'dart:async';

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

  var isProccessedClient = false;

  AppTelnetClient(
      {required super.ip,
      required super.login,
      required super.password,
      required super.welcome,
      required super.timeout,
      required super.commands,
      super.port = _port}) {
    _textMsgProcessor
      ..addCommands(commands)
      ..addWelcome(welcome)
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
      print("Success to connect to ");
    }
  }

  @override
  Future<List<String>> run() async {
    _dataController.stream.listen((event) {
      print(event);
    });
    return await Future.delayed(Duration(seconds: 5));
  }

  Future<void> _onEvent(TelnetClient? client, TLMsgEvent event) async {
    if (client == null) return;

    if (isProccessedClient) {
      _textMsgProcessor.addClient(client);
      _optMsgProcessor.addClient(client);
    }

    if (event.type == TLMsgEventType.read) {
      if (event.msg is TLOptMsg) {
        _optMsgProcessor.run(event.msg);
      } else if (event.msg is TLTextMsg) {
        if (_textMsgProcessor.commands.isEmpty) return _dataController.close();
        _dataController.add(_textMsgProcessor.run(event.msg));
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
