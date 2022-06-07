import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';

class LoginInput extends StatelessWidget {
  final HomeController controller;
  const LoginInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.loginController,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(labelText: 'login'.tr),
    );
  }
}
