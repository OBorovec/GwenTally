import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_side_focus_event.dart';
part 'game_side_focus_state.dart';

class GameSideFocusBloc extends Bloc<GameSideFocusEvent, GameSideFocusState> {
  GameSideFocusBloc() : super(const GameSideFocusState()) {
    on<GameSideFocusEventInit>(_onGameSideFocusEventInit);
    on<GameSideFocusEventA>(_onGameSideFocusEventA);
    on<GameSideFocusEventB>(_onGameSideFocusEventB);
    on<GameSideFocusEventNone>(_onGameSideFocusEventNone);
    on<GameSideFocusEventBoth>(_onGameSideFocusEventBoth);
  }

  FutureOr<void> _onGameSideFocusEventInit(
    GameSideFocusEventInit event,
    Emitter<GameSideFocusState> emit,
  ) {
    emit(GameSideFocusState(sideFocus: event.sideFocus));
  }

  FutureOr<void> _onGameSideFocusEventA(
    GameSideFocusEventA event,
    Emitter<GameSideFocusState> emit,
  ) {
    emit(const GameSideFocusState(sideFocus: GameSideFocus.A));
  }

  FutureOr<void> _onGameSideFocusEventB(
    GameSideFocusEventB event,
    Emitter<GameSideFocusState> emit,
  ) {
    emit(const GameSideFocusState(sideFocus: GameSideFocus.B));
  }

  FutureOr<void> _onGameSideFocusEventNone(
    GameSideFocusEventNone event,
    Emitter<GameSideFocusState> emit,
  ) {
    emit(const GameSideFocusState(sideFocus: GameSideFocus.none));
  }

  FutureOr<void> _onGameSideFocusEventBoth(
    GameSideFocusEventBoth event,
    Emitter<GameSideFocusState> emit,
  ) {
    emit(const GameSideFocusState(sideFocus: GameSideFocus.both));
  }
}
