import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/widgets/shared/text_list_widget.dart';
import 'package:nas_config/widgets/shared/wrap_widget.dart';

class CommandsWidget extends StatelessWidget {
  const CommandsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
        child: TextListWidget(
      title: 'commands_list_hint'.tr,
      expands: true,
    ));
  }
}
