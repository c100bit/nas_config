import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_title'.tr),
        centerTitle: true,
        backgroundColor: bgColor,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.light)),
          IconButton(onPressed: () {}, icon: Icon(Icons.help))
        ],
      ),
      body: Row(
        children: [
          const Expanded(
            child: WrapWidget(
              margin: EdgeInsets.all(defaultMargin),
              child: TextListWidget(
                title: 'devices_list_hint',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Row(
                    children: [
                      Expanded(
                          child: WrapWidget(
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 0, defaultMargin, 0),
                              height: double.infinity,
                              child: ControlsWidget())),
                      Expanded(
                          child: WrapWidget(
                              child: TextListWidget(
                        title: 'commands_list_hint',
                      ))),
                    ],
                  ),
                ),
                const Expanded(
                    child: WrapWidget(
                        margin: EdgeInsets.fromLTRB(
                            defaultMargin, defaultMargin, 0, 0),
                        child: LogsWidget()))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LogsWidget extends StatelessWidget {
  const LogsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: SelectableText(
            '''dfs ''',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class ControlsWidget extends GetView<HomeController> {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Expanded(
          child: Column(
            children: [
              Obx(() => SelectWidget<int>(
                  title: 'timeout',
                  value: controller.timeout.value,
                  items: controller.timeoutValues,
                  onChanged: (val) => controller.updateTimeout(val))),
              Obx(() => SelectWidget<int>(
                  title: 'threads',
                  value: controller.threads.value,
                  items: controller.threadsValues,
                  onChanged: (val) => controller.updateThreads(val))),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              TextField(
                controller: controller.loginController,
                decoration: InputDecoration(labelText: 'login'.tr),
              ),
              TextField(
                obscureText: true,
                controller: controller.passwordController,
                decoration: InputDecoration(labelText: 'password'.tr),
              ),
            ],
          ),
        ),
      ]),
      Row(
        children: [
          ElevatedButton(
            onPressed: controller.perform,
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Obx(() => Text(
                    controller.status.value == Status.stopped
                        ? 'start'.tr
                        : 'stop'.tr,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
            ),
          ),
        ],
      )
    ]);
  }
}

class SelectWidget<T> extends StatelessWidget {
  final String title;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const SelectWidget(
      {Key? key,
      required this.title,
      required this.items,
      required this.onChanged,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title.tr),
        const SizedBox(
          width: defaultMargin,
        ),
        DropdownButton<T>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class TextListWidget extends StatelessWidget {
  final String title;

  const TextListWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        decoration: InputDecoration(
            hintText: title.tr,
            border: InputBorder.none,
            fillColor: secondaryColor,
            focusColor: secondaryColor,
            hoverColor: secondaryColor,
            filled: true),
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}

class WrapWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? margin;

  const WrapWidget(
      {Key? key, required this.child, this.width, this.height, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      height: height,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
          color: secondaryColor),
      child: child,
    );
  }
}
