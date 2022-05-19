import 'package:flutter/material.dart';
import 'package:nas_config/core/constants.dart';

class WrapWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? margin;

  const WrapWidget(
      {Key? key, required this.child, this.width, this.height, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: child);
  }
}
