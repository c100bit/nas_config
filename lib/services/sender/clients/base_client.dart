abstract class BaseClient {
  final String ip;
  final String login;
  final String password;
  final int port;
  final int timeout;

  Future<void> connect();
  Future<void> close();
  Future<List<String>> run(List<String> commands);

  BaseClient(
      {required this.ip,
      required this.login,
      required this.password,
      required this.timeout,
      required this.port});

  Future<List<String>> execute(List<String> commands) async {
    await connect();
    final result = await run(commands);
    await close();
    return result;
  }
}
