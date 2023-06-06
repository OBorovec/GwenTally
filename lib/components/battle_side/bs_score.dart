import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/utils/board_sizer.dart';

class BattleSideScore extends StatelessWidget {
  const BattleSideScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BattleSideBloc, BattleSideState>(
      builder: (context, state) {
        return Text(
          state.score.toString(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: context.read<BoardSizer>().scoreFontSize,
              ),
        );
      },
    );
  }
}
