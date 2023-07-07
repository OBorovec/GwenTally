import 'package:flutter/material.dart';

import 'package:gwentboard/components/gameplay/board_card.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/model/card_played.dart';

class CardLine extends StatelessWidget {
  final List<PlayedCard> cards;
  final CardConfig cardConfig;
  final Function(CardData data) onAccept;
  final Function(PlayedCard data) onRemove;

  const CardLine({
    Key? key,
    required this.cards,
    required this.cardConfig,
    required this.onAccept,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardConfig.cardHeight +
          2 * cardConfig.outerPadding +
          2 * cardConfig.border,
      decoration: const BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: DragTarget<CardData>(
        builder: (BuildContext context, List candidateData, List rejectedData) {
          return Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: cards
                    .map(
                      (PlayedCard card) => BoardCard(
                        config: cardConfig,
                        card: card,
                        onDoubleTap: () => onRemove(
                          card,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
        onAccept: (CardData data) => onAccept(data),
      ),
    );
  }
}
