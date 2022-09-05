import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/components/battle_side/bs_components.dart';
import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/model/card_data.dart';

abstract class BattleLine extends StatelessWidget {
  final String title;
  final bool isMoral;
  final BattleSideEvent moralToggleEvent;
  final List<CardData> cards;
  final Function(CardData data) onAddCardEvent;
  final Function(CardData data) onRemoveCardEvent;
  final IconData weatherIcon;

  const BattleLine({
    Key? key,
    required this.title,
    required this.isMoral,
    required this.moralToggleEvent,
    required this.cards,
    required this.onAddCardEvent,
    required this.onRemoveCardEvent,
    required this.weatherIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Row(
            children: [
              MoralIconSwitch(
                isOn: isMoral,
                onToggle: () {
                  BlocProvider.of<BattleSideBloc>(context)
                      .add(moralToggleEvent);
                },
              ),
              Expanded(
                child: CardLine(
                  cards: cards,
                  onAccept: (CardData cd) =>
                      BlocProvider.of<BattleSideBloc>(context)
                          .add(onAddCardEvent(cd)),
                  onRemove: (CardData cd) =>
                      BlocProvider.of<BattleSideBloc>(context)
                          .add(onRemoveCardEvent(cd)),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(title),
          ),
        ),
        Positioned(
            child: Icon(
              weatherIcon,
              color: Theme.of(context).colorScheme.secondary,
            ),
            top: 0,
            right: 0),
      ],
    );
  }
}

class FrontLine extends BattleLine {
  FrontLine({
    Key? key,
    required BattleSideState battleSideState,
  }) : super(
          key: key,
          title: 'Front line',
          isMoral: battleSideState.frontlineMorale,
          moralToggleEvent: ToggleFrontlineMorale(),
          cards: battleSideState.frontlineCards,
          onAddCardEvent: (CardData cd) => AddFrontlineCard(data: cd),
          onRemoveCardEvent: (CardData cd) => RemoveFrontlineCard(data: cd),
          weatherIcon: battleSideState.frontlineWeather
              ? GwentIcons.snow
              : GwentIcons.sunny,
        );
}

class BackLine extends BattleLine {
  BackLine({
    Key? key,
    required BattleSideState battleSideState,
  }) : super(
          key: key,
          title: 'Back line',
          isMoral: battleSideState.backlineMorale,
          moralToggleEvent: ToggleBacklineMorale(),
          cards: battleSideState.backlineCards,
          onAddCardEvent: (CardData cd) => AddBacklineCard(data: cd),
          onRemoveCardEvent: (CardData cd) => RemoveBacklineCard(data: cd),
          weatherIcon: battleSideState.backlineWeather
              ? GwentIcons.fog
              : GwentIcons.sunny,
        );
}

class ArtyLine extends BattleLine {
  ArtyLine({
    Key? key,
    required BattleSideState battleSideState,
  }) : super(
          key: key,
          title: 'Arty line',
          isMoral: battleSideState.artylineMorale,
          moralToggleEvent: ToggleArtylineMorale(),
          cards: battleSideState.artylineCards,
          onAddCardEvent: (CardData cd) => AddArtylineCard(data: cd),
          onRemoveCardEvent: (CardData cd) => RemoveArtylineCard(data: cd),
          weatherIcon: battleSideState.artylineWeather
              ? GwentIcons.rain
              : GwentIcons.sunny,
        );
}
