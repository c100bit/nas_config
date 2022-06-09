import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nas_config/core/constants.dart';

class LogData {
  final RxString _data;
  final Function doneCallback;
  final _logFile = File(logFilePath).openWrite(mode: FileMode.append);

  LogData({String initStr = '', required this.doneCallback})
      : _data = initStr.obs {
    _logFile.write(_buildLogHeader());
  }

  void put(String value) => _data.value += value;
  void putToLog(String value) => _logFile.write(value);

  String get data => _data.value;

  void clear() => _data.value = '';

  Future<void> done() async {
    await _logFile.flush();
    await _logFile.close();
    doneCallback();
  }

  String _buildLogHeader() {
    final time = DateFormat(logTimeFormat).format(DateTime.now());
    return '**************************$time*****************************\n';
  }

  void addListener(Function(String) callback) => ever(_data, callback);
}
