part of 'base_client.dart';

class AppTelnetClient extends BaseClient {
  static const _port = 23;

  AppTelnetClient(
      {required super.ip,
      required super.login,
      required super.password,
      required super.timeout,
      super.port = _port});

  @override
  Future<void> _close() {
    // TODO: implement _close
    throw UnimplementedError();
  }

  @override
  Future<void> _connect() {
    // TODO: implement _connect
    throw UnimplementedError();
  }

  @override
  Future<String> _run(String command) {
    // TODO: implement _run
    throw UnimplementedError();
  }
}
