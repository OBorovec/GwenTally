// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pack_bloc.dart';

enum PackStage { closed, num, att }

class PackState extends Equatable {
  final bool isEmpty;
  final PackStage stage;
  final CardData? topCard;
  final List<CardData> usedCards;
  final List<CardData> recentCards;

  const PackState({
    this.isEmpty = true,
    this.stage = PackStage.closed,
    this.topCard,
    this.usedCards = const [],
    this.recentCards = const [],
  });

  @override
  List<Object> get props => [
        isEmpty,
        stage,
        topCard ?? '',
        usedCards,
        recentCards,
      ];

  PackState copyWith({
    bool? isEmpty,
    PackStage? stage,
    CardData? topCard,
    List<CardData>? usedCards,
    List<CardData>? recentCards,
  }) {
    return PackState(
      isEmpty: isEmpty ?? this.isEmpty,
      stage: stage ?? this.stage,
      topCard: topCard ?? this.topCard,
      usedCards: usedCards ?? this.usedCards,
      recentCards: recentCards ?? this.recentCards,
    );
  }
}
