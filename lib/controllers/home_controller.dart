import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/models/log_data.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/services/sender/sender_service.dart';
import 'package:nas_config/services/storage/storage_repository.dart';
import 'package:nas_config/ui/widgets/shared/controls_dialog.dart';

enum Status { stopped, started }

class HomeController extends GetxController {
  final StorageRepository _storageRepository;
  final SenderService _senderService;

  late final Rx<AppModel> _appModel;
  AppModel get appModel => _appModel.value;

  final settingsChangedInterval = const Duration(milliseconds: 1000);

  final _status = Status.stopped.obs;
  get status => _status.value;
  updateStatus(Status val) => _status(val);

  final _logData = LogData();

  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final devicesController = TextEditingController();
  final commandsController = TextEditingController();
  final logsController = TextEditingController();

  HomeController(this._storageRepository, this._senderService);

  void perform(ControlsDialog dialog) {
    status == Status.stopped
        ? dialog.startDialog(_startPerforming)
        : dialog.stopDialog(_stopPerforming);
  }

  void _startPerforming() {
    print('startPerforming');
    _senderService.run(appModel, _logData);
    updateStatus(Status.started);
  }

  void _stopPerforming() {
    print('stopPerforming');
    _senderService.stop();
    updateStatus(Status.stopped);
  }

  void updateProtocol(SettingsProtocol? val) => _appModel.update(
      (model) => model?.settings.protocol = val ?? SettingsProtocol.ssh);

  void updateTimeout(int? val) => _appModel.update((model) =>
      model?.settings.timeout = val ?? _appModel.value.timeoutValues.first);

  void updateThreads(int? val) => _appModel.update((model) =>
      model?.settings.threads = val ?? _appModel.value.threadsValues.first);

  void updateDevice(DeviceType? val) => _appModel
      .update((model) => model?.settings.device = val ?? DeviceType.miktorik);

  @override
  void onInit() {
    final appDefault = AppModel.initDefault();
    _appModel = (_storageRepository.readAppModel() ?? appDefault).obs;

    _logData.addListener((String val) => logsController.text = val);

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
    logsController.dispose();
    devicesController.dispose();
    commandsController.dispose();
    loginController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
