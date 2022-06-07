import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/ui/widgets/shared/text_list_widget.dart';
import 'package:nas_config/ui/widgets/shared/wrap_widget.dart';

class CommandsWidget extends GetView<HomeController> {
  final EdgeInsets? margin;

  const CommandsWidget({Key? key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
      margin: margin,
      child: TextListWidget(
          controller: controller.commandsController,
          title: 'commands_list_hint'.tr,
          expands: true),
    );
  }
}
