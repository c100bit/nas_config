import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/ui/widgets/shared/text_list_widget.dart';
import 'package:nas_config/ui/widgets/shared/wrap_widget.dart';

class LogsWidget extends GetView<HomeController> {
  final EdgeInsets? margin;

  const LogsWidget({Key? key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
      margin: margin,
      child: TextListWidget(
        controller: controller.logsController,
        title: 'logs_hint'.tr,
        readOnly: true,
        expands: true,
      ),
    );
  }
}
