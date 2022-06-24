import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/ui/widgets/logs/logs_button.dart';
import 'package:nas_config/ui/widgets/shared/text_list_widget.dart';
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
          TextListWidget(
            controller: controller.logsController,
            title: 'logs_hint'.tr,
            readOnly: true,
            expands: true,
          ),
          Obx(() => Visibility(
              visible: controller.logBtnActive,
              child: LogsButton(controller: controller))),
        ]),
      ),
    );
  }
}
