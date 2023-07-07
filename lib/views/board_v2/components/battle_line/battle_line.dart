import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/components/gameplay/battle_line/card_line.dart';

import 'package:gwentboard/components/gameplay/battle_line/commander_horn.dart';
import 'package:gwentboard/components/gameplay/battle_line/weather_switch.dart';
import 'package:gwentboard/components/gameplay/board_card.dart';
import 'package:gwentboard/constants/colors.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/model/card_played.dart';
import 'package:gwentboard/views/board_v2/board_config.dart';
import 'package:gwentboard/views/board_v2/components/battle_line/bloc/battle_line_bloc.dart';
import 'package:gwentboard/views/board_v2/components/pack/bloc/pack_bloc.dart';

class BattleLineConfig {
  late final double weatherControlSize;
  late final double titleSpaceHeight;
  late final double scoreSize;
  late final double hornBtnSize;

  BattleLineConfig({
    required double splitRatio,
    required double height,
    required double width,
  }) {
    // Base division
    final double cardLineSpace = height * splitRatio;
    titleSpaceHeight = height * (1 - splitRatio);
    // Line aspects
    weatherControlSize = width * 0.10;
    scoreSize = cardLineSpace * 0.45;
    hornBtnSize = cardLineSpace * 0.5;
  }
}

class BattleLine extends StatelessWidget {
  final String title;
  final String weatherIcon;

  const BattleLine({
    super.key,
    required this.title,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    final BoardConfig config = context.read<BoardConfig>();
    return Column(
      children: [
        SizedBox(
          height: config.lineConfig.titleSpaceHeight,
          child: FittedBox(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<BattleLineBloc, BattleLineState>(
                    buildWhen: (previous, current) =>
                        previous.score != current.score,
                    builder: (context, state) {
                      return SizedBox(
                        height: config.lineConfig.scoreSize,
                        width: config.lineConfig.scoreSize,
                        child: FittedBox(
                          child: Text(
                            state.score.toString(),
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: state.weather
                                          ? BoardColors.cardValueDebuff
                                          : null,
                                    ),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<BattleLineBloc, BattleLineState>(
                    buildWhen: (previous, current) =>
                        previous.horn != current.horn,
                    builder: (context, state) {
                      return CommanderHorn(
                        isOn: state.horn,
                        size: config.lineConfig.hornBtnSize,
                        onToggle: () => BlocProvider.of<BattleLineBloc>(context)
                            .add(const ToggleHorn()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BattleLineBloc, BattleLineState>(
                buildWhen: (previous, current) =>
                    previous.cards != current.cards,
                builder: (context, state) {
                  CardConfig cardConfig = context.read<BoardConfig>().boardCard;
                  return CardLine(
                      cards: state.cards,
                      cardConfig: cardConfig,
                      onAccept: (CardData data) {
                        BlocProvider.of<BattleLineBloc>(context).add(
                          AddCard(cardData: data),
                        );
                        BlocProvider.of<PackBloc>(context).add(
                          PackEventCardPlaced(card: data),
                        );
                      },
                      onRemove: (PlayedCard card) {
                        BlocProvider.of<BattleLineBloc>(context).add(
                          RemoveCard(card: card),
                        );
                        BlocProvider.of<PackBloc>(context).add(
                          PackEventCardPlaced(card: card.data),
                        );
                      });
                },
              ),
            ),
            // Right side
            BlocBuilder<BattleLineBloc, BattleLineState>(
              buildWhen: (previous, current) =>
                  previous.weather != current.weather,
              builder: (context, state) {
                return WeatherIconSwitch(
                  weatherIconOn: weatherIcon,
                  size: config.lineConfig.weatherControlSize,
                  weatherOn: state.weather,
                  onTap: () => BlocProvider.of<BattleLineBloc>(context)
                      .add(const ToggleWeather()),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
