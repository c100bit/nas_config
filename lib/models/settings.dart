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
    mikrotikKeyWords,
  ),

  dlink(
    dlinkWelcome,
    dlinkCheckCmd,
    dlinkCheckStr,
    dlinkKeyWords,
  );

  final String welcome;
  final String checkCmd;
  final String checkStr;
  final List<String> keyWords;

  const DeviceType(
    this.welcome,
    this.checkCmd,
    this.checkStr,
    this.keyWords,
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
      protocol: SettingsProtocol.values.byName(json['protocol']),
      device: DeviceType.values.byName(json['device']),
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
