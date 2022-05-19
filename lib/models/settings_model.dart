class SettingsModel {
  late final List<String> commands;
  late final List<String> devices;
  late final Settings settings;

  SettingsModel();

  SettingsModel.fromJson(Map<String, dynamic> json) {
    commands = json['commands'];
    devices = json['devices'];
    settings = json['settings'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['devices'] = devices;
    data['commands'] = commands;
    data['settings'] = settings;

    return data;
  }
}

class Settings {
  final int threads;
  final int timeout;
  final String login;
  final String password;

  Settings(
      {required this.threads,
      required this.timeout,
      required this.login,
      required this.password});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      threads: json['threads'] as int,
      timeout: json['timeout'] as int,
      login: json['login'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['threads'] = threads;
    data['timeout'] = timeout;
    data['login'] = login;
    data['password'] = password;

    return data;
  }
}
