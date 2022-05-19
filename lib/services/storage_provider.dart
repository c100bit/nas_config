import 'dart:convert';

import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/settings_model.dart';
import 'package:nas_config/services/storage_service.dart';

class StorageProvider {
  final StorageService _storageService = Get.find<StorageService>();

  void writeSettings(SettingsModel settings) {
    _storageService.write(settingsKey, jsonEncode(settings));
  }

  SettingsModel readSettings() {
    return SettingsModel();
  }
}
