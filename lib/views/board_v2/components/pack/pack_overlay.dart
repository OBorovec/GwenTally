// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/views/board_v2/board_config.dart';
import 'package:gwentboard/views/board_v2/components/pack/bloc/pack_bloc.dart';

class PackOverlayConfig {
  final double radius;
  // General btn options
  final double optBtnSize;
  final double optBtnPadding;
  // Options for the pack numerical picker
  final double optBtnFont;
  // Options for the pack attribute picker
  final double optBtnIconSize;

  const PackOverlayConfig({
    required this.radius,
    required this.optBtnSize,
    required this.optBtnPadding,
    required this.optBtnFont,
    required this.optBtnIconSize,
  });
}

class PackOverlay extends StatelessWidget {
  final String? heroTag;

  const PackOverlay({
    super.key,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final PackOverlayConfig config =
        context.read<BoardConfig>().packOverlayConfig;
    final double size = 2 * config.radius;
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocBuilder<PackBloc, PackState>(
          buildWhen: (previous, current) => previous.stage != current.stage,
          builder: (context, state) {
            return IgnorePointer(
              ignoring: state.stage == PackStage.closed,
              child: AnimatedOpacity(
                opacity: state.stage == PackStage.closed ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: size,
            width: size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                PackAttPicker(size: config.radius, radius: config.radius * 0.8),
                PackNumPicker(size: config.radius, radius: config.radius),
                const Align(
                  alignment: Alignment.center,
                  child: PackCloseBtn(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PackCloseBtn extends StatelessWidget {
  const PackCloseBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      buildWhen: (previous, current) => previous.stage != current.stage,
      builder: (context, state) {
        final bool isVisible = state.stage != PackStage.closed;
        return IgnorePointer(
          ignoring: state.stage == PackStage.closed,
          child: AnimatedContainer(
            transformAlignment: Alignment.center,
            transform: Matrix4.diagonal3Values(
              !isVisible ? 0.7 : 1.0,
              !isVisible ? 0.7 : 1.0,
              1.0,
            ),
            duration: const Duration(milliseconds: 250),
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
            child: AnimatedOpacity(
              opacity: !isVisible ? 0.0 : 1.0,
              curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
              duration: const Duration(milliseconds: 250),
              child: SizedBox(
                width: 56,
                height: 56,
                child: Center(
                  child: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    child: InkWell(
                      onTap: () => BlocProvider.of<PackBloc>(context).add(
                        const PackEventClose(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ExpandingPicker extends StatefulWidget {
  final double size;
  final double radius;
  final List<Widget> items;
  final PackStage trigger;

  const _ExpandingPicker({
    required this.size,
    required this.radius,
    required this.items,
    required this.trigger,
  });

  @override
  State<_ExpandingPicker> createState() => __ExpandingPickerState();
}

class __ExpandingPickerState extends State<_ExpandingPicker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PackOverlayConfig config =
        context.read<BoardConfig>().packOverlayConfig;
    final step = 360.0 / widget.items.length;
    final childCenterOffset = Offset(
      widget.size - config.optBtnSize / 2, // To the left
      widget.size - config.optBtnSize / 2, // To the top
    );
    return BlocListener<PackBloc, PackState>(
      listenWhen: (previous, current) => previous.stage != current.stage,
      listener: (context, state) {
        if (state.stage == widget.trigger) {
          Future.delayed(const Duration(milliseconds: 200), () {
            _controller.forward();
          });
        } else {
          _controller.reverse();
        }
      },
      child: BlocBuilder<PackBloc, PackState>(
        builder: (context, state) {
          return IgnorePointer(
            ignoring: state.stage != widget.trigger,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (var i = 0, angleInDegrees = -90.0;
                    i < widget.items.length;
                    i++, angleInDegrees += step)
                  _ExpandingActionButton(
                    childCenterOffset: childCenterOffset,
                    directionInDegrees: angleInDegrees,
                    maxDistance: widget.radius,
                    progress: _animation,
                    child: widget.items[i],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {
  final Offset childCenterOffset;
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  const _ExpandingActionButton({
    required this.childCenterOffset,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          left: childCenterOffset.dx + offset.dx,
          top: childCenterOffset.dy + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * pi / 2,
            child: child,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: theme.colorScheme.secondary,
          elevation: 4,
          child: child,
        ),
      ),
    );
  }
}

class PackAttPicker extends StatelessWidget {
  final double size;
  final double radius;

  PackAttPicker({
    super.key,
    required this.size,
    required this.radius,
  });

  final List<Widget> attOptionBtns = attValues
      .map(
        (value) => _AttOptionBtn(cardAtt: value),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return _ExpandingPicker(
      size: size,
      radius: radius,
      items: attOptionBtns,
      trigger: PackStage.att,
    );
  }
}

class PackNumPicker extends StatelessWidget {
  final double size;
  final double radius;

  PackNumPicker({
    super.key,
    required this.radius,
    required this.size,
  });

  final List<Widget> numOptionBtns = numValues
      .map(
        (value) => _NumValueBtn(
          value: value,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return _ExpandingPicker(
      size: size,
      radius: radius,
      items: numOptionBtns,
      trigger: PackStage.num,
    );
  }
}

class _NumValueBtn extends StatelessWidget {
  final int value;

  const _NumValueBtn({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final PackOverlayConfig config =
        context.read<BoardConfig>().packOverlayConfig;
    return InkWell(
      onTap: () => BlocProvider.of<PackBloc>(context).add(
        PackEventSetNum(
          value: value,
        ),
      ),
      child: SizedBox(
        width: config.optBtnSize,
        height: config.optBtnSize,
        child: Center(
          child: Text(
            value.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: config.optBtnFont,
                ),
          ),
        ),
      ),
    );
  }
}

class _AttOptionBtn extends StatelessWidget {
  final PackCardAtt cardAtt;

  const _AttOptionBtn({
    required this.cardAtt,
  });

  @override
  Widget build(BuildContext context) {
    final PackOverlayConfig config =
        context.read<BoardConfig>().packOverlayConfig;
    return InkWell(
      onTap: () => BlocProvider.of<PackBloc>(context).add(
        PackEventSetAtt(value: cardAtt),
      ),
      child: SizedBox(
        width: config.optBtnSize,
        height: config.optBtnSize,
        child: Center(
          child: _getCardIcon(cardAtt, context),
        ),
      ),
    );
  }

  Widget _getCardIcon(PackCardAtt cardAtt, BuildContext context) {
    final PackOverlayConfig config =
        context.read<BoardConfig>().packOverlayConfig;

    if (cardAtt == PackCardAtt.horn) {
      return ImageIcon(
        GwentIcons.commanderHorn,
        color: Theme.of(context).colorScheme.onSecondary,
        size: config.optBtnIconSize,
      );
    } else if (cardAtt == PackCardAtt.bond) {
      return Icon(
        GwentIcons.tightBond,
        color: Theme.of(context).colorScheme.onSecondary,
        size: config.optBtnIconSize,
      );
    } else if (cardAtt == PackCardAtt.morale) {
      return Icon(
        GwentIcons.morale,
        color: Theme.of(context).colorScheme.onSecondary,
        size: config.optBtnIconSize,
      );
    } else if (cardAtt == PackCardAtt.demorale) {
      return Icon(
        GwentIcons.demorale,
        color: Theme.of(context).colorScheme.onSecondary,
        size: config.optBtnIconSize,
      );
    } else if (cardAtt == PackCardAtt.hero) {
      return ImageIcon(
        GwentIcons.hero,
        color: Colors.yellow[700],
        size: config.optBtnIconSize,
      );
    } else {
      return Text(
        cardAtt.toString(),
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
  }
}
