import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/ui/widgets/shared/controls_dialog.dart';

class StartButton extends StatelessWidget {
  final HomeController controller;
  const StartButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.perform(ControlsDialog(context)),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Obx(() => Text(
              controller.startedPerform() ? 'stop'.tr : 'start'.tr,
            )),
      ),
    );
  }
}
