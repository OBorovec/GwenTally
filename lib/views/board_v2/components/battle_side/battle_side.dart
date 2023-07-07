import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/views/board_v2/components/battle_line/battle_line.dart';
import 'package:gwentboard/views/board_v2/components/battle_line/bloc/battle_line_bloc.dart';

class BattleSide extends StatefulWidget {
  final bool reversed;
  final BattleLineBloc frontLineBloc;
  final BattleLineBloc backLineBloc;
  final BattleLineBloc siegeLineBloc;

  const BattleSide({
    super.key,
    required this.reversed,
    required this.frontLineBloc,
    required this.backLineBloc,
    required this.siegeLineBloc,
  });

  @override
  State<BattleSide> createState() => _BattleSideState();
}

class _BattleSideState extends State<BattleSide> {
  late final List<BlocProvider> battleLines;

  @override
  void initState() {
    super.initState();
    battleLines = widget.reversed
        ? [
            _buildBattleLine(
              bloc: widget.siegeLineBloc,
              child: const _SiegeLine(),
            ),
            _buildBattleLine(
              bloc: widget.backLineBloc,
              child: const _BackLine(),
            ),
            _buildBattleLine(
              bloc: widget.frontLineBloc,
              child: const _FrontLine(),
            ),
          ]
        : [
            _buildBattleLine(
              bloc: widget.frontLineBloc,
              child: const _FrontLine(),
            ),
            _buildBattleLine(
              bloc: widget.backLineBloc,
              child: const _BackLine(),
            ),
            _buildBattleLine(
              bloc: widget.siegeLineBloc,
              child: const _SiegeLine(),
            ),
          ];
  }

  BlocProvider _buildBattleLine({
    required BattleLineBloc bloc,
    required Widget child,
  }) {
    return BlocProvider<BattleLineBloc>(
      create: (context) => bloc,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: battleLines,
      ),
    );
  }
}

class _FrontLine extends StatelessWidget {
  const _FrontLine();

  @override
  Widget build(BuildContext context) {
    return const BattleLine(
      title: 'Front line',
      weatherIcon: 'wi-snow',
    );
  }
}

class _BackLine extends StatelessWidget {
  const _BackLine();

  @override
  Widget build(BuildContext context) {
    return const BattleLine(
      title: 'Back line',
      weatherIcon: 'wi-rain',
    );
  }
}

class _SiegeLine extends StatelessWidget {
  const _SiegeLine();

  @override
  Widget build(BuildContext context) {
    return const BattleLine(
      title: 'Siege line',
      weatherIcon: 'wi-fog',
    );
  }
}
