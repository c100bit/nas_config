import 'package:flutter/material.dart';
import 'package:nas_config/core/constants.dart';

class WrapWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;

  const WrapWidget({Key? key, required this.child, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: margin,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: child,
        ));
  }
}
