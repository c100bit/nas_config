part of 'base_client.dart';

class AppTelnetClient extends BaseClient {
  static const _port = 23;
  late final ITelnetClient? _client;
  late final TextMsgProcessor _textMsgProcessor;
  late final OptMsgProcessor _optMsgProcessor;

  AppTelnetClient(
      {required super.ip,
      required super.login,
      required super.password,
      required super.timeout,
      super.port = _port});

  @override
  Future<void> _close() async {
    await _client?.terminate();
  }

  @override
  Future<void> _connect() async {
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

    if (_client == null) {
      print("Fail to connect to ");
    } else {
      _textMsgProcessor = TextMsgProcessor(_client!);
      _optMsgProcessor = OptMsgProcessor(_client!);
      print("Successfully connect");
    }
  }

  @override
  Future<String> _run(String command) async {
    await Future.delayed(Duration(seconds: 2));
    return 'done';
  }

  void _onEvent(TelnetClient? client, TLMsgEvent event) {
    if (event.type == TLMsgEventType.read) {
      if (event.msg is TLOptMsg) {
        _optMsgProcessor.run(event.msg);
      } else if (event.msg is TLTextMsg) {
        _textMsgProcessor.run(event.msg);
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
