import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/ui/widgets/shared/radio_widget.dart';

class DevicePicker extends StatelessWidget {
  final HomeController controller;
  const DevicePicker({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => RadioWidget<DeviceType>(
        items: controller.appModel.deviceValues,
        onChanged: (val) => controller.updateDevice(val),
        groupValue: controller.appModel.settings.device));
  }
}
