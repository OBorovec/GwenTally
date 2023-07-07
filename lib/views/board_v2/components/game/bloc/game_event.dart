part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class GameEventRestart extends GameEvent {}

class GameEventUpdateScoreA extends GameEvent {
  final int newScore;
  const GameEventUpdateScoreA({
    required this.newScore,
  });
}

class GameEventUpdateScoreB extends GameEvent {
  final int newScore;
  const GameEventUpdateScoreB({
    required this.newScore,
  });
}
