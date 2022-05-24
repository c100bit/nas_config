import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_x;
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/ui/widgets/shared/text_list_widget.dart';
import 'package:nas_config/ui/widgets/shared/wrap_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LogsWidget extends get_x.GetView<HomeController> {
  const LogsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
        margin: EdgeInsets.only(
          left: ResponsiveValue<double>(context, defaultValue: 0, valueWhen: [
                const Condition.smallerThan(
                  name: TABLET,
                  value: defaultMargin,
                )
              ]).value ??
              0,
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
