part of 'game_side_focus_bloc.dart';

abstract class GameSideFocusEvent extends Equatable {
  const GameSideFocusEvent();

  @override
  List<Object> get props => [];
}

class GameSideFocusEventInit extends GameSideFocusEvent {
  final GameSideFocus sideFocus;
  const GameSideFocusEventInit({
    required this.sideFocus,
  });
}

class GameSideFocusEventA extends GameSideFocusEvent {
  const GameSideFocusEventA();
}

class GameSideFocusEventB extends GameSideFocusEvent {
  const GameSideFocusEventB();
}

class GameSideFocusEventNone extends GameSideFocusEvent {
  const GameSideFocusEventNone();
}

class GameSideFocusEventBoth extends GameSideFocusEvent {
  const GameSideFocusEventBoth();
}
