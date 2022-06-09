class Event {
  final String ip;
  final String message;
  final String cmd;
  Event(this.ip, this.cmd, this.message);

  @override
  String toString() => '$cmd: $message';
}

class Failure {
  final String ip;
  final String message;
  Failure(this.ip, this.message);

  @override
  String toString() => message;
}
