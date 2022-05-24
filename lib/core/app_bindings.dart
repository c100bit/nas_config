import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/services/sender/compute_service.dart';
import 'package:nas_config/services/sender/sender_provider.dart';
import 'package:nas_config/services/sender/sender_service.dart';
import 'package:nas_config/services/storage/storage_provider.dart';
import 'package:nas_config/services/storage/storage_repository.dart';
import 'package:nas_config/services/storage/storage_service.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<StorageService>(StorageService.init, permanent: true);

    Get.put(ComputeService(), permanent: true);
    Get.put(SenderService(), permanent: true);

    Get.put<HomeController>(
        HomeController(StorageRepository(StorageProvider()), SenderProvider()),
        permanent: true);
  }
}
