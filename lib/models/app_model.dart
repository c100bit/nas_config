import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/settings.dart';

class AppModel {
  List<String> commands;
  List<String> devices;
  Settings settings;

  final timeoutValues = timeoutSelectValues;
  final threadsValues = threadsSelectValues;

  AppModel({
    required this.commands,
    required this.devices,
    required this.settings,
  });

  AppModel.initDefault()
      : settings = Settings.initDefault(),
        devices = [],
        commands = [];

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
        commands: json['commands']?.cast<String>(),
        devices: json['devices']?.cast<String>(),
        settings: Settings.fromJson(json['settings']));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'devices': devices,
      'commands': commands,
      'settings': settings.toJson()
    };
  }
}
