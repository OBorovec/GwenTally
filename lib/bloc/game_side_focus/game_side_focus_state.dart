part of 'game_side_focus_bloc.dart';

enum GameSideFocus { A, B, none, both }

class GameSideFocusState extends Equatable {
  final GameSideFocus sideFocus;
  const GameSideFocusState({
    this.sideFocus = GameSideFocus.none,
  });

  @override
  List<Object> get props => [sideFocus];
}
