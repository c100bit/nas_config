import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

@singleton
class Config {
  static const _cfgDir = 'config';
  static const _naslist = 'nas-list.yml';

  late final List<String> nasList;

  @factoryMethod
  static Future<Config> init() async {
    final config = Config();
    await config._initNas();
    return config;
  }

  Future<void> _initNas() async {
    nasList = await _loadConfigFile<List<String>>(_naslist);
  }

  Future<T> _loadConfigFile<T>(String name) async {
    final file = File(path.join(path.current, _cfgDir, name));
    return loadYaml(await file.readAsString());
  }
}
