import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/ui/widgets/logs/logs_button.dart';
import 'package:nas_config/ui/widgets/shared/wrap_widget.dart';

class LogsWidget extends GetView<HomeController> {
  final EdgeInsets? margin;

  const LogsWidget({Key? key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
      margin: margin,
      child: MouseRegion(
        onEnter: (_) => controller.showLogBtn(),
        onExit: (_) => controller.hideLogBtn(),
        child: Stack(alignment: AlignmentDirectional.topEnd, children: [
          SizedBox(
              width: double.infinity,
              child: Obx(() => SelectableText(controller.logsText.join()))),
          Obx(() => Visibility(
              visible: controller.logBtnActive,
              child: LogsButton(controller: controller))),
        ]),
      ),
    );
  }
}
