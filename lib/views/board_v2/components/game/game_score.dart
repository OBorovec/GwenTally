import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/views/board_v2/components/game/bloc/game_bloc.dart';

class GameScore extends StatelessWidget {
  const GameScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<GameBloc, GameState>(
            buildWhen: (previous, current) => previous.scoreA != current.scoreA,
            builder: (context, state) {
              return FittedBox(
                child: Text(
                  state.scoreA.toString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              );
            },
          ),
          Text(
            ' : ',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          BlocBuilder<GameBloc, GameState>(
            buildWhen: (previous, current) => previous.scoreB != current.scoreB,
            builder: (context, state) {
              return Text(
                state.scoreB.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
