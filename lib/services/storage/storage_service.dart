import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final GetStorage _box;

  StorageService(this._box);

  static Future<StorageService> init() async {
    await GetStorage.init();
    return StorageService(GetStorage());
  }

  String? read(String key) {
    return _box.read<String>(key);
  }

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
