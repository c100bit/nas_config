import 'package:get/get.dart';

class HomeController extends GetxController {
  final timeoutValues = [5, 10, 20, 30];
  final threadsValues = [5, 10, 20, 30];

  final timeout = 0.obs;
  final threads = 0.obs;

  updateTimeout(int? val) => timeout(val ?? 0);
  updateThreads(int? val) => threads(val ?? 0);
}
