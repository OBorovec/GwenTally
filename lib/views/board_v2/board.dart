import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/components/dialogs/match_start.dart';
import 'package:gwentboard/components/shared/layout/pop_page.dart';
import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/views/board_v2/board_config.dart';
import 'package:gwentboard/views/board_v2/components/battle_line/bloc/battle_line_bloc.dart';
import 'package:gwentboard/views/board_v2/components/battle_side/battle_side.dart';
import 'package:gwentboard/views/board_v2/components/battle_side/bloc/battle_side_bloc.dart';
import 'package:gwentboard/views/board_v2/components/game/bloc/game_bloc.dart';
import 'package:gwentboard/views/board_v2/components/game/game_score.dart';
import 'package:gwentboard/views/board_v2/components/pack/bloc/pack_bloc.dart';
import 'package:gwentboard/views/board_v2/components/pack/pack_btn.dart';
import 'package:gwentboard/views/board_v2/components/pack/pack_overlay.dart';
import 'package:gwentboard/views/board_v2/components/pack/pack_overview.dart';

class Gwent2Board extends StatefulWidget {
  const Gwent2Board({Key? key}) : super(key: key);

  @override
  State<Gwent2Board> createState() => _Gwent2BoardState();
}

class _Gwent2BoardState extends State<Gwent2Board> {
  late GameBloc _gameBloc;
  late PackBloc _packBloc;
  late BattleSideBloc _battleSideBlocA;
  late BattleSideBloc _battleSideBlocB;
  late BattleLineBloc _frontLineBlocA;
  late BattleLineBloc _backLineBlocA;
  late BattleLineBloc _siegeLineBlocA;
  late BattleLineBloc _frontLineBlocB;
  late BattleLineBloc _backLineBlocB;
  late BattleLineBloc _siegeLineBlocB;

  @override
  void initState() {
    super.initState();
    _frontLineBlocA = BattleLineBloc();
    _backLineBlocA = BattleLineBloc();
    _siegeLineBlocA = BattleLineBloc();
    _frontLineBlocB = BattleLineBloc();
    _backLineBlocB = BattleLineBloc();
    _siegeLineBlocB = BattleLineBloc();
    _battleSideBlocA = BattleSideBloc(
      frontLineBloc: _frontLineBlocA,
      backLineBloc: _backLineBlocA,
      siegeLineBloc: _siegeLineBlocA,
    );
    _battleSideBlocB = BattleSideBloc(
      frontLineBloc: _frontLineBlocB,
      backLineBloc: _backLineBlocB,
      siegeLineBloc: _siegeLineBlocB,
    );
    _packBloc = PackBloc();
    _gameBloc = GameBloc(
      battleSideBlocA: _battleSideBlocA,
      battleSideBlocB: _battleSideBlocB,
      // packBloc: packBloc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopDialogPage(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final BoardConfig config = BoardConfig(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              );
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => _gameBloc,
                  ),
                  BlocProvider(
                    create: (context) => _packBloc,
                  ),
                ],
                child: MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider(
                      create: (context) => config,
                    ),
                  ],
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: BlocProvider(
                              create: (context) => _battleSideBlocA,
                              child: BattleSide(
                                reversed: true,
                                frontLineBloc: _frontLineBlocA,
                                backLineBloc: _backLineBlocA,
                                siegeLineBloc: _siegeLineBlocA,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: config.packOverviewConfig.height,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(child: Center(child: GameScore())),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: PackOpenBtn(),
                                  ),
                                  Expanded(child: PackOverview()),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: BlocProvider(
                              create: (context) => _battleSideBlocB,
                              child: BattleSide(
                                reversed: false,
                                frontLineBloc: _frontLineBlocB,
                                backLineBloc: _backLineBlocB,
                                siegeLineBloc: _siegeLineBlocB,
                              ),
                            ),
                          ),
                        ],
                      ),
                      PackOverlay(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
            IconButton(
              icon: const ImageIcon(GwentIcons.coinToss),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return const MarchStartDialog();
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.restart_alt),
              onPressed: () {
                _battleSideBlocA.add(const ResetBattleSide());
                _battleSideBlocB.add(const ResetBattleSide());
              },
            ),
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () => Navigator.maybePop(context, false),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
