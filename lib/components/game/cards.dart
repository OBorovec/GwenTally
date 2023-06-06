import 'package:flutter/material.dart';
import 'package:gwentboard/constants/colors.dart';
import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/model/card_data.dart';

import 'package:gwentboard/utils/board_sizer.dart';

// https://github.com/flutter/flutter/issues/88570
// The core problem is that as of 994133c, the reorderable list no longer uses
//its own Overlay to display the dragged item. It reuses the surrounding overlay
// (usually the one provided by MaterialApp) so that the items can be seen
// outside of the list itself when dragging.

class DraggableCard extends StatelessWidget {
  final CardData data;
  // TODO: delete this after they fix it
  final BoardSizer sizer;

  const DraggableCard({
    Key? key,
    required this.data,
    required this.sizer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Draggable<CardData>(
      data: data,
      feedback: Material(
        color: Colors.transparent,
        child: BoardCard(
          data: data,
          sizer: sizer,
        ),
      ),
      child: BoardCard(
        data: data,
        sizer: sizer,
      ),
    );
  }
}

class DoubleTapCard extends StatelessWidget {
  final CardData data;
  final Function() onDoubleTap;
  // TODO: delete this after they fix it
  final BoardSizer sizer;

  const DoubleTapCard({
    Key? key,
    required this.data,
    required this.onDoubleTap,
    required this.sizer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: BoardCard(data: data, sizer: sizer),
    );
  }
}

class BoardCard extends StatelessWidget {
  final CardData data;
  // TODO: delete this after they fix it
  final BoardSizer sizer;

  const BoardCard({
    Key? key,
    required this.data,
    required this.sizer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.all(context.read<BoardSizer>().cardPadding),
      padding: EdgeInsets.all(sizer.cardPadding),
      child: Container(
        // width: context.read<BoardSizer>().cardWidth,
        width: sizer.cardWidth,
        // height: context.read<BoardSizer>().cardHeight,
        height: sizer.cardHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          border: Border.all(
            color: !data.attHero
                ? Theme.of(context).primaryColorDark
                : BoardColors.cardTypeGolden,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                data.activeValue != null
                    ? data.activeValue.toString()
                    : data.baseValue.toString(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      // fontSize: context.read<BoardSizer>().cardActiveFontSize,
                      fontSize: sizer.cardActiveFontSize,
                      color: _cardValueColor(),
                    ),
              ),
            ),
            if (data.activeValue != null && data.activeValue != data.baseValue)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  data.baseValue.toString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        // fontSize:
                        //     context.read<BoardSizer>().cardPassiveFontSize,
                        fontSize: sizer.cardPassiveFontSize,
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
    );
  }

  Widget _buildCardIcon(BuildContext context) {
    IconData? icon;
    if (data.attCommanderHorn) {
      return ImageIcon(
        GwentIcons.commanderHorn,
        // size: context.read<BoardSizer>().controlIconSize,
        size: sizer.cardIconSize,
        color: Colors.white,
      );
    }
    if (data.attTightBond) {
      icon = GwentIcons.tightBond;
    } else if (data.attMuster) {
      icon = GwentIcons.muster;
    } else if (data.attMoral) {
      icon = GwentIcons.moral;
    } else if (data.attDoubleMoral) {
      icon = GwentIcons.doubleMoral;
    }
    return icon != null
        ? Icon(
            icon,
            // size: context.read<BoardSizer>().cardIconSize,
            size: sizer.cardIconSize,
          )
        : Container();
  }

  Color? _cardValueColor() {
    if (data.activeValue != null) {
      if (data.activeValue! < data.baseValue) {
        return BoardColors.cardValueDebuff;
      }
      if (data.activeValue! > data.baseValue) {
        return BoardColors.cardValueBoost;
      }
    }
    return null;
  }
}
