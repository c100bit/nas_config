import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/ui/widgets/shared/select_widget.dart';

class TimeoutPicker extends StatelessWidget {
  final HomeController controller;
  const TimeoutPicker({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SelectWidget<int>(
        title: 'timeout'.tr,
        value: controller.appModel.settings.timeout,
        items: controller.appModel.timeoutValues,
        onChanged: (val) => controller.updateTimeout(val)));
  }
}
