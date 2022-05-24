part of 'base_client.dart';

class AppSSHClient extends BaseClient {
  static const _port = 22;
  late final SSHClient client;

  AppSSHClient(
      {required super.ip,
      required super.login,
      required super.password,
      required super.timeout,
      super.port = _port});

  @override
  Future<void> _connect() async {
    print('_connect');
    client = SSHClient(
      await SSHSocket.connect(
        ip,
        port,
        timeout: Duration(seconds: timeout),
      ),
      username: login,
      onPasswordRequest: () => password,
    );
  }

  @override
  Future<String> _run(String command) async {
    print('_run');
    final result = await client.run(command);
    return utf8.decode(result);
  }

  @override
  Future<void> _close() async {
    print('close');
    client.close();
    await client.done;
  }
}
