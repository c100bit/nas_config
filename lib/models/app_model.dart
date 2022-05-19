import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/settings.dart';

class AppModel {
  final List<String> commands;
  final List<String> devices;
  final Settings settings;

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
        commands: json['commands'],
        devices: json['devices'],
        settings: json['settings']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'devices': devices,
      'commands': commands,
      'settings': settings
    };
  }
}
