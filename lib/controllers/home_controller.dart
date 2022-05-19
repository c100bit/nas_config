import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/settings_model.dart';
import 'package:nas_config/services/storage_repository.dart';

enum Status { stopped, started }

class HomeController extends GetxController {
  final StorageRepository _storageRepository;
  late final SettingsModel _settingsModel;

  final timeoutValues = [timeoutDefaultValue, 10, 20, 30];
  final threadsValues = [threadsDefaultValue, 10, 20, 30];

  final timeout = timeoutDefaultValue.obs;
  final threads = threadsDefaultValue.obs;
  final status = Status.stopped.obs;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  HomeController(this._storageRepository);

  updateTimeout(int? val) => timeout(val ?? timeout.value);
  updateThreads(int? val) => threads(val ?? threads.value);
  updateStatus(Status val) => status(val);

  Future<void> perform() async {
    updateStatus(Status.started);
  }

  @override
  void onInit() {
    _settingsModel = _storageRepository.readSettings();
    super.onInit();
  }

  @override
  void onClose() {
    _storageRepository.writeSettings(_settingsModel);
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
