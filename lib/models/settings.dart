import 'package:nas_config/core/constants.dart';

enum SettingsProtocol { ssh, telnet }

class Settings {
  int threads;
  int timeout;
  SettingsProtocol protocol;
  String login;
  String password;

  Settings(
      {required this.threads,
      required this.timeout,
      required this.protocol,
      required this.login,
      required this.password});

  Settings.initDefault()
      : threads = threadsDefaultValue,
        timeout = timeoutDefaultValue,
        protocol = protocolDefaultValue,
        login = loginDefaultValue,
        password = passwordDefaultValue;

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      threads: json['threads'] as int,
      timeout: json['timeout'] as int,
      protocol: SettingsProtocol.values.byName(json['protocol']),
      login: json['login'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'threads': threads,
      'timeout': timeout,
      'protocol': protocol.name,
      'login': login,
      'password': password
    };
  }
}
