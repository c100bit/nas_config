import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/controllers/home_controller.dart';

class PasswordInput extends StatelessWidget {
  final HomeController controller;
  const PasswordInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      style: Theme.of(context).textTheme.bodyText2,
      controller: controller.passwordController,
      decoration: InputDecoration(labelText: 'password'.tr),
    );
  }
}
