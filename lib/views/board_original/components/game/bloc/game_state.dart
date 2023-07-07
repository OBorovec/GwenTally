// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

enum GameSideFocus { A, B, both }

class GameState extends Equatable {
  final int scoreA;
  final int scoreB;
  final bool isFrost;
  final bool isFog;
  final bool isRain;
  final int highestCardScore;
  final GameSideFocus sideFocus;

  const GameState({
    this.scoreA = 0,
    this.scoreB = 0,
    this.isFrost = false,
    this.isFog = false,
    this.isRain = false,
    this.highestCardScore = 0,
    this.sideFocus = GameSideFocus.both,
  });

  @override
  List<Object> get props => [
        scoreA,
        scoreB,
        isFrost,
        isFog,
        isRain,
        highestCardScore,
      ];

  GameState copyWith({
    int? scoreA,
    int? scoreB,
    bool? isFrost,
    bool? isFog,
    bool? isRain,
    int? highestCardScore,
    GameSideFocus? sideFocus,
  }) {
    return GameState(
      scoreA: scoreA ?? this.scoreA,
      scoreB: scoreB ?? this.scoreB,
      isFrost: isFrost ?? this.isFrost,
      isFog: isFog ?? this.isFog,
      isRain: isRain ?? this.isRain,
      highestCardScore: highestCardScore ?? this.highestCardScore,
      sideFocus: sideFocus ?? this.sideFocus,
    );
  }
}
