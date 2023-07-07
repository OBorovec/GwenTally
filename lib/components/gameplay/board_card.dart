import 'package:flutter/material.dart';

import 'package:gwentboard/constants/colors.dart';
import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/model/card_played.dart';

class CardConfig {
  late final double cardWidth;
  late final double cardHeight;
  late final double outerPadding;
  late final double border;
  late final double innerPadding;
  late final double sizeTextActive;
  late final double sizeTextPassive;
  late final double iconSize;

  CardConfig({
    required double cardVerticalSpace,
  }) {
    // Card size
    cardHeight = cardVerticalSpace * 0.92;
    cardWidth = cardHeight * 0.45;
    // Padding and Border
    outerPadding = cardVerticalSpace * 0.02;
    border = cardVerticalSpace * 0.02;
    innerPadding = cardHeight * 0.02;
    // Size of Icon and Font
    final double doubleInnerSize = cardHeight - 2 * innerPadding - 2 * border;
    sizeTextActive = doubleInnerSize * 0.4;
    sizeTextPassive = doubleInnerSize * 0.25;
    iconSize = doubleInnerSize * 0.3;
  }
}

class BoardCard extends StatelessWidget {
  final CardConfig config;
  final PlayedCard? card;
  final CardData? data;
  final Function()? onDoubleTap;
  final Function()? onLongPress;
  final bool isDraggable;
  final Widget? childWhenDragging;

  const BoardCard({
    Key? key,
    required this.config,
    this.card,
    this.data,
    this.onDoubleTap,
    this.onLongPress,
    this.isDraggable = false,
    this.childWhenDragging,
  })  : assert(isDraggable ? card != null || data != null : true),
        assert(
            onDoubleTap != null || onLongPress != null ? card != null : true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (card == null && data == null) {
      return _PlaceholderCard(config: config);
    } else if (onDoubleTap != null || onLongPress != null) {
      return GestureDetector(
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        child: _BaseCard(
          config: config,
          activeValue: card!.activeValue,
          data: card!.data,
        ),
      );
    } else if (isDraggable) {
      if (card != null) {
        return Draggable<PlayedCard>(
          data: card,
          feedback: Material(
            color: Colors.transparent,
            child: _BaseCard(
              config: config,
              activeValue: card!.activeValue,
              data: card!.data,
            ),
          ),
          childWhenDragging: childWhenDragging,
          child: _BaseCard(
            config: config,
            activeValue: card!.activeValue,
            data: card!.data,
          ),
        );
      } else if (data != null) {
        return Draggable<CardData>(
          data: data,
          feedback: Material(
            color: Colors.transparent,
            child: _BaseCard(
              config: config,
              activeValue: data!.baseValue,
              data: data!,
            ),
          ),
          childWhenDragging: childWhenDragging,
          child: _BaseCard(
            config: config,
            activeValue: data!.baseValue,
            data: data!,
          ),
        );
      }
    } else {
      if (card != null) {
        return _BaseCard(
          config: config,
          activeValue: card!.activeValue,
          data: card!.data,
        );
      } else if (data != null) {
        return _BaseCard(
          config: config,
          activeValue: data!.baseValue,
          data: data!,
        );
      }
    }
    return Container();
  }
}

class _PlaceholderCard extends StatelessWidget {
  final CardConfig config;

  const _PlaceholderCard({
    Key? key,
    required this.config,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(config.outerPadding),
      child: SizedBox(
        width: config.cardWidth,
        height: config.cardHeight,
      ),
    );
  }
}

class _BaseCard extends StatelessWidget {
  final CardConfig config;
  final int activeValue;
  final CardData data;

  const _BaseCard({
    required this.config,
    required this.activeValue,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(config.outerPadding),
      child: Container(
        width: config.cardWidth,
        height: config.cardHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          border: Border.all(
            color: !data.attHero
                ? Theme.of(context).primaryColorDark
                : BoardColors.cardTypeGolden,
            width: config.border,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(config.innerPadding),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: config.sizeTextActive,
                  child: FittedBox(
                    child: Text(
                      activeValue.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: _cardValueColor(),
                          ),
                    ),
                  ),
                ),
              ),
              if (activeValue != data.baseValue)
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: config.sizeTextPassive,
                    child: FittedBox(
                      child: Text(
                        data.baseValue.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomRight,
                child: _buildCardIcon(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardIcon(BuildContext context) {
    IconData? icon;
    if (data.attCommanderHorn) {
      return ImageIcon(
        GwentIcons.commanderHorn,
        size: config.iconSize,
        color: Colors.white,
      );
    }
    if (data.attTightBond) {
      icon = GwentIcons.tightBond;
    } else if (data.attMuster) {
      icon = GwentIcons.muster;
    } else if (data.attMorale) {
      icon = GwentIcons.morale;
    } else if (data.attDoubleMorale) {
      icon = GwentIcons.doubleMorale;
    } else if (data.attDemorale) {
      icon = GwentIcons.demorale;
    }
    return icon != null
        ? Icon(
            icon,
            size: config.iconSize,
          )
        : Container();
  }

  Color? _cardValueColor() {
    if (activeValue < data.baseValue) {
      return BoardColors.cardValueDebuff;
    }
    if (activeValue > data.baseValue) {
      return BoardColors.cardValueBoost;
    }
    return null;
  }
}
