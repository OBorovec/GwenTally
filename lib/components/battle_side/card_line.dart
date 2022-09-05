import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/components/game/cards.dart';
import 'package:gwentboard/constants/colors.dart';
import 'package:gwentboard/constants/dimensions.dart';
import 'package:gwentboard/model/card_data.dart';

abstract class CardLine extends StatelessWidget {
  const CardLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: BoardDims.cardHeight + 2 * BoardDims.cardPadding,
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
              child: BlocBuilder<BattleSideBloc, BattleSideState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getStateCardData(state)
                        .map(
                          (CardData data) => DoubleTapCard(
                            data: data,
                            onDoubleTap: () => _onRemove(
                              context,
                              data,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          );
        },
        onAccept: (CardData data) => _onAccept(context, data),
      ),
    );
  }

  List<CardData> _getStateCardData(BattleSideState state);

  void _onAccept(BuildContext context, CardData data);

  void _onRemove(BuildContext context, CardData data);
}

class FrontCardLine extends CardLine {
  const FrontCardLine({Key? key}) : super(key: key);

  @override
  List<CardData> _getStateCardData(BattleSideState state) {
    return state.frontlineCards;
  }

  @override
  void _onAccept(BuildContext context, CardData data) {
    BlocProvider.of<BattleSideBloc>(context).add(AddFrontlineCard(data: data));
  }

  @override
  void _onRemove(BuildContext context, CardData data) {
    BlocProvider.of<BattleSideBloc>(context)
        .add(RemoveFrontlineCard(data: data));
  }
}

class BackCardLine extends CardLine {
  const BackCardLine({Key? key}) : super(key: key);

  @override
  List<CardData> _getStateCardData(BattleSideState state) {
    return state.backlineCards;
  }

  @override
  void _onAccept(BuildContext context, CardData data) {
    BlocProvider.of<BattleSideBloc>(context).add(AddBacklineCard(data: data));
  }

  @override
  void _onRemove(BuildContext context, CardData data) {
    BlocProvider.of<BattleSideBloc>(context)
        .add(RemoveBacklineCard(data: data));
  }
}

class ArtyCardLine extends CardLine {
  const ArtyCardLine({Key? key}) : super(key: key);

  @override
  List<CardData> _getStateCardData(BattleSideState state) {
    return state.artylineCards;
  }

  @override
  void _onAccept(BuildContext context, CardData data) {
    BlocProvider.of<BattleSideBloc>(context).add(AddArtylineCard(data: data));
  }

  @override
  void _onRemove(BuildContext context, CardData data) {
    BlocProvider.of<BattleSideBloc>(context)
        .add(RemoveArtylineCard(data: data));
  }
}
