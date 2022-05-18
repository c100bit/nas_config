import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/constants.dart';

enum Status { stopped, started }

class HomeController extends GetxController {
  final timeoutValues = [timeoutDefaultValue, 10, 20, 30];
  final threadsValues = [threadsDefaultValue, 10, 20, 30];

  final timeout = timeoutDefaultValue.obs;
  final threads = threadsDefaultValue.obs;
  final status = Status.stopped.obs;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  updateTimeout(int? val) => timeout(val ?? timeout.value);
  updateThreads(int? val) => threads(val ?? threads.value);
  updateStatus(Status val) => status(val);

  Future<void> perform() async {}

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
