import 'package:computer/computer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nas_config/core/app_theme.dart';
import 'package:nas_config/core/app_translation.dart';

import 'package:nas_config/core/app_bindings.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/services/computer_service.dart';
import 'package:nas_config/ui/pages/home_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBindings().dependencies();

  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    await DesktopWindow.setMinWindowSize(const Size(appMinWSize, appMinHSize));
  }

  //final workersPool = Computer.create();
  //await workersPool.turnOn(verbose: true, workersCount: 4);
  //[1, 2, 3, 4, 5, 6, 7, 8].forEach((element) => workersPool.compute((param) {
  //     print('test $param');
  //    }, param: element));

  ComputerService()
      .execute('192.168.0.72', login: 'i.okulov', password: 'Gesund1!');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      translationsKeys: AppTranslation.translationsKeys,
      title: 'app_title'.tr,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context).current(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        minWidth: 280,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(280, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
      home: const HomePage(),
    );
  }
}
