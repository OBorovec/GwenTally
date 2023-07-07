import 'package:flutter/material.dart';

class ToggleImage extends StatelessWidget {
  final bool isOn;
  final Function() onTap;
  final AssetImage assetImage;
  final double? iconSize;

  const ToggleImage({
    Key? key,
    required this.isOn,
    required this.onTap,
    required this.assetImage,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ImageIcon(
        assetImage,
        size: iconSize,
        color: isOn
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
