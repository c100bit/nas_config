import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/services/storage_provider.dart';
import 'package:nas_config/services/storage_repository.dart';
import 'package:nas_config/services/storage_service.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<StorageService>(StorageService.init, permanent: true);

    Get.put<HomeController>(
      HomeController(StorageRepository(StorageProvider())),
    );
  }
}
