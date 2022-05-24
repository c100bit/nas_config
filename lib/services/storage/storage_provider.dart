import 'dart:convert';

import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/services/storage/storage_service.dart';

class StorageProvider {
  final StorageService _storageService = Get.find<StorageService>();

  void writeAppModel(AppModel model) {
    _storageService.write(appModelKey, jsonEncode(model));
  }

  AppModel? readAppModel() {
    final data = _storageService.read(appModelKey);
    return data != null ? AppModel.fromJson(jsonDecode(data)) : null;
  }
}
