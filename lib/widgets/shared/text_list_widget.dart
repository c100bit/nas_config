import 'package:flutter/material.dart';

class TextListWidget extends StatelessWidget {
  final String title;
  final bool readOnly;
  final bool expands;
  final TextEditingController controller;

  const TextListWidget({
    Key? key,
    required this.controller,
    required this.title,
    this.readOnly = false,
    this.expands = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: title, border: InputBorder.none),
      readOnly: readOnly,
      style: Theme.of(context).textTheme.bodyText2,
      maxLines: null,
      expands: expands,
      keyboardType: TextInputType.multiline,
    );
  }
}
