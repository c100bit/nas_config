import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/services/logs_service.dart';

class LogData {
  final RxString _data;
  final Function doneCallback;
  final Function startCallback;

  final LogsService _logsService = Get.find<LogsService>();

  LogData(
      {String initStr = '',
      required this.startCallback,
      required this.doneCallback})
      : _data = initStr.obs;

  void put(String value) => _data.value = value;

  void putToLog(String value) => _logsService.write(value);

  String get data => _data.value;

  void start() {
    _logsService.open();
    _logsService.write(_buildLogHeader());
    startCallback();
  }

  Future<void> done({byUser = false}) async {
    if (byUser) _logsService.write(_buildCancel());
    await _logsService.close();
    doneCallback();
  }

  String _buildLogHeader() {
    final time = DateFormat(logTimeFormat).format(DateTime.now());
    return '**************************$time*****************************\n';
  }

  String _buildCancel() => '[Canceled by user]\n\n';

  void addListener(Function(String) callback) => ever(_data, callback);
}
