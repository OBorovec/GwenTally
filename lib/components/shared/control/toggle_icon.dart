import 'package:flutter/material.dart';

class ToggleIcon extends StatelessWidget {
  final bool isOn;
  final Function() onTap;
  final IconData iconData;
  final double? iconSize;

  const ToggleIcon({
    Key? key,
    required this.isOn,
    required this.onTap,
    required this.iconData,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        iconData,
        size: iconSize,
        color: isOn
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
