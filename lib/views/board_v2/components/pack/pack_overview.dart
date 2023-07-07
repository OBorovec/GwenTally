import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/components/gameplay/board_card.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/views/board_v2/board_config.dart';
import 'package:gwentboard/views/board_v2/components/pack/bloc/pack_bloc.dart';

class PackOverviewConfig {
  late final double height;

  PackOverviewConfig({
    required this.height,
  });
}

class PackOverview extends StatelessWidget {
  const PackOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      buildWhen: (previous, current) => previous.isEmpty != current.isEmpty,
      builder: (context, state) {
        if (state.isEmpty) {
          return Row(
            children: [
              const Icon(Icons.arrow_left),
              Expanded(
                child: Text(
                  'Use to create cards.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          );
        }
        return const IntrinsicHeight(
          child: Row(
            children: [
              _PackTopCard(),
              VerticalDivider(),
              Expanded(
                child: _PackRecentCards(),
              )
            ],
          ),
        );
      },
    );
  }
}

class _PackTopCard extends StatelessWidget {
  const _PackTopCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      buildWhen: (previous, current) => previous.topCard != current.topCard,
      builder: (context, state) {
        CardConfig packTopConfig = context.read<BoardConfig>().packTopCard;
        return BoardCard(
          data: state.topCard,
          config: packTopConfig,
          isDraggable: true,
          childWhenDragging: BoardCard(
            config: packTopConfig,
          ),
        );
      },
    );
  }
}

class _PackRecentCards extends StatelessWidget {
  const _PackRecentCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      buildWhen: (previous, current) =>
          previous.recentCards != current.recentCards,
      builder: (context, state) {
        CardConfig boardCardConfig = context.read<BoardConfig>().boardCard;
        return Row(
            children: state.recentCards
                .map((CardData card) => BoardCard(
                      data: card,
                      config: boardCardConfig,
                      isDraggable: true,
                      childWhenDragging: BoardCard(
                        config: boardCardConfig,
                      ),
                    ))
                .toList());
      },
    );
  }
}
