import 'package:nas_config/core/constants.dart';

enum SettingsProtocol {
  ssh,
  telnet;

  @override
  String toString() => name;
}

enum DeviceType {
  miktorik(
    mikrotikWelcome,
    mikrotikCheckCmd,
    mikrotikCheckStr,
    mikrotikKeywords,
  ),

  dlink(
    dlinkWelcome,
    dlinkCheckCmd,
    dlinkCheckStr,
    dlinkKeywords,
  );

  final String welcome;
  final String checkCmd;
  final String checkStr;
  final List<String> keywords;

  const DeviceType(
    this.welcome,
    this.checkCmd,
    this.checkStr,
    this.keywords,
  );

  @override
  String toString() => name;
}

class Settings {
  int threads;
  int timeout;
  SettingsProtocol protocol;
  DeviceType device;
  String login;
  String password;

  Settings(
      {required this.threads,
      required this.timeout,
      required this.protocol,
      required this.device,
      required this.login,
      required this.password});

  Settings.initDefault()
      : threads = threadsDefaultValue,
        timeout = timeoutDefaultValue,
        protocol = protocolDefaultValue,
        device = deviceDefaultValue,
        login = loginDefaultValue,
        password = passwordDefaultValue;

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      threads: json['threads'] as int,
      timeout: json['timeout'] as int,
      protocol:
          protocolDefaultValue, // SettingsProtocol.values.byName(json['protocol']),
      device: deviceDefaultValue, // DeviceType.values.byName(json['device']),
      login: json['login'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'threads': threads,
      'timeout': timeout,
      'protocol': protocol.name,
      'device': device.name,
      'login': login,
      'password': password
    };
  }
}
