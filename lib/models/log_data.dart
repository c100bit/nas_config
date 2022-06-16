import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nas_config/core/constants.dart';

class LogData {
  final RxString _data;
  final Function doneCallback;
  final Function startCallback;

  IOSink? _logFile;

  LogData(
      {String initStr = '',
      required this.startCallback,
      required this.doneCallback})
      : _data = initStr.obs;

  void put(String value) => _data.value += value;
  void putToLog(String value) => _logFile?.write(value);

  String get data => _data.value;

  void _clear() => _data.value = '';

  void start() {
    _logFile = File(logFilePath).openWrite(mode: FileMode.append);
    _clear();
    _logFile?.write(_buildLogHeader());
    startCallback();
  }

  Future<void> done({byUser = false}) async {
    if (byUser) _logFile?.write(_buildCancel());
    await _logFile?.flush();
    await _logFile?.close();
    doneCallback();
  }

  String _buildLogHeader() {
    final time = DateFormat(logTimeFormat).format(DateTime.now());
    return '**************************$time*****************************\n';
  }

  String _buildCancel() => '[Canceled by user]\n\n';

  void addListener(Function(String) callback) => ever(_data, callback);
}
