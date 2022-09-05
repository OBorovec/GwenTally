import 'package:flutter/material.dart';
import 'package:gwentboard/constants/colors.dart';
import 'package:gwentboard/constants/dimensions.dart';
import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/model/card_data.dart';

class DraggableCard extends StatelessWidget {
  final CardData data;

  const DraggableCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<CardData>(
      data: data,
      child: BoardCard(data: data),
      feedback: Material(
        child: BoardCard(data: data),
        color: Colors.transparent,
      ),
    );
  }
}

class DoubleTapCard extends StatelessWidget {
  final CardData data;
  final Function() onDoubleTap;

  const DoubleTapCard({
    Key? key,
    required this.data,
    required this.onDoubleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: BoardCard(data: data),
    );
  }
}

class BoardCard extends StatelessWidget {
  const BoardCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final CardData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(BoardDims.cardPadding),
      child: Container(
        width: BoardDims.cardWidth,
        height: BoardDims.cardHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          border: Border.all(
              color: !data.attHero
                  ? Theme.of(context).primaryColorDark
                  : BoardColors.cardTypeGolden,
              width: 2),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                data.activeValue != null
                    ? data.activeValue.toString()
                    : data.baseValue.toString(),
                style: TextStyle(color: _cardValueColor()),
              ),
            ),
            if (data.activeValue != null && data.activeValue != data.baseValue)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  data.baseValue.toString(),
                  style: Theme.of(context).textTheme.overline,
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
    if (data.attCommanderHorn) {
      return Icon(GwentIcons.commanderHorn);
    }
    if (data.attTightBond) {
      return Icon(GwentIcons.tightBond);
    }
    if (data.attMuster) {
      return Icon(GwentIcons.muster);
    }
    if (data.attMoral) {
      return Icon(GwentIcons.moral);
    }
    if (data.attDoubleMoral) {
      return Icon(GwentIcons.doubleMoral);
    }
    return Container();
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
