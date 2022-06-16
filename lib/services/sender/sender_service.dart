import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/models/event.dart';
import 'package:nas_config/models/log_data.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/services/sender/clients/base_client.dart';
import 'package:nas_config/services/sender/compute_service.dart';
import 'package:nas_config/core/extensions/either_extension.dart';
import 'package:nas_config/core/extensions/string_extension.dart';

class SenderService extends GetxService {
  final ComputeService _computeService = Get.find<ComputeService>();
  late Settings _settings;

  void start(AppModel appModel, LogData logData) async {
    _settings = appModel.settings;
    final devices = _filterDevices(appModel.devices);

    for (var ip in devices) {
      final client = _initClient(ip, appModel.commands);
      _addCompute(client);
    }

    _computeService.execute(
        workersCount: _settings.threads,
        output: logData..start(),
        formatter: _formatResponse);
  }

  void stop() => _computeService.stop(byUser: true);

  _addCompute(BaseClient client) {
    _computeService.add(() async {
      return await client.execute();
    });
  }

  List<String> _formatResponse(EventList response) {
    final data = <String>[];
    final fullData = <String>[];
    final header = _buildFormattedHeader(response.first, _settings.device);

    data.add(header);
    fullData.add(header);

    for (var i in response) {
      i.fold((Failure f) {
        final error = _buildFormattedError(f);
        data.add(error);
        fullData.add(error);
      }, (Event e) {
        data.add(_buildFormattedCmd(e));
        fullData.add(_buildFormattedCmd(e, cut: false));
      });
    }
    data.add(_buildFormattedEnd());
    fullData.add(_buildFormattedEnd());

    return [data.join(), fullData.join()];
  }

  String _buildFormattedHeader(Either<Failure, Event> item, device) {
    final time = DateFormat(logTimeFormat).format(DateTime.now());
    final ip = item.isLeft() ? item.asLeft().ip : item.asRight().ip;
    return '[$ip][${device.toString().tr}][$time]\n';
  }

  String _buildFormattedEnd() => '\n';

  String _buildFormattedCmd(Event e, {bool cut = true}) {
    final msg = cut ? e.message.cutByLength(length: 500) : e.message;
    return '[Command] ${e.cmd}\n[Result] ${msg.trim()}\n';
  }

  String _buildFormattedError(Failure f) => 'Failure: ${f.message}\n';

  Devices _filterDevices(Devices devices) {
    final filtered = devices.toSet().map((e) => e.trim()).toList();
    filtered.removeWhere((e) => e.isEmpty);
    return filtered;
  }

  BaseClient _initClient(String ip, Commands commands) {
    return BaseClient.initClient(
        settings: _settings, ip: ip, commands: commands);
  }
}
