part of 'battle_side_bloc.dart';

class BattleSideState extends Equatable {
  final int score;
  final bool commanderPlayed;
  final DateTime? lastPlayerAction;
  final List<PlayedCard> frontLineCards;
  final List<PlayedCard> backLineCards;
  final List<PlayedCard> artyLineCards;
  final bool frontLineWeather;
  final bool backLineWeather;
  final bool artyLineWeather;
  final bool frontLineMorale;
  final bool backLineMorale;
  final bool artyLineMorale;
  final DateTime? lastPlayTurn;

  const BattleSideState({
    this.score = 0,
    this.commanderPlayed = false,
    this.lastPlayerAction,
    this.frontLineCards = const <PlayedCard>[],
    this.backLineCards = const <PlayedCard>[],
    this.artyLineCards = const <PlayedCard>[],
    this.frontLineWeather = false,
    this.backLineWeather = false,
    this.artyLineWeather = false,
    this.frontLineMorale = false,
    this.backLineMorale = false,
    this.artyLineMorale = false,
    this.lastPlayTurn,
  });

  @override
  List<Object?> get props => [
        score,
        commanderPlayed,
        frontLineCards,
        backLineCards,
        artyLineCards,
        frontLineWeather,
        backLineWeather,
        artyLineWeather,
        frontLineMorale,
        backLineMorale,
        artyLineMorale,
      ];

  BattleSideState copyWith({
    int? score,
    bool? commanderPlayed,
    DateTime? lastPlayerAction,
    List<PlayedCard>? frontlineCards,
    List<PlayedCard>? backlineCards,
    List<PlayedCard>? artylineCards,
    bool? frontlineWeather,
    bool? backlineWeather,
    bool? artylineWeather,
    bool? frontlineMorale,
    bool? backlineMorale,
    bool? artylineMorale,
    DateTime? lastPlayTurn,
  }) {
    return BattleSideState(
      score: score ?? this.score,
      commanderPlayed: commanderPlayed ?? this.commanderPlayed,
      lastPlayerAction: lastPlayerAction ?? this.lastPlayerAction,
      frontLineCards: frontlineCards ?? frontLineCards,
      backLineCards: backlineCards ?? backLineCards,
      artyLineCards: artylineCards ?? artyLineCards,
      frontLineWeather: frontlineWeather ?? frontLineWeather,
      backLineWeather: backlineWeather ?? backLineWeather,
      artyLineWeather: artylineWeather ?? artyLineWeather,
      frontLineMorale: frontlineMorale ?? frontLineMorale,
      backLineMorale: backlineMorale ?? backLineMorale,
      artyLineMorale: artylineMorale ?? artyLineMorale,
      lastPlayTurn: lastPlayTurn ?? this.lastPlayTurn,
    );
  }
}
