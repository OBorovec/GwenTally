import 'package:flutter/material.dart';
import 'dart:math' as math;

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
    required this.child,
    required this.heroTag,
    this.alignment = Alignment.bottomRight,
  })  : assert(distance <= 150),
        super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;
  final Widget child;
  final String heroTag;
  final Alignment alignment;

  static const double maxDistance = 200;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2 * ExpandableFab.maxDistance,
      width: 2 * ExpandableFab.maxDistance,
      child: Stack(
        alignment: widget.alignment,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(widget.alignment),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons(Alignment alignment) {
    final children = <Widget>[];
    final count = widget.children.length;
    late final double step;
    late final double initAngle;
    late final Offset offsetRoot;
    if (alignment == Alignment.center) {
      step = 360 / count;
      initAngle = 0;
      offsetRoot = const Offset(
        ExpandableFab.maxDistance - 33,
        ExpandableFab.maxDistance - 24,
      );
    } else if (alignment == Alignment.centerRight) {
      step = 180 / (count - 1);
      initAngle = 270;
      offsetRoot = const Offset(0, ExpandableFab.maxDistance - 24);
    } else if (alignment == Alignment.centerLeft) {
      step = 180 / (count - 1);
      initAngle = 90;
      offsetRoot = const Offset(
        2 * ExpandableFab.maxDistance - 66,
        ExpandableFab.maxDistance - 24,
      );
    } else if (alignment == Alignment.bottomCenter) {
      step = 180 / (count - 1);
      initAngle = 0;
      offsetRoot = const Offset(ExpandableFab.maxDistance - 24, 0);
    } else {
      step = 90.0 / (count - 1);
      initAngle = 0;
      offsetRoot = const Offset(0, 0);
    }
    for (var i = 0, angleInDegrees = initAngle;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          alignmentOffset: offsetRoot,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            heroTag: widget.heroTag,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    required this.alignmentOffset,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  final Offset alignmentOffset;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4 + offset.dx + alignmentOffset.dx,
          bottom: 4 + offset.dy + alignmentOffset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final Function() onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
