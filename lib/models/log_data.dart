import 'package:get/get.dart';

class LogData {
  final RxString _data;

  LogData({String initStr = ''}) : _data = initStr.obs;

  void put(String value) => _data.value += value;
  void clear(String value) => _data.value = '';

  String get data => _data.value;

  void addListener(Function(String) callback) => ever(_data, callback);
}
