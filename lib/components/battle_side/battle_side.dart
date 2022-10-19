import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/battle_side/battle_side_bloc.dart';
import 'package:gwentboard/components/battle_side/bs_lines.dart';

class BattleSide extends StatelessWidget {
  final bool collapsed;
  final bool showReversed;
  const BattleSide({
    Key? key,
    this.collapsed = true,
    this.showReversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BattleSideBloc, BattleSideState>(
      builder: (context, state) {
        List<Widget> columnContent = [
          FrontLine(
            battleSideState: state,
            collapsed: collapsed,
          ),
          BackLine(
            battleSideState: state,
            collapsed: collapsed,
          ),
          ArtyLine(
            battleSideState: state,
            collapsed: collapsed,
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
