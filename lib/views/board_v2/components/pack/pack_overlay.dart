// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/constants/gwent_icons.dart';
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

class PackOverlay extends StatefulWidget {
  final String? heroTag;

  const PackOverlay({
    super.key,
    this.heroTag,
  });

  @override
  State<PackOverlay> createState() => _PackOverlayState();
}

class _PackOverlayState extends State<PackOverlay> {
  final List<_ExpandingActionButtonData> attOptionBtns = attValues
      .map((PackCardAtt attribute) => _ExpandingActionButtonData(
            event: PackEventSetAtt(value: attribute),
            child: _AttOptionBtn(cardAtt: attribute),
          ))
      .toList();

  final List<_ExpandingActionButtonData> numOptionBtns = numValues
      .map((int value) => _ExpandingActionButtonData(
            event: PackEventSetNum(value: value),
            child: Text(value.toString()),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox.square(
          dimension: constraints.maxWidth,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _ExpandingPicker(
                size: constraints.maxWidth,
                radius: constraints.maxWidth * 0.3,
                items: attOptionBtns,
                trigger: PackStage.att,
              ),
              _ExpandingPicker(
                size: constraints.maxWidth,
                radius: constraints.maxWidth * 0.4,
                items: numOptionBtns,
                trigger: PackStage.num,
              ),
              const Center(child: _PackCloseBtn()),
            ],
          ),
        );
      },
    );
  }
}

class _PackCloseBtn extends StatelessWidget {
  const _PackCloseBtn();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      buildWhen: (previous, current) => previous.stage != current.stage,
      builder: (context, state) {
        final bool isVisible = state.stage != PackStage.closed;
        return IgnorePointer(
          ignoring: !isVisible,
          child: AnimatedOpacity(
            opacity: !isVisible ? 0.0 : 1.0,
            curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
            duration: const Duration(milliseconds: 250),
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
        );
      },
    );
  }
}

class _ExpandingPicker extends StatefulWidget {
  final double size;
  final double radius;
  final List<_ExpandingActionButtonData> items;
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

  late final double _stepDegrees = 360.0 / widget.items.length;
  late final double _optBtnSize = sqrt(pow(widget.radius, 2) +
      pow(widget.radius, 2) -
      2 * widget.radius * widget.radius * cos(_stepDegrees * pi / 180));
  late final Offset stackCenter = Offset(
    widget.size / 2 - _optBtnSize / 2,
    widget.size / 2 - _optBtnSize / 2,
  );

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
    return BlocConsumer<PackBloc, PackState>(
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
      buildWhen: (previous, current) => previous.stage != current.stage,
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.stage != widget.trigger,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: buildChildren(),
          ),
        );
      },
    );
  }

  List<Widget> buildChildren() {
    final List<Widget> children = [];
    for (var i = 0, angleInDegrees = -90.0;
        i < widget.items.length;
        i++, angleInDegrees += _stepDegrees) {
      Widget child = _OptButton(
        optBtnSize: _optBtnSize,
        data: widget.items[i],
      );
      children.add(
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final offset = Offset.fromDirection(
              angleInDegrees * (pi / 180.0),
              _animation.value * widget.radius,
            );
            return Positioned(
              left: stackCenter.dx + offset.dx,
              top: stackCenter.dy + offset.dy,
              child: Transform.rotate(
                angle: (1.0 - _animation.value) * pi / 2,
                child: child,
              ),
            );
          },
          child: FadeTransition(
            opacity: _animation,
            child: child,
          ),
        ),
      );
    }
    return children;
  }
}

class _ExpandingActionButtonData {
  final PackEvent event;
  final Widget child;

  _ExpandingActionButtonData({
    required this.event,
    required this.child,
  });
}

class _OptButton extends StatelessWidget {
  final double optBtnSize;
  final _ExpandingActionButtonData data;

  const _OptButton({
    required this.optBtnSize,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(optBtnSize * 0.1),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: theme.colorScheme.secondary,
        elevation: 4,
        child: InkWell(
          onTap: () => BlocProvider.of<PackBloc>(context).add(
            data.event,
          ),
          child: SizedBox(
            width: optBtnSize * 0.8,
            height: optBtnSize * 0.8,
            child: Padding(
              padding: EdgeInsets.all(optBtnSize * 0.2),
              child: FittedBox(
                child: Center(
                  child: data.child,
                ),
              ),
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
    if (cardAtt == PackCardAtt.horn) {
      return ImageIcon(
        GwentIcons.commanderHorn,
        color: Theme.of(context).colorScheme.onSecondary,
      );
    } else if (cardAtt == PackCardAtt.bond) {
      return Icon(
        GwentIcons.tightBond,
        color: Theme.of(context).colorScheme.onSecondary,
      );
    } else if (cardAtt == PackCardAtt.morale) {
      return Icon(
        GwentIcons.morale,
        color: Theme.of(context).colorScheme.onSecondary,
      );
    } else if (cardAtt == PackCardAtt.demorale) {
      return Icon(
        GwentIcons.demorale,
        color: Theme.of(context).colorScheme.onSecondary,
      );
    } else if (cardAtt == PackCardAtt.hero) {
      return ImageIcon(
        GwentIcons.hero,
        color: Colors.yellow[700],
      );
    } else {
      return Text(
        cardAtt.toString(),
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
  }
}
