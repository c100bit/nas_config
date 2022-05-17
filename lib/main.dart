import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/app_translation.dart';
import 'package:nas_config/constants.dart';
import 'package:nas_config/controllers_bindings.dart';
import 'package:nas_config/pages/home_page.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await configureDependencies();
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: ControllersBindings(),
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
        colorSchemeSeed: colorSchemeSeed,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
