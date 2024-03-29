import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/app_theme.dart';
import 'package:nas_config/core/app_translation.dart';
import 'package:nas_config/core/app_bindings.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/ui/pages/home_page.dart';
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
      home: const HomePage(),
    );
  }
}
