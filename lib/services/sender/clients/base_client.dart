abstract class BaseClient {
  final String ip;
  final String login;
  final String password;
  final int port;

  Future<void> _init();
  Future<String> _run(String command);

  BaseClient(
      {required this.ip,
      required this.login,
      required this.password,
      required this.port});

  Future<List<String>> execute(List<String> commands) async {
    final totalResult = <String>[];
    for (var command in commands) {
      final result = await _run(command);
      totalResult.add(result);
    }
    return totalResult;
  }
}
