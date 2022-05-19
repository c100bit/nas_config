import 'dart:io';

import 'package:path/path.dart' as path;

class Config {
  static const _cfgDir = 'config';
  static const _naslist = 'nas-list.yml';

  late final List<String> nasList;
}
