import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/views/board_v2/components/pack/bloc/pack_bloc.dart';

class PackOpenBtn extends StatelessWidget {
  final String? heroTag;

  const PackOpenBtn({
    super.key,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      buildWhen: (previous, current) => previous.stage != current.stage,
      builder: (context, state) {
        final bool isVisible = state.stage == PackStage.closed;
        return IgnorePointer(
          ignoring: !isVisible,
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
              child: FloatingActionButton(
                onPressed: () => BlocProvider.of<PackBloc>(context).add(
                  const PackEventOpen(),
                ),
                heroTag: heroTag,
                child: const Icon(Icons.create),
              ),
            ),
          ),
        );
      },
    );
  }
}
