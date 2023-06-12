import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/bloc/game/game_bloc.dart';
import 'package:gwentboard/bloc/pack/pack_bloc.dart';
import 'package:gwentboard/components/_layout/pop_page.dart';
import 'package:gwentboard/components/battle_side/battle_side.dart';
import 'package:gwentboard/components/battle_side/battle_side_compact.dart';
import 'package:gwentboard/components/dialogs/match_start.dart';
import 'package:gwentboard/components/game/game_control_state.dart';
import 'package:gwentboard/components/game/game_score.dart';
import 'package:gwentboard/components/game/game_control_weather.dart';
import 'package:gwentboard/components/pack/pack_control.dart';
import 'package:gwentboard/components/pack/pack_wrap.dart';
import 'package:gwentboard/utils/board_sizer.dart';

class OriginalBoard extends StatefulWidget {
  const OriginalBoard({Key? key}) : super(key: key);

  @override
  State<OriginalBoard> createState() => _OriginalBoardState();
}

class _OriginalBoardState extends State<OriginalBoard> {
  late GameBloc gameBloc;
  late PackBloc packBloc;
  late BattleSideBloc battleSideBlocA;
  late BattleSideBloc battleSideBlocB;

  @override
  void initState() {
    super.initState();
    battleSideBlocA = BattleSideBloc();
    battleSideBlocB = BattleSideBloc();
    packBloc = PackBloc();
    gameBloc = GameBloc(
      battleSideBlocA: battleSideBlocA,
      battleSideBlocB: battleSideBlocB,
      packBloc: packBloc,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return BlocProvider.value(
            value: gameBloc,
            child: const MarchStartDialog(),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final BoardSizer boardSizer = BoardSizer.calcBoardSizer(
      width: width,
      height: height,
    );
    return PopDialogPage(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => gameBloc
              ..add(RequestFocus(
                  sideFocus: boardSizer.useFullViews
                      ? GameSideFocus.both
                      : GameSideFocus.A)),
          ),
        ],
        child: RepositoryProvider(
          create: (context) {
            return boardSizer;
          },
          child: BlocListener<GameBloc, GameState>(
            listener: (context, state) {},
            child: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSideA(),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildScore(),
                        Expanded(
                          child: _buildPackControl(context),
                        ),
                      ],
                    ),
                    _buildGameControl(context),
                    const SizedBox(height: 8),
                    _buildSideB(),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  BlocProvider<PackBloc> _buildPackControl(BuildContext context) {
    return BlocProvider(
        create: (context) => packBloc,
        child: !context.read<BoardSizer>().isSingleLinePack
            ? const Row(
                children: [
                  Expanded(child: CardPackWrap()),
                  PackControl(),
                ],
              )
            : const Column(
                children: [
                  PackControlRow(),
                  CardPackWrap(),
                ],
              ));
  }

  GameScore _buildScore() => const GameScore();

  Widget _buildSideA() {
    return BlocProvider(
      create: (context) => battleSideBlocA,
      child: BlocBuilder<GameBloc, GameState>(
        buildWhen: (previous, current) =>
            previous.sideFocus != current.sideFocus,
        builder: (context, state) {
          final bool fullView = state.sideFocus == GameSideFocus.both ||
              state.sideFocus == GameSideFocus.A;
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
                fullView ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: const BattleSide(reversed: true),
            secondChild: Column(
              children: [
                const BattleSideCompact(reversed: true),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => BlocProvider.of<GameBloc>(context).add(
                    const RequestFocus(sideFocus: GameSideFocus.A),
                  ),
                  child: const Text('Expand...'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSideB() {
    return BlocProvider(
      create: (context) => battleSideBlocB,
      child: BlocBuilder<GameBloc, GameState>(
        buildWhen: (previous, current) =>
            previous.sideFocus != current.sideFocus,
        builder: (context, state) {
          final bool fullView = state.sideFocus == GameSideFocus.both ||
              state.sideFocus == GameSideFocus.B;
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
                fullView ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: const BattleSide(),
            secondChild: Column(
              children: [
                const BattleSideCompact(),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => BlocProvider.of<GameBloc>(context).add(
                    const RequestFocus(sideFocus: GameSideFocus.B),
                  ),
                  child: const Text('Expand...'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameControl(BuildContext context) {
    return SizedBox(
      height: context.read<BoardSizer>().controlLineHeight,
      width: context.read<BoardSizer>().controlLineWidth,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FrostWeatherSwitch(),
          FogWeatherSwitch(),
          RainWeatherSwitch(),
          VerticalDivider(),
          ScorchButton(),
          VerticalDivider(),
          ResetButton(),
          ExitButton(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameBloc.close();
    battleSideBlocA.close();
    battleSideBlocB.close();
    packBloc.close();
    super.dispose();
  }
}
