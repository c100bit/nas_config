import 'package:flutter/material.dart';
import 'package:nas_config/core/constants.dart';

class SelectWidget<T> extends StatelessWidget {
  final String title;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const SelectWidget(
      {Key? key,
      required this.title,
      required this.items,
      required this.onChanged,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(
          width: defaultMargin,
        ),
        DropdownButton<T>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
