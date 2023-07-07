// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:gwentboard/model/card_data.dart';

class PlayedCard extends Equatable {
  final DateTime initTime;
  final int activeValue;
  final CardData data;

  const PlayedCard({
    required this.initTime,
    required this.activeValue,
    required this.data,
  });

  @override
  List<Object?> get props => [
        initTime,
        activeValue,
        data,
      ];

  PlayedCard copyWith({
    DateTime? initTime,
    int? activeValue,
    CardData? cardData,
  }) {
    return PlayedCard(
      initTime: initTime ?? this.initTime,
      activeValue: activeValue ?? this.activeValue,
      data: cardData ?? data,
    );
  }
}
