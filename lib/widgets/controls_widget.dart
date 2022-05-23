import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/widgets/shared/select_widget.dart';
import 'package:nas_config/widgets/shared/wrap_widget.dart';

class ControlsWidget extends GetView<HomeController> {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapWidget(
        margin: const EdgeInsets.only(bottom: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Expanded(
                child: Column(
                  children: [
                    Obx(() => SelectWidget<int>(
                        title: 'timeout'.tr,
                        value: controller.appModel().settings.timeout,
                        items: controller.appModel().timeoutValues,
                        onChanged: (val) => controller.updateTimeout(val))),
                    Obx(() => SelectWidget<int>(
                        title: 'threads'.tr,
                        value: controller.appModel().settings.threads,
                        items: controller.appModel().threadsValues,
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
            ElevatedButton(
              onPressed: controller.perform,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Obx(() => Text(
                      controller.status.value == Status.stopped
                          ? 'start'.tr
                          : 'stop'.tr,
                    )),
              ),
            ),
          ],
        ));
  }
}
