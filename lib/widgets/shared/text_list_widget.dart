import 'package:flutter/material.dart';
import 'package:nas_config/core/constants.dart';

class TextListWidget extends StatelessWidget {
  final String title;
  final bool readOnly;
  final bool expands;

  const TextListWidget({
    Key? key,
    required this.title,
    this.readOnly = false,
    this.expands = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: title, border: InputBorder.none),
      readOnly: readOnly,
      maxLines: null,
      expands: expands,
      keyboardType: TextInputType.multiline,
    );
  }
}
