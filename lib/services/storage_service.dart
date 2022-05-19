import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_config/core/constants.dart';

class StorageService extends GetxService {
  late final GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  String? read(String key) {
    return _box.read<String>(key);
  }

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
