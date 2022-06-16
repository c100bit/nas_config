class Errors {
  static const connectionFailure = 'Connection Failure';
  static const invalidAuth = 'Invalid Auth';
  static const invalidDevice = 'Invalid Device';
  static const timeoutError = 'Timeout Error';
}

abstract class AppError {
  String get message;

  @override
  String toString() => message;
}

class InvalidDeviceError extends AppError {
  @override
  String get message => Errors.invalidDevice;
}

class InvalidAuthError extends AppError {
  @override
  String get message => Errors.invalidAuth;
}
