import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';

typedef VoidCallback = void Function();

class InfoDialog {
  final BuildContext context;

  InfoDialog(this.context);

  void show() => Get.defaultDialog(
      title: 'info_dialog_title'.tr,
      titleStyle: Theme.of(context).textTheme.caption,
      middleText: 'info_dialog_text'.tr,
      backgroundColor: Theme.of(context).canvasColor,
      middleTextStyle: Theme.of(context).textTheme.bodyText2,
      contentPadding: const EdgeInsets.only(
        left: defaultPadding,
        bottom: defaultPadding,
        right: defaultPadding,
      ),
      confirm: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1.0, color: Theme.of(context).focusColor),
        ),
        onPressed: () {
          Get.back();
        },
        child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text('ok'.tr)),
      ),
      radius: defaultRadius);
}
