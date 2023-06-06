import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/game/game_bloc.dart';
import 'package:gwentboard/utils/board_sizer.dart';

class GameScore extends StatelessWidget {
  const GameScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              state.scoreA.toString().padLeft(2, '0'),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: context.read<BoardSizer>().scoreFontSize,
                  ),
            ),
            const Text('vs'),
            Text(
              state.scoreB.toString().padLeft(2, '0'),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: context.read<BoardSizer>().scoreFontSize,
                  ),
            ),
          ],
        );
      },
    );
  }
}
