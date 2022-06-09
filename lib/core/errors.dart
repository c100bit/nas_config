import 'package:dartssh2/dartssh2.dart';

class Errors {
  static const connectionFailure = 'Connection Failure';
  static const invalidAuth = 'Invalid auth';
  static const invalidDevice = 'Invalid device';
  static sshError(SSHError error) => 'SSHError - $error';
}
