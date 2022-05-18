import 'package:get/get.dart';
import 'package:nas_config/home_controller.dart';

class ControllersBindings implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
