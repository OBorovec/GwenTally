// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'battle_side_bloc.dart';

class BattleSideState extends Equatable {
  final int score;
  final bool commanderPlayed;

  const BattleSideState({
    this.score = 0,
    this.commanderPlayed = false,
  });

  @override
  List<Object?> get props => [
        score,
        commanderPlayed,
      ];

  BattleSideState copyWith({
    int? score,
    bool? commanderPlayed,
  }) {
    return BattleSideState(
      score: score ?? this.score,
      commanderPlayed: commanderPlayed ?? this.commanderPlayed,
    );
  }
}
