import 'package:flutter/material.dart';

import 'package:gwentboard/constants/gwent_icons.dart';

class CommanderHorn extends StatelessWidget {
  final bool isOn;
  final double size;
  final Function() onToggle;
  const CommanderHorn({
    Key? key,
    required this.isOn,
    required this.size,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.05,
        vertical: size * 0.05,
      ),
      child: InkWell(
        onTap: onToggle,
        child: ImageIcon(
          GwentIcons.commanderHorn,
          size: size * 0.9,
          color: isOn
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
