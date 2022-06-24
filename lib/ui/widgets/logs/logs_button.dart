import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/core/constants.dart';

class LogsButton extends StatelessWidget {
  final HomeController controller;
  const LogsButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.openLogsFile(),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SizedBox(
            child: Text(
          'open_logs'.tr,
          style: Theme.of(context).textTheme.bodyText2,
        )),
      ),
    );
  }
}
