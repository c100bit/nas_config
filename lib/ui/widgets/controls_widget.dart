import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_x;
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/ui/widgets/shared/controls_dialog.dart';
import 'package:nas_config/ui/widgets/shared/select_widget.dart';
import 'package:nas_config/ui/widgets/shared/wrap_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ControlsWidget extends get_x.GetView<HomeController> {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
        margin: ResponsiveValue<EdgeInsets>(context,
            defaultValue: const EdgeInsets.only(bottom: defaultMargin),
            valueWhen: [
              const Condition.smallerThan(
                name: TABLET,
                value: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                  bottom: defaultMargin,
                ),
              )
            ]).value,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: Column(
                    children: [
                      get_x.Obx(() => SelectWidget<int>(
                          title: 'timeout'.tr,
                          value: controller.appModel.settings.timeout,
                          items: controller.appModel.timeoutValues,
                          onChanged: (val) => controller.updateTimeout(val))),
                      get_x.Obx(() => SelectWidget<int>(
                          title: 'threads'.tr,
                          value: controller.appModel.settings.threads,
                          items: controller.appModel.threadsValues,
                          onChanged: (val) => controller.updateThreads(val))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: controller.loginController,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(labelText: 'login'.tr),
                      ),
                      TextField(
                        obscureText: true,
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: controller.passwordController,
                        decoration: InputDecoration(labelText: 'password'.tr),
                      ),
                    ],
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                    child: get_x.Obx(() => Column(
                          children: [
                            RadioListTile<SettingsProtocol>(
                                title: Text(
                                  'ssh'.tr,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                value: SettingsProtocol.ssh,
                                dense: true,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -2),
                                activeColor: textColor,
                                groupValue:
                                    controller.appModel.settings.protocol,
                                onChanged: (val) =>
                                    controller.updateProtocol(val)),
                            RadioListTile<SettingsProtocol>(
                                title: Text(
                                  'telnet'.tr,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                dense: true,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -2),
                                contentPadding: const EdgeInsets.all(0),
                                activeColor: textColor,
                                value: SettingsProtocol.telnet,
                                groupValue:
                                    controller.appModel.settings.protocol,
                                onChanged: (val) =>
                                    controller.updateProtocol(val)),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () =>
                            controller.perform(ControlsDialog(context)),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: get_x.Obx(() => Text(
                                controller.status == Status.stopped
                                    ? 'start'.tr
                                    : 'stop'.tr,
                              )),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
