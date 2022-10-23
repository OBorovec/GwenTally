part of 'battle_side_bloc.dart';

class BattleSideState extends Equatable {
  final int score;
  final bool commanderPlayed;
  final DateTime? lastPlayerAction;
  final List<CardData> frontlineCards;
  final List<CardData> backlineCards;
  final List<CardData> artylineCards;
  final bool frontlineWeather;
  final bool backlineWeather;
  final bool artylineWeather;
  final bool frontlineMorale;
  final bool backlineMorale;
  final bool artylineMorale;
  final DateTime? lastPlayTurn;

  const BattleSideState({
    this.score = 0,
    this.commanderPlayed = false,
    this.lastPlayerAction,
    this.frontlineCards = const <CardData>[],
    this.backlineCards = const <CardData>[],
    this.artylineCards = const <CardData>[],
    this.frontlineWeather = false,
    this.backlineWeather = false,
    this.artylineWeather = false,
    this.frontlineMorale = false,
    this.backlineMorale = false,
    this.artylineMorale = false,
    this.lastPlayTurn,
  });

  @override
  List<Object?> get props => [
        score,
        commanderPlayed,
        frontlineCards,
        backlineCards,
        artylineCards,
        frontlineWeather,
        backlineWeather,
        artylineWeather,
        frontlineMorale,
        backlineMorale,
        artylineMorale,
      ];

  BattleSideState copyWith({
    int? score,
    bool? commanderPlayed,
    DateTime? lastPlayerAction,
    List<CardData>? frontlineCards,
    List<CardData>? backlineCards,
    List<CardData>? artylineCards,
    bool? frontlineWeather,
    bool? backlineWeather,
    bool? artylineWeather,
    bool? frontlineMorale,
    bool? backlineMorale,
    bool? artylineMorale,
  }) {
    return BattleSideState(
      score: score ?? this.score,
      commanderPlayed: commanderPlayed ?? this.commanderPlayed,
      lastPlayerAction: lastPlayerAction ?? this.lastPlayerAction,
      frontlineCards: frontlineCards ?? this.frontlineCards,
      backlineCards: backlineCards ?? this.backlineCards,
      artylineCards: artylineCards ?? this.artylineCards,
      frontlineWeather: frontlineWeather ?? this.frontlineWeather,
      backlineWeather: backlineWeather ?? this.backlineWeather,
      artylineWeather: artylineWeather ?? this.artylineWeather,
      frontlineMorale: frontlineMorale ?? this.frontlineMorale,
      backlineMorale: backlineMorale ?? this.backlineMorale,
      artylineMorale: artylineMorale ?? this.artylineMorale,
    );
  }
}
