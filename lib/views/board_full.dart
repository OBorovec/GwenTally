import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/bloc/game/game_bloc.dart';
import 'package:gwentboard/bloc/pack/pack_bloc.dart';
import 'package:gwentboard/components/_page/pop_page.dart';
import 'package:gwentboard/components/battle_side/battle_side.dart';
import 'package:gwentboard/components/game/game_control_state.dart';
import 'package:gwentboard/components/game/game_score.dart';
import 'package:gwentboard/components/game/game_control_weather.dart';
import 'package:gwentboard/components/pack/pack_control.dart';
import 'package:gwentboard/components/pack/pack_wrap.dart';
import 'package:gwentboard/utils/board_sizer.dart';
import 'package:provider/provider.dart';

class FullBoardPage extends StatefulWidget {
  const FullBoardPage({Key? key}) : super(key: key);

  @override
  State<FullBoardPage> createState() => _FullBoardPageState();
}

class _FullBoardPageState extends State<FullBoardPage> {
  late BattleSideBloc battleSideBlocA;
  late BattleSideBloc battleSideBlocB;
  late PackBloc packBloc;
  late GameBloc gameBloc;

  // late BoardSizer boardSizer;

  @override
  void initState() {
    super.initState();
    // init blocs
    battleSideBlocA = BattleSideBloc();
    battleSideBlocB = BattleSideBloc();
    packBloc = PackBloc();
    gameBloc = GameBloc(
      battleSideBlocA: battleSideBlocA,
      battleSideBlocB: battleSideBlocB,
      packBloc: packBloc,
    );
    // init sizing
    // double pixelRatio = window.devicePixelRatio;
    // Size logicalScreenSize = window.physicalSize / pixelRatio;
    // double width = logicalScreenSize.width;
    // double height = logicalScreenSize.height;
    // boardSizer = BoardSizer.calcBoardSizer(width: width, height: height);
    // debugPrint('Screen size: $width x $height');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Provider(
      create: (_) => BoardSizer.calcBoardSizer(width: width, height: height),
      child: Builder(builder: (context) {
        return PopDialogPage(
          body: BlocProvider(
            create: (context) => gameBloc,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Top side
                    BlocProvider(
                      create: (context) => battleSideBlocA,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: BattleSide(
                          showReversed: true,
                        ),
                      ),
                    ),
                    // Score and pack
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const GameScore(),
                        Expanded(
                          child: BlocProvider(
                              create: (context) => packBloc,
                              child:
                                  !context.read<BoardSizer>().isSingleLinePack
                                      ? Row(
                                          children: const [
                                            Expanded(child: CardPackWrap()),
                                            PackControl(),
                                          ],
                                        )
                                      : Column(
                                          children: const [
                                            PackControlRow(),
                                            CardPackWrap()
                                          ],
                                        )),
                        ),
                      ],
                    ),
                    // Control line
                    SizedBox(
                      height: context.read<BoardSizer>().controlLineHeight,
                      width: context.read<BoardSizer>().controlLineWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
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
                    ),
                    const SizedBox(height: 8),
                    // Bottom side
                    BlocProvider(
                      create: (context) => battleSideBlocB,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: BattleSide(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
