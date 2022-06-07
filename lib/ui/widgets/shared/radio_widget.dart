import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';

class RadioWidget<T> extends StatelessWidget {
  final List<T> items;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  const RadioWidget({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => RadioListTile<T>(
                title: Text(
                  item.toString().tr,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                dense: true,
                contentPadding: const EdgeInsets.all(0),
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity, vertical: -1),
                value: item,
                activeColor: textColor,
                groupValue: groupValue,
                onChanged: onChanged,
              ))
          .toList(),
    );
  }
}
