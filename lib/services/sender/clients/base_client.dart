abstract class BaseClient {
  final String ip;
  final String login;
  final String password;
  final int port;
  final int timeout;
  final String welcome;
  final List<String> commands;

  Future<void> connect();
  Future<void> close();
  Future<List<String>> run();

  BaseClient(
      {required this.ip,
      required this.login,
      required this.password,
      required this.timeout,
      required this.welcome,
      required this.commands,
      required this.port});

  Future<List<String>> execute() async {
    await connect();
    final result = await run();
    await close();
    return result;
  }
}
