import 'package:flutter/cupertino.dart';
import 'package:nas_config/ui/widgets/controls_widget.dart';
import 'package:nas_config/ui/widgets/devices_widget.dart';
import 'package:nas_config/ui/widgets/logs_widget.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DevicesWidget(),
        Column(
          children: [
            Row(
              children: [
                ControlsWidget(),
                DevicesWidget(),
              ],
            ),
            LogsWidget(),
          ],
        )
      ],
    );
  }
}
