import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/widgets/shared/text_list_widget.dart';
import 'package:nas_config/widgets/shared/wrap_widget.dart';

class CommandsWidget extends GetView<HomeController> {
  const CommandsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
        child: TextListWidget(
      controller: controller.commandsController,
      title: 'commands_list_hint'.tr,
      expands: true,
    ));
  }
}
