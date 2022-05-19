import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_x;
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/controllers/home_controller.dart';
import 'package:nas_config/widgets/commands_widget.dart';
import 'package:nas_config/widgets/controls_widget.dart';
import 'package:nas_config/widgets/devices_widget.dart';
import 'package:nas_config/widgets/logs_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends get_x.GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabletRow = ResponsiveWrapper.of(context).isSmallerThan(TABLET)
        ? ResponsiveRowColumnType.COLUMN
        : ResponsiveRowColumnType.ROW;

    return Scaffold(
        appBar: AppBar(
          title: Text('app_title'.tr),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.light)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.help))
          ],
        ),
        body: ResponsiveRowColumn(
          layout: tabletRow,
          children: [
            // Devices
            const ResponsiveRowColumnItem(
                rowFlex: 1, columnFlex: 1, child: DevicesWidget()),
            ResponsiveRowColumnItem(
              rowFlex: 3,
              columnFlex: 4,
              child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  children: [
                    ResponsiveRowColumnItem(
                      columnFlex: 1,
                      child: ResponsiveRowColumn(
                          layout: tabletRow,
                          children: const [
                            // Controls
                            ResponsiveRowColumnItem(
                                rowFlex: 1,
                                columnFlex: 1,
                                child: ControlsWidget()),
                            // Commands
                            ResponsiveRowColumnItem(
                                rowFlex: 2,
                                columnFlex: 1,
                                child: CommandsWidget()),
                          ]),
                    ),
                    // Logs
                    ResponsiveRowColumnItem(
                        columnFlex: ResponsiveValue<int>(context,
                            defaultValue: 3,
                            valueWhen: [
                              const Condition.smallerThan(
                                  name: TABLET, value: 1)
                            ]).value,
                        child: const LogsWidget())
                  ]),
            ),
          ],
        ));
  }
}
