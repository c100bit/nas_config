import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/services/storage_repository.dart';

enum Status { stopped, started }

class HomeController extends GetxController {
  final StorageRepository _storageRepository;
  late final Rx<AppModel> appModel;

  final settingsChangedInterval = const Duration(milliseconds: 1000);

  final status = Status.stopped.obs;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final devicesController = TextEditingController();
  final commandsController = TextEditingController();
  final logsController = TextEditingController();

  HomeController(this._storageRepository);

  updateStatus(Status val) => status(val);

  Future<void> perform() async {
    Get.defaultDialog(
        title: 'Остановить?',
        middleText: "",
        backgroundColor: secondaryColor,
        titleStyle: TextStyle(color: textColor),
        middleTextStyle: TextStyle(color: textColor),
        textConfirm: "Confirm",
        textCancel: "Cancel",
        radius: defaultRadius);

    updateStatus(Status.started);
  }

  void updateTimeout(int? val) => appModel.update((model) =>
      model?.settings.timeout = val ?? appModel.value.timeoutValues.first);

  void updateThreads(int? val) => appModel.update((model) =>
      model?.settings.threads = val ?? appModel.value.threadsValues.first);

  @override
  void onInit() {
    final appDefault = AppModel.initDefault();
    appModel = (_storageRepository.readAppModel() ?? appDefault).obs;

    debounce(
        appModel, (AppModel model) => _storageRepository.writeAppModel(model),
        time: settingsChangedInterval);

    _initControllersValues();
    _initControllersListeners();

    super.onInit();
  }

  _initControllersValues() {
    devicesController.text = appModel.value.devices.join('\n');
    commandsController.text = appModel.value.commands.join('\n');
    loginController.text = appModel.value.settings.login;
    passwordController.text = appModel.value.settings.password;
  }

  _initControllersListeners() {
    devicesController.addListener(() => appModel.update(
        (model) => model?.devices = _clearTextList(devicesController.text)));

    commandsController.addListener(() => appModel.update(
        (model) => model?.commands = _clearTextList(commandsController.text)));

    loginController.addListener(() => appModel
        .update((model) => model?.settings.login = loginController.text));

    passwordController.addListener(() => appModel
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
