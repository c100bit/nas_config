import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/widgets/shared/text_list_widget.dart';
import 'package:nas_config/widgets/shared/wrap_widget.dart';

class LogsWidget extends StatelessWidget {
  const LogsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
        child: TextListWidget(
      title: 'logs_hint'.tr,
      readOnly: true,
      expands: true,
    ));
  }
}
