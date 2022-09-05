import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/game/game_bloc.dart';
import 'package:gwentboard/constants/gwent_icons.dart';

class GameControl extends StatelessWidget {
  const GameControl({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Use Scorch: ${state.highestCardScore}'),
                  content: Text(
                      'Are you sure, you wanna remove the highest score card? At this moment non-hero cards with score ${state.highestCardScore} would be deleted...'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ).then((value) {
                if (value)
                  BlocProvider.of<GameBloc>(context).add(ScorchCards());
              }),
              icon: ImageIcon(
                GwentIcons.scorch,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Restart board'),
                  content: const Text(
                      'Do you wish to restart current board? All present cards will be removed...'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ).then((value) {
                if (value)
                  BlocProvider.of<GameBloc>(context).add(RestartGame());
              }),
              icon: const Icon(Icons.restart_alt),
            ),
          ],
        );
      },
    );
  }
}
