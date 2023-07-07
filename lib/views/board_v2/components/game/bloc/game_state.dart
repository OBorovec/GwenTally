// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  final int scoreA;
  final int scoreB;

  const GameState({
    this.scoreA = 0,
    this.scoreB = 0,
  });

  @override
  List<Object> get props => [
        scoreA,
        scoreB,
      ];

  GameState copyWith({
    int? scoreA,
    int? scoreB,
  }) {
    return GameState(
      scoreA: scoreA ?? this.scoreA,
      scoreB: scoreB ?? this.scoreB,
    );
  }
}
