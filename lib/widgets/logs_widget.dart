import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/widgets/shared/text_list_widget.dart';
import 'package:nas_config/widgets/shared/wrap_widget.dart';

class LogsWidget extends GetView<HomeController> {
  const LogsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
        margin: const EdgeInsets.only(
          left: 0,
          right: defaultMargin,
          bottom: defaultMargin,
          top: 0,
        ),
        child: TextListWidget(
          controller: controller.logsController,
          title: 'logs_hint'.tr,
          readOnly: true,
          expands: true,
        ));
  }
}
