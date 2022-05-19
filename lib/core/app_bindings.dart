import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/services/storage_provider.dart';
import 'package:nas_config/services/storage_repository.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync(GetStorage.init);

    Get.put<HomeController>(
        HomeController(StorageRepository(StorageProvider())),
        permanent: true);
  }
}
