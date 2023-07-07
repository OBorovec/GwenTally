import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/views/board_v2/components/battle_side/bloc/battle_side_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final BattleSideBloc battleSideBlocA;
  final BattleSideBloc battleSideBlocB;

  late final StreamSubscription _battleSideBlocASubscription;
  late final StreamSubscription _battleSideBlocBSubscription;

  GameBloc({
    required this.battleSideBlocA,
    required this.battleSideBlocB,
  }) : super(const GameState()) {
    _battleSideBlocASubscription = battleSideBlocA.stream.listen((state) {
      add(GameEventUpdateScoreA(newScore: state.score));
    });
    _battleSideBlocBSubscription = battleSideBlocB.stream.listen((state) {
      add(GameEventUpdateScoreB(newScore: state.score));
    });
    on<GameEventRestart>(_onGameEventRestart);
    on<GameEventUpdateScoreA>(_onGameEventUpdateScoreA);
    on<GameEventUpdateScoreB>(_onGameEventUpdateScoreB);
  }

  @override
  Future<void> close() {
    _battleSideBlocASubscription.cancel();
    _battleSideBlocBSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onGameEventRestart(
    GameEventRestart event,
    Emitter<GameState> emit,
  ) {}

  FutureOr<void> _onGameEventUpdateScoreA(
    GameEventUpdateScoreA event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(
      scoreA: event.newScore,
    ));
  }

  FutureOr<void> _onGameEventUpdateScoreB(
    GameEventUpdateScoreB event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(
      scoreB: event.newScore,
    ));
  }
}
