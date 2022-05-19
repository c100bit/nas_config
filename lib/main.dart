import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/app_translation.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/core/app_bindings.dart';
import 'package:nas_config/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBindings().dependencies();
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
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
        colorSchemeSeed: colorSchemeSeed,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
