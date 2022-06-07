import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/ui/widgets/controls/device_picker.dart';
import 'package:nas_config/ui/widgets/controls/login_input.dart';
import 'package:nas_config/ui/widgets/controls/password_input.dart';
import 'package:nas_config/ui/widgets/controls/protocol_picker.dart';
import 'package:nas_config/ui/widgets/controls/start_button.dart';
import 'package:nas_config/ui/widgets/controls/thread_picker.dart';
import 'package:nas_config/ui/widgets/controls/timeout_picker.dart';
import 'package:nas_config/ui/widgets/shared/wrap_widget.dart';

class ControlsWidget extends GetView<HomeController> {
  final EdgeInsets? margin;

  const ControlsWidget({Key? key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
      margin: margin,
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: Column(children: [
                    TimeoutPicker(controller: controller),
                    ThreadPicker(controller: controller),
                  ]),
                ),
                Expanded(child: DevicePicker(controller: controller)),
                Expanded(child: ProtocolPicker(controller: controller))
              ],
            ),
            Row(children: [
              Expanded(child: LoginInput(controller: controller)),
              const SizedBox(width: defaultPadding * 2),
              Expanded(child: PasswordInput(controller: controller)),
            ]),
            const SizedBox(height: defaultPadding * 2),
            StartButton(controller: controller),
          ]),
        ),
      ),
    );
  }
}
