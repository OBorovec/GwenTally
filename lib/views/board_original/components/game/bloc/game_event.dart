part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class RestartGame extends GameEvent {}

class UpdateScoreA extends GameEvent {
  final int newScore;
  const UpdateScoreA({
    required this.newScore,
  });
}

class UpdateScoreB extends GameEvent {
  final int newScore;
  const UpdateScoreB({
    required this.newScore,
  });
}

class ToggleFrostWeather extends GameEvent {}

class ToggleFogWeather extends GameEvent {}

class ToggleRainWeather extends GameEvent {}

class ScorchCards extends GameEvent {}

class RequestFocus extends GameEvent {
  final GameSideFocus sideFocus;
  const RequestFocus({
    required this.sideFocus,
  });
}
