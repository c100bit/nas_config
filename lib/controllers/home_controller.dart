import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/services/storage_repository.dart';
import 'package:path/path.dart' as path;

enum Status { stopped, started }

class HomeController extends GetxController {
  final StorageRepository _storageRepository;
  late final Rx<AppModel> appModel;

  final status = Status.stopped.obs;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  HomeController(this._storageRepository);

  updateStatus(Status val) => status(val);

  Future<void> perform() async {
    updateStatus(Status.started);
  }

  void updateTimeout(int val) =>
      appModel.update((model) => model?.settings.timeout = val);

  void updateThreads(int val) =>
      appModel.update((model) => model?.settings.threads = val);

  @override
  void onInit() {
    appModel =
        (_storageRepository.readAppModel() ?? AppModel.initDefault()).obs;
    super.onInit();
  }

  @override
  void dispose() {
    print("Dispose");
    File(path.join(path.current, 'text.txt')).create(recursive: true);
    super.dispose();
  }

  @override
  void onClose() {
    print("Dispose1");
    _storageRepository.writeAppModel(appModel());
    print(_storageRepository.readAppModel());
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
