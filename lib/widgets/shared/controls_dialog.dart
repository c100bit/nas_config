import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';

typedef VoidCallback = void Function();

class ControlsDialog {
  final BuildContext context;

  ControlsDialog(this.context);

  void startDialog(VoidCallback confirm) =>
      _innerDialog(confirm, stopAction: false);

  void stopDialog(VoidCallback confirm) =>
      _innerDialog(confirm, stopAction: true);

  _innerDialog(VoidCallback confirm, {stopAction = false}) => Get.defaultDialog(
      title: 'controls_dialog_title'.tr,
      titleStyle: Theme.of(context).textTheme.caption,
      middleText: stopAction ? 'dialog_stop_text'.tr : 'dialog_start_text'.tr,
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
          confirm();
          Get.back();
        },
        child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text('confirm'.tr)),
      ),
      cancel: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1.0, color: Theme.of(context).focusColor),
        ),
        onPressed: () => Get.back(),
        child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text('cancel'.tr)),
      ),
      radius: defaultRadius);
}
