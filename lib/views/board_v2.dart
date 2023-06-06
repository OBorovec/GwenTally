import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/bloc/game/game_bloc.dart';
import 'package:gwentboard/bloc/game_side_focus/game_side_focus_bloc.dart';
import 'package:gwentboard/bloc/pack/pack_bloc.dart';
import 'package:gwentboard/components/_layout/pop_page.dart';
import 'package:gwentboard/components/battle_side/battle_side.dart';
import 'package:gwentboard/components/battle_side/battle_side_compact.dart';
import 'package:gwentboard/components/game/game_control_state.dart';
import 'package:gwentboard/components/game/game_score.dart';
import 'package:gwentboard/components/game/game_control_weather.dart';
import 'package:gwentboard/components/pack/pack_control.dart';
import 'package:gwentboard/components/pack/pack_wrap.dart';
import 'package:gwentboard/utils/board_sizer.dart';

class V2Board extends StatefulWidget {
  const V2Board({Key? key}) : super(key: key);

  @override
  State<V2Board> createState() => _V2BoardState();
}

class _V2BoardState extends State<V2Board> {
  late GameBloc gameBloc;
  late PackBloc packBloc;
  late GameSideFocusBloc gameSideFocusBloc;
  late BattleSideBloc battleSideBlocA;
  late BattleSideBloc battleSideBlocB;

  @override
  void initState() {
    super.initState();
    gameSideFocusBloc = GameSideFocusBloc();
    battleSideBlocA = BattleSideBloc(
      requestFocus: () => gameSideFocusBloc.add(const GameSideFocusEventA()),
      releaseFocus: () => gameSideFocusBloc.add(const GameSideFocusEventB()),
    );
    battleSideBlocB = BattleSideBloc(
      requestFocus: () => gameSideFocusBloc.add(const GameSideFocusEventB()),
      releaseFocus: () => gameSideFocusBloc.add(const GameSideFocusEventA()),
    );
    packBloc = PackBloc();
    gameBloc = GameBloc(
      battleSideBlocA: battleSideBlocA,
      battleSideBlocB: battleSideBlocB,
      packBloc: packBloc,
    );
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
            create: (_) => gameBloc,
          ),
          BlocProvider(
            create: (_) => gameSideFocusBloc
              ..add(
                GameSideFocusEventInit(
                  sideFocus: boardSizer.useFullViews
                      ? GameSideFocus.both
                      : GameSideFocus.none,
                ),
              ),
          ),
        ],
        child: RepositoryProvider(
          create: (context) {
            return boardSizer;
          },
          child: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSideA(),
                  const SizedBox(height: 12),
                  _buildPackWrap(context),
                  _buildGameControl(context),
                  const SizedBox(height: 8),
                  _buildSideB(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    battleSideBlocA.close();
    battleSideBlocB.close();
    packBloc.close();
    gameSideFocusBloc.close();
    gameBloc.close();
    super.dispose();
  }

  Widget _buildSideA() {
    return BlocProvider(
      create: (context) => battleSideBlocA,
      child: BlocBuilder<GameSideFocusBloc, GameSideFocusState>(
        builder: (context, state) {
          final bool fullView = state.sideFocus == GameSideFocus.both ||
              state.sideFocus == GameSideFocus.A;
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
                fullView ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: const BattleSideCompact(reversed: true),
            secondChild: const BattleSide(reversed: true),
          );
        },
      ),
    );
  }

  Widget _buildSideB() {
    return BlocProvider(
      create: (context) => battleSideBlocB,
      child: BlocBuilder<GameSideFocusBloc, GameSideFocusState>(
        builder: (context, state) {
          final bool fullView = state.sideFocus == GameSideFocus.both ||
              state.sideFocus == GameSideFocus.B;
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
                fullView ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: const BattleSideCompact(),
            secondChild: const BattleSide(),
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
          ResetButton(),
          VerticalDivider(),
          ExitButton(),
        ],
      ),
    );
  }

  Widget _buildPackWrap(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const GameScore(),
        Expanded(
          child: BlocProvider(
              create: (context) => packBloc,
              child: !context.read<BoardSizer>().isSingleLinePack
                  ? const Row(
                      children: [
                        Expanded(child: CardPackWrap()),
                        PackControl(),
                      ],
                    )
                  : const Column(
                      children: [PackControlRow(), CardPackWrap()],
                    )),
        ),
      ],
    );
  }
}
