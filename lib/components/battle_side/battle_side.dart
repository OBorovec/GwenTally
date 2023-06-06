import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/components/battle_side/bs_components.dart';
import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/utils/board_sizer.dart';

class BattleSide extends StatelessWidget {
  final bool collapsed;
  final bool reversed;
  const BattleSide({
    Key? key,
    this.collapsed = false,
    this.reversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BattleSideBloc, BattleSideState>(
      builder: (context, state) {
        List<Widget> columnContent = [
          _FrontLine(
            battleSideState: state,
          ),
          _BackLine(
            battleSideState: state,
          ),
          _ArtyLine(
            battleSideState: state,
          ),
        ];
        if (reversed) columnContent = columnContent.reversed.toList();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: columnContent,
        );
      },
    );
  }
}

abstract class _BattleLine extends StatelessWidget {
  final String title;
  final bool isMoral;
  final int lineValue;
  final BattleSideEvent moralToggleEvent;
  final List<CardData> cards;
  final Function(CardData data) onAddCardEvent;
  final Function(CardData data) onRemoveCardEvent;
  final IconData weatherIcon;
  final bool? commanderIcon;

  const _BattleLine({
    Key? key,
    required this.title,
    required this.isMoral,
    required this.lineValue,
    required this.moralToggleEvent,
    required this.cards,
    required this.onAddCardEvent,
    required this.onRemoveCardEvent,
    required this.weatherIcon,
    this.commanderIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: context.read<BoardSizer>().lineTopPadding,
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    lineValue.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: context.read<BoardSizer>().lineScoreFontSize),
                  ),
                  CommanderHornSwitch(
                    isOn: isMoral,
                    iconSize: context.read<BoardSizer>().controlIconSize,
                    onToggle: () {
                      BlocProvider.of<BattleSideBloc>(context)
                          .add(moralToggleEvent);
                    },
                  ),
                ],
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
        Padding(
          padding: EdgeInsets.only(
            top: context.read<BoardSizer>().lineTitleTopOffset,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: context.read<BoardSizer>().lineTitleFontSize,
                  ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Icon(
            weatherIcon,
            size: context.read<BoardSizer>().lineWeatherIconSize,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        if (commanderIcon != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: CommanderSwitch(
              isOn: commanderIcon!,
              iconSize: context.read<BoardSizer>().lineWeatherIconSize,
              onToggle: () => BlocProvider.of<BattleSideBloc>(context)
                  .add(const ToggleCommanderCard()),
            ),
          ),
      ],
    );
  }
}

class _FrontLine extends _BattleLine {
  _FrontLine({
    Key? key,
    required BattleSideState battleSideState,
  }) : super(
          key: key,
          title: 'Front line',
          isMoral: battleSideState.frontlineMorale,
          lineValue: battleSideState.frontlineCards
              .map((CardData cd) => cd.activeValue ?? cd.baseValue)
              .fold(0, (a, b) => a + b),
          moralToggleEvent: const ToggleFrontlineMorale(),
          cards: battleSideState.frontlineCards,
          onAddCardEvent: (CardData cd) => AddFrontlineCard(data: cd),
          onRemoveCardEvent: (CardData cd) => RemoveFrontlineCard(data: cd),
          weatherIcon: battleSideState.frontlineWeather
              ? GwentIcons.snow
              : GwentIcons.sunny,
          commanderIcon: battleSideState.commanderPlayed,
        );
}

class _BackLine extends _BattleLine {
  _BackLine({
    Key? key,
    required BattleSideState battleSideState,
  }) : super(
          key: key,
          title: 'Back line',
          isMoral: battleSideState.backlineMorale,
          lineValue: battleSideState.backlineCards
              .map((CardData cd) => cd.activeValue ?? cd.baseValue)
              .fold(0, (a, b) => a + b),
          moralToggleEvent: const ToggleBacklineMorale(),
          cards: battleSideState.backlineCards,
          onAddCardEvent: (CardData cd) => AddBacklineCard(data: cd),
          onRemoveCardEvent: (CardData cd) => RemoveBacklineCard(data: cd),
          weatherIcon: battleSideState.backlineWeather
              ? GwentIcons.fog
              : GwentIcons.sunny,
        );
}

class _ArtyLine extends _BattleLine {
  _ArtyLine({
    Key? key,
    required BattleSideState battleSideState,
  }) : super(
          key: key,
          title: 'Arty line',
          isMoral: battleSideState.artylineMorale,
          lineValue: battleSideState.artylineCards
              .map((CardData cd) => cd.activeValue ?? cd.baseValue)
              .fold(0, (a, b) => a + b),
          moralToggleEvent: const ToggleArtylineMorale(),
          cards: battleSideState.artylineCards,
          onAddCardEvent: (CardData cd) => AddArtylineCard(data: cd),
          onRemoveCardEvent: (CardData cd) => RemoveArtylineCard(data: cd),
          weatherIcon: battleSideState.artylineWeather
              ? GwentIcons.rain
              : GwentIcons.sunny,
        );
}
