import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/components/battle_side/bs_lines.dart';

class BattleSide extends StatelessWidget {
  final bool showReversed;
  const BattleSide({
    Key? key,
    this.showReversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BattleSideBloc, BattleSideState>(
      builder: (context, state) {
        List<Widget> columnContent = [
          FrontLine(
            battleSideState: state,
          ),
          BackLine(
            battleSideState: state,
          ),
          ArtyLine(
            battleSideState: state,
          ),
        ];
        if (showReversed) columnContent = columnContent.reversed.toList();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: columnContent,
        );
      },
    );
  }
}
