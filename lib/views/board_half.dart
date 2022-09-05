import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/bloc/game/game_bloc.dart';
import 'package:gwentboard/bloc/pack/pack_bloc.dart';
import 'package:gwentboard/components/_page/pop_page.dart';
import 'package:gwentboard/components/battle_side/bs_score.dart';
import 'package:gwentboard/components/battle_side/bs_widget.dart';
import 'package:gwentboard/components/game/game_control_state.dart';
import 'package:gwentboard/components/game/game_control_weather.dart';
import 'package:gwentboard/components/pack/pack_widget.dart';

class SingleBoardPage extends StatelessWidget {
  const SingleBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Battleside blbc B is there jsut cause i ma lazy to create a new game bloc
    BattleSideBloc battleSideBlocA = BattleSideBloc();
    BattleSideBloc battleSideBlocB = BattleSideBloc();
    PackBloc packBloc = PackBloc();
    GameBloc gameBloc = GameBloc(
      battleSideBlocA: battleSideBlocA,
      battleSideBlocB: battleSideBlocB,
      packBloc: packBloc,
    );
    return PopDialogPage(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => gameBloc,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocProvider(
                create: (context) => packBloc,
                child: const CardPack(),
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
              const SizedBox(
                height: 16,
              ),
              BlocProvider(
                create: (context) => battleSideBlocA,
                child: Column(
                  children: const [
                    BattleSide(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(),
                    ),
                    BattleSideScore(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
