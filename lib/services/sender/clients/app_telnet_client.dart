import 'dart:async';

import 'package:nas_config/models/log_data.dart';
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
      timeout: Duration(seconds: timeout),
      onEvent: _onEvent,
      onError: _onError,
      onDone: _onDone,
    );
    // Wait the connection task finished.
    await task.waitDone();

    _client = task.client;
    _client?.onEvent;

    if (_client == null) {
      _dataController.add(Failure('Connection failure').message);
      _dataController.close();
    } else {
      print('Successful connection to $ip');
    }
  }

  @override
  Future<List<String>> run() async {
    Future.delayed(Duration(seconds: timeout), () {
      _dataController
          .add('[${_textMsgProcessor.currentDevice()}] Response timeout error');
      close();
    });
    return await _dataController.stream.toList();
  }

  Future<void> _onEvent(TelnetClient? client, TLMsgEvent event) async {
    if (client == null) return;

    _textMsgProcessor.updateClient(client);
    _optMsgProcessor.updateClient(client);

    if (event.type == TLMsgEventType.read) {
      if (event.msg is TLOptMsg) {
        _optMsgProcessor.run(event.msg);
      } else if (event.msg is TLTextMsg) {
        if (_textMsgProcessor.commands.isEmpty) {
          _dataController.add(
              '[${_textMsgProcessor.currentDevice()}] Successful connection');
          return _dataController.close();
        }
        final result = _textMsgProcessor.run(event.msg);

        result.fold((failure) {
          _dataController.add(failure.message);
          _dataController.close();
        }, (data) {});
      }
    }
  }

  void _onError(TelnetClient? client, dynamic error) {
    print("[ERROR] $error");
  }

  void _onDone(TelnetClient? client) {
    _dataController.close();
  }
}
