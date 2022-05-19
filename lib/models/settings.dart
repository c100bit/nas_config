import 'package:nas_config/core/constants.dart';

class Settings {
  int threads;
  int timeout;
  final String login;
  final String password;

  Settings(
      {required this.threads,
      required this.timeout,
      required this.login,
      required this.password});

  Settings.initDefault()
      : threads = threadsDefaultValue,
        timeout = timeoutDefaultValue,
        login = '',
        password = '';

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      threads: json['threads'] as int,
      timeout: json['timeout'] as int,
      login: json['login'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'threads': threads,
      'timeout': timeout,
      'login': login,
      'password': password
    };
  }
}
