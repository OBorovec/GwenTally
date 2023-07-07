// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'battle_line_bloc.dart';

class BattleLineState extends Equatable {
  final int score;
  final DateTime? lastPlayerAction;
  final List<PlayedCard> cards;
  final bool weather;
  final bool horn;
  const BattleLineState({
    this.score = 0,
    this.lastPlayerAction,
    this.cards = const <PlayedCard>[],
    this.weather = false,
    this.horn = false,
  });

  @override
  List<Object> get props => [
        score,
        lastPlayerAction ?? '',
        cards,
        weather,
        horn,
      ];

  BattleLineState copyWith({
    int? score,
    DateTime? lastPlayerAction,
    List<PlayedCard>? cards,
    bool? weather,
    bool? horn,
  }) {
    return BattleLineState(
      score: score ?? this.score,
      lastPlayerAction: lastPlayerAction ?? this.lastPlayerAction,
      cards: cards ?? this.cards,
      weather: weather ?? this.weather,
      horn: horn ?? this.horn,
    );
  }
}
