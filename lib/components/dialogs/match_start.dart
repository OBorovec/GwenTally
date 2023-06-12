import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/game/game_bloc.dart';

class MarchStartDialog extends StatefulWidget {
  const MarchStartDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<MarchStartDialog> createState() => _MarchStartDialogState();
}

class _MarchStartDialogState extends State<MarchStartDialog> {
  bool _coinFlip = false;
  late bool _coinResult;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Match starts...',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Decide who starts or flip a coin to make that decision.'),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: _coinFlip
                ? Column(
                    children: [
                      const Text('Side'),
                      Expanded(
                        child: _CoinFlipper(
                          resultSideA: _coinResult,
                          coinFlips: getRandomCoinFlips(),
                          onAnimationFinished: () {
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.pop(context);
                            });
                            // TODO: Add event to bloc to set the starting side
                          },
                        ),
                      ),
                      const Text('starts.'),
                    ],
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: _flipCoin,
                      child: const Text('Flip a coin'),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // True for side A, false for side B
  bool getRandomSide() => Random().nextBool();

  // Returns 2, 4 or 6
  int getRandomCoinFlips() => Random().nextInt(3) * 2 + 2;

  void _flipCoin() {
    _coinResult = getRandomSide();
    setState(() {
      _coinFlip = true;
    });
  }
}

class _CoinFlipper extends StatefulWidget {
  final int coinFlips;
  final Function() onAnimationFinished;

  const _CoinFlipper({
    Key? key,
    required bool resultSideA,
    required int coinFlips,
    required this.onAnimationFinished,
  })  : coinFlips = coinFlips + (resultSideA ? 0 : 1),
        super(key: key);

  @override
  State<_CoinFlipper> createState() => _CoinFlipperState();
}

class _CoinFlipperState extends State<_CoinFlipper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double degrees90 = pi / 2;
  final double degrees270 = 3 * pi / 2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationFinished();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        double angle =
            (_animation.value * 2 * pi * widget.coinFlips) % (2 * pi);
        bool showSideA = degrees90 < angle && angle < degrees270;
        double zoom =
            -(_animation.value - 0.5) * (_animation.value - 0.5) + 1.2;
        return showSideA
            ? Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
                alignment: Alignment.center,
                child: _CoinSide(
                  letter: 'A',
                  size: 60 * zoom,
                ),
              )
            : Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
                alignment: Alignment.center,
                child: _CoinSide(
                  letter: 'B',
                  size: 60 * zoom,
                ),
              );
      },
    );
  }
}

class _CoinSide extends StatelessWidget {
  final String letter;
  final double size;
  const _CoinSide({
    required this.letter,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
          color: Theme.of(context).colorScheme.background,
          width: 4,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            letter,
            style: TextStyle(fontSize: (size - 20)),
          ),
        ),
      ),
    );
  }
}
