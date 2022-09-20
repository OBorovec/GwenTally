import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/game/game_bloc.dart';
import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/utils/board_sizer.dart';

class ScorchButton extends StatelessWidget {
  const ScorchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _scorchDialog(context, state).then((value) {
            if (value) BlocProvider.of<GameBloc>(context).add(ScorchCards());
          }),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  context.read<BoardSizer>().controlIconPaddingHorizontal,
              vertical: context.read<BoardSizer>().controlIconPaddingVertical,
            ),
            child: ImageIcon(
              GwentIcons.scorch,
              size: context.read<BoardSizer>().controlIconSize,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _scorchDialog(BuildContext context, GameState state) {
    return showDialog(
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
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _resetDialog(context).then((value) {
            if (value) BlocProvider.of<GameBloc>(context).add(RestartGame());
          }),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  context.read<BoardSizer>().controlIconPaddingHorizontal,
              vertical: context.read<BoardSizer>().controlIconPaddingVertical,
            ),
            child: Icon(
              Icons.restart_alt,
              size: context.read<BoardSizer>().controlIconSize,
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _resetDialog(BuildContext context) {
    return showDialog(
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
    );
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.maybePop(context, false),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.read<BoardSizer>().controlIconPaddingHorizontal,
          vertical: context.read<BoardSizer>().controlIconPaddingVertical,
        ),
        child: Icon(
          Icons.cancel,
          size: context.read<BoardSizer>().controlIconSize,
        ),
      ),
    );
  }
}
