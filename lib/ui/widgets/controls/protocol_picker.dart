import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/ui/widgets/shared/radio_widget.dart';

class ProtocolPicker extends StatelessWidget {
  final HomeController controller;
  const ProtocolPicker({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => RadioWidget<SettingsProtocol>(
        items: controller.appModel.protocolValues,
        onChanged: (val) => controller.updateProtocol(val),
        groupValue: controller.appModel.settings.protocol));
  }
}
