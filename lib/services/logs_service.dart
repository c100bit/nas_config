import 'dart:io';

import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LogsService extends GetxService {
  final String _logFilePath;
  IOSink? _logFile;

  LogsService(this._logFilePath);

  static Future<LogsService> init() async {
    final tempDir = await getTemporaryDirectory();
    final fullPath = path.join(tempDir.path, logFileName);
    return LogsService(fullPath);
  }

  void open() => _logFile = File(_logFilePath).openWrite(mode: FileMode.append);

  Future<void> close() async {
    await _logFile?.flush();
    await _logFile?.close();
  }

  Uri fileUrl() => Uri.parse('file:$_logFilePath');

  void write(String data) => _logFile?.write(data);
}
