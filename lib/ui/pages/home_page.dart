import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/responsive_layout.dart';
import 'package:nas_config/ui/pages/responsive_layouts/desktop_layout.dart';
import 'package:nas_config/ui/pages/responsive_layouts/mobile_layout.dart';

import 'package:nas_config/ui/widgets/shared/info_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoDialog = InfoDialog(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('app_title'.tr),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: infoDialog.show,
              icon: const Icon(Icons.help),
            )
          ],
        ),
        body: const ResponsiveLayout(
          mobile: MobileLayout(),
          desktop: DesktopLayout(),
        ));
  }
}
