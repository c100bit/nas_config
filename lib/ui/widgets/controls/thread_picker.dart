import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/ui/widgets/shared/select_widget.dart';

class ThreadPicker extends StatelessWidget {
  final HomeController controller;
  const ThreadPicker({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SelectWidget<int>(
        title: 'threads'.tr,
        value: controller.appModel.settings.threads,
        items: controller.appModel.threadsValues,
        onChanged: (val) => controller.updateThreads(val)));
  }
}
