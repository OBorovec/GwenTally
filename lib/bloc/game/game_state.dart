part of 'game_bloc.dart';

class GameState extends Equatable {
  final int scoreA;
  final int scoreB;
  final bool isFrost;
  final bool isFog;
  final bool isRain;
  final int highestCardScore;
  final bool isTurnA;

  const GameState({
    this.scoreA = 0,
    this.scoreB = 0,
    this.isFrost = false,
    this.isFog = false,
    this.isRain = false,
    this.highestCardScore = 0,
    this.isTurnA = true,
  });

  @override
  List<Object> get props => [
        scoreA,
        scoreB,
        isFrost,
        isFog,
        isRain,
        highestCardScore,
        isTurnA,
      ];

  GameState copyWith({
    int? scoreA,
    int? scoreB,
    bool? isFrost,
    bool? isFog,
    bool? isRain,
    int? highestCardScore,
    bool? isTurnA,
  }) {
    return GameState(
      scoreA: scoreA ?? this.scoreA,
      scoreB: scoreB ?? this.scoreB,
      isFrost: isFrost ?? this.isFrost,
      isFog: isFog ?? this.isFog,
      isRain: isRain ?? this.isRain,
      highestCardScore: highestCardScore ?? this.highestCardScore,
      isTurnA: isTurnA ?? this.isTurnA,
    );
  }
}
