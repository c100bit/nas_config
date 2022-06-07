import 'package:flutter/cupertino.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/ui/widgets/commands_widget.dart';
import 'package:nas_config/ui/widgets/controls_widget.dart';
import 'package:nas_config/ui/widgets/devices_widget.dart';
import 'package:nas_config/ui/widgets/logs_widget.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 1, child: DevicesWidget()),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: const [
                    Expanded(
                        flex: 1,
                        child: ControlsWidget(
                            margin: EdgeInsets.only(bottom: defaultMargin))),
                    Expanded(flex: 1, child: CommandsWidget()),
                  ],
                ),
              ),
              const Expanded(
                  flex: 2,
                  child: LogsWidget(
                      margin: EdgeInsets.only(
                    bottom: defaultMargin,
                    right: defaultMargin,
                  ))),
            ],
          ),
        )
      ],
    );
  }
}
