import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/ui/widgets/shared/controls_dialog.dart';
import 'package:nas_config/ui/widgets/shared/select_widget.dart';
import 'package:nas_config/ui/widgets/shared/wrap_widget.dart';

class ControlsWidget extends GetView<HomeController> {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Column(
                  children: [
                    Obx(() => SelectWidget<int>(
                        title: 'timeout'.tr,
                        value: controller.appModel.settings.timeout,
                        items: controller.appModel.timeoutValues,
                        onChanged: (val) => controller.updateTimeout(val))),
                    Obx(() => SelectWidget<int>(
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
                  child: Obx(() => Column(
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
                              groupValue: controller.appModel.settings.protocol,
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
                              groupValue: controller.appModel.settings.protocol,
                              onChanged: (val) =>
                                  controller.updateProtocol(val)),
                        ],
                      )),
                ),
                Expanded(
                  child: Column(children: [
                    DropdownButton<DeviceType>(
                        value: controller.appModel.settings.device,
                        items: DeviceType.values
                            .map((item) => DropdownMenuItem<DeviceType>(
                                value: item.name, child: Text(item.name)))
                            .toList(),
                        onChanged: (val) => controller.updateDevice(val)),
                    ElevatedButton(
                      onPressed: () =>
                          controller.perform(ControlsDialog(context)),
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Obx(() => Text(
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
      ),
    );
  }
}
