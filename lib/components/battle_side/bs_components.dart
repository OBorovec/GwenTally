import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/constants/colors.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/utils/board_sizer.dart';
import 'package:gwentboard/components/game/cards.dart';

class CardLine extends StatelessWidget {
  final List<CardData> cards;
  final Function(CardData data) onAccept;
  final Function(CardData data) onRemove;
  const CardLine({
    Key? key,
    required this.cards,
    required this.onAccept,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: context.read<BoardSizer>().cardViewHeight,
      ),
      decoration: BoxDecoration(
        color: BoardColors.cardLineBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: DragTarget<CardData>(
        builder: (BuildContext context, List candidateData, List rejectedData) {
          return Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: cards
                    .map(
                      (CardData data) => DoubleTapCard(
                        data: data,
                        onDoubleTap: () => onRemove(
                          data,
                        ),
                        sizer: context.read<BoardSizer>(),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
        onAccept: (CardData data) => onAccept(data),
      ),
    );
  }
}

class CommanderHornSwitch extends StatelessWidget {
  final bool isOn;
  final double? iconSize;
  final Function() onToggle;
  const CommanderHornSwitch({
    Key? key,
    required this.isOn,
    this.iconSize,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.read<BoardSizer>().controlIconPaddingHorizontal,
        vertical: context.read<BoardSizer>().controlIconPaddingVertical,
      ),
      child: InkWell(
        onTap: onToggle,
        child: ImageIcon(
          GwentIcons.commanderHorn,
          size: context.read<BoardSizer>().controlIconSize,
          color: isOn
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.onSecondary,
        ),
        // child: Icon(
        //   Icons.bookmark,
        //   size: context.read<BoardSizer>().controlIconSize,
        //   color: isOn
        //       ? Theme.of(context).colorScheme.secondary
        //       : Theme.of(context).colorScheme.onSecondary,
        // ),
      ),
    );
  }
}

class CommanderSwitch extends StatelessWidget {
  final bool isOn;
  final double? iconSize;
  final Function() onToggle;
  const CommanderSwitch({
    Key? key,
    required this.isOn,
    this.iconSize,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark.withAlpha(100),
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: InkWell(
        onTap: onToggle,
        child: ImageIcon(
          GwentIcons.crown,
          size: context.read<BoardSizer>().controlIconSize,
          color: isOn
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
