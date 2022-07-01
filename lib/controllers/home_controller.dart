import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/models/log_data.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/services/logs_service.dart';
import 'package:nas_config/services/sender/sender_service.dart';
import 'package:nas_config/services/storage/storage_repository.dart';
import 'package:nas_config/ui/widgets/shared/controls_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

enum Status { stopped, started }

class HomeController extends GetxController {
  final StorageRepository _storageRepository;
  final SenderService _senderService;
  final LogsService _logsService = Get.find<LogsService>();

  late final Rx<AppModel> _appModel;
  AppModel get appModel => _appModel.value;

  final settingsChangedInterval = const Duration(milliseconds: 1000);

  final _logBtnActive = false.obs;
  get logBtnActive => _logBtnActive.value;

  final _status = Status.stopped.obs;
  get status => _status.value;
  updateStatus(Status val) => _status(val);

  late LogData _logData;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final devicesController = TextEditingController();
  final commandsController = TextEditingController();

  final _logsText = <String>[].obs;

  HomeController(this._storageRepository, this._senderService);

  void perform(ControlsDialog dialog) {
    status == Status.stopped
        ? dialog.startDialog(_startPerforming)
        : dialog.stopDialog(_stopPerforming);
  }

  void _startPerforming() => _senderService.start(appModel, _logData);
  void _stopPerforming() => _senderService.stop();

  void updateProtocol(SettingsProtocol? val) => _appModel.update(
      (model) => model?.settings.protocol = val ?? SettingsProtocol.ssh);

  void updateTimeout(int? val) => _appModel.update((model) =>
      model?.settings.timeout = val ?? _appModel.value.timeoutValues.first);

  void updateThreads(int? val) => _appModel.update((model) =>
      model?.settings.threads = val ?? _appModel.value.threadsValues.first);

  void updateDevice(DeviceType? val) => _appModel.update((model) =>
      model?.settings.device = val ?? _appModel.value.deviceValues.first);

  void showLogBtn() => _logBtnActive.value = true;
  void hideLogBtn() => _logBtnActive.value = false;

  Future<void> openLogsFile() async {
    final url = _logsService.fileUrl();
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  bool startedPerform() => status == Status.started;

  RxList<String> get logsText => _logsText;

  @override
  void onInit() {
    final appDefault = AppModel.initDefault();
    _appModel = (_storageRepository.readAppModel() ?? appDefault).obs;

    _logData = LogData(
        doneCallback: () => updateStatus(Status.stopped),
        startCallback: () => updateStatus(Status.started));

    _logData.addListener((String val) => {_logsText.add(val)});

    debounce(
        _appModel, (AppModel model) => _storageRepository.writeAppModel(model),
        time: settingsChangedInterval);

    _initControllersValues();
    _initControllersListeners();

    super.onInit();
  }

  _initControllersValues() {
    devicesController.text = _appModel.value.devices.join('\n');
    commandsController.text = _appModel.value.commands.join('\n');
    loginController.text = _appModel.value.settings.login;
    passwordController.text = _appModel.value.settings.password;
  }

  _initControllersListeners() {
    devicesController.addListener(() => _appModel.update(
        (model) => model?.devices = _clearTextList(devicesController.text)));

    commandsController.addListener(() => _appModel.update(
        (model) => model?.commands = _clearTextList(commandsController.text)));

    loginController.addListener(() => _appModel
        .update((model) => model?.settings.login = loginController.text));

    passwordController.addListener(() => _appModel
        .update((model) => model?.settings.password = passwordController.text));
  }

  List<String> _clearTextList(String text) {
    final list = text.split('\n');
    list.removeWhere((e) => e.isEmpty);
    return list;
  }

  @override
  void onClose() {
    devicesController.dispose();
    commandsController.dispose();
    loginController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
