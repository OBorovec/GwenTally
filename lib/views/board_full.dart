import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/bloc/game/game_bloc.dart';
import 'package:gwentboard/bloc/pack/pack_bloc.dart';
import 'package:gwentboard/components/_page/pop_page.dart';
import 'package:gwentboard/components/battle_side/bs_widget.dart';
import 'package:gwentboard/components/game/game_control_state.dart';
import 'package:gwentboard/components/game/game_score.dart';
import 'package:gwentboard/components/game/game_control_weather.dart';
import 'package:gwentboard/components/pack/pack_widget.dart';
import 'package:gwentboard/constants/gwent_icons.dart';

class FullBoardPage extends StatelessWidget {
  const FullBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BattleSideBloc battleSideBlocA = BattleSideBloc();
    BattleSideBloc battleSideBlocB = BattleSideBloc();
    PackBloc packBloc = PackBloc();
    GameBloc gameBloc = GameBloc(
      battleSideBlocA: battleSideBlocA,
      battleSideBlocB: battleSideBlocB,
      packBloc: packBloc,
    );
    return PopDialogPage(
      body: BlocProvider(
        create: (context) => gameBloc,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Top side
              Expanded(
                child: BlocProvider(
                  create: (context) => battleSideBlocA,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: BattleSide(
                      showReversed: true,
                    ),
                  ),
                ),
              ),
              // Full game Control
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GameScore(),
                  Expanded(
                    child: BlocProvider(
                      create: (context) => packBloc,
                      child: const CardPack(),
                    ),
                  ),
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(child: GameWeatherControl()),
                    const VerticalDivider(),
                    const GameControl(),
                    const VerticalDivider(),
                    IconButton(
                      onPressed: () => Navigator.maybePop(context, false),
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                ),
              ),
              // Bottom side
              Expanded(
                child: BlocProvider(
                  create: (context) => battleSideBlocB,
                  child: const BattleSide(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
