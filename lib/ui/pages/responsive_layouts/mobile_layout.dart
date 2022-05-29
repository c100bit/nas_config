import 'package:flutter/cupertino.dart';
import 'package:nas_config/ui/widgets/commands_widget.dart';
import 'package:nas_config/ui/widgets/controls_widget.dart';
import 'package:nas_config/ui/widgets/devices_widget.dart';
import 'package:nas_config/ui/widgets/logs_widget.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(child: DevicesWidget()),
        Expanded(child: ControlsWidget()),
        Expanded(child: CommandsWidget()),
        Expanded(child: LogsWidget())
      ],
    );
  }
}
