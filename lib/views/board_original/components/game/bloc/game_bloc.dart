import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/views/board_original/components/battle_side/bloc/battle_side_bloc.dart';
import 'package:gwentboard/views/board_original/components/pack/bloc/pack_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final BattleSideBloc battleSideBlocA;
  final BattleSideBloc battleSideBlocB;
  final PackBloc packBloc;

  late final StreamSubscription _battleSideBlocASub;
  late final StreamSubscription _battleSideBlocBSub;

  GameBloc({
    required this.battleSideBlocA,
    required this.battleSideBlocB,
    required this.packBloc,
  }) : super(const GameState()) {
    _battleSideBlocASub =
        battleSideBlocA.stream.listen(_onBattleSideBlocAChange);
    _battleSideBlocBSub =
        battleSideBlocB.stream.listen(_onBattleSideBlocBChange);
    on<RestartGame>(_onRestartGame);
    on<UpdateScoreA>(_updateScoreA);
    on<UpdateScoreB>(_updateScoreB);
    on<ToggleFrostWeather>(_toggleFrostWeather);
    on<ToggleFogWeather>(_toggleFogWeather);
    on<ToggleRainWeather>(_toggleRainWeather);
    on<ScorchCards>(_scorchCards);
    on<RequestFocus>(_requestFocus);
  }

  void _onBattleSideBlocAChange(BattleSideState battleState) {
    add(UpdateScoreA(newScore: battleState.score));
  }

  void _onBattleSideBlocBChange(BattleSideState battleState) {
    add(UpdateScoreB(newScore: battleState.score));
  }

  FutureOr<void> _onRestartGame(
    RestartGame event,
    Emitter<GameState> emit,
  ) {
    battleSideBlocA.add(const ResetBattleSide());
    battleSideBlocB.add(const ResetBattleSide());
    emit(const GameState());
  }

  FutureOr<void> _updateScoreA(
    UpdateScoreA event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(
      scoreA: event.newScore,
      highestCardScore: _getHighestCardScore(),
    ));
  }

  FutureOr<void> _updateScoreB(
    UpdateScoreB event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(
      scoreB: event.newScore,
      highestCardScore: _getHighestCardScore(),
    ));
  }

  FutureOr<void> _toggleFrostWeather(
    ToggleFrostWeather event,
    Emitter<GameState> emit,
  ) {
    final bool newValue = !state.isFrost;
    battleSideBlocA.add(SetFrontlineWeather(value: newValue));
    battleSideBlocB.add(SetFrontlineWeather(value: newValue));
    emit(state.copyWith(isFrost: newValue));
  }

  FutureOr<void> _toggleFogWeather(
    ToggleFogWeather event,
    Emitter<GameState> emit,
  ) {
    final bool newValue = !state.isFog;
    battleSideBlocA.add(SetBackLineWeather(value: newValue));
    battleSideBlocB.add(SetBackLineWeather(value: newValue));
    emit(state.copyWith(isFog: newValue));
  }

  FutureOr<void> _toggleRainWeather(
    ToggleRainWeather event,
    Emitter<GameState> emit,
  ) {
    final bool newValue = !state.isRain;
    battleSideBlocA.add(SetArtyLineWeather(value: newValue));
    battleSideBlocB.add(SetArtyLineWeather(value: newValue));
    emit(state.copyWith(isRain: newValue));
  }

  FutureOr<void> _scorchCards(
    ScorchCards event,
    Emitter<GameState> emit,
  ) {
    int highestValue = _getHighestCardScore();
    battleSideBlocA.add(DeleteCardsWithValue(value: highestValue));
    battleSideBlocB.add(DeleteCardsWithValue(value: highestValue));
  }

  FutureOr<void> _requestFocus(
    RequestFocus event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(
      sideFocus: event.sideFocus,
    ));
  }

  @override
  Future<void> close() {
    _battleSideBlocASub.cancel();
    _battleSideBlocBSub.cancel();
    return super.close();
  }

  // Help functions

  int _getHighestCardScore() {
    int highestValue = 0;
    battleSideBlocA.state.frontLineCards.forEach((card) {
      if (!card.data.attHero && card.activeValue> highestValue)
        highestValue = card.activeValue;
    });
    battleSideBlocA.state.backLineCards.forEach((card) {
      if (!card.data.attHero && card.activeValue> highestValue)
        highestValue = card.activeValue;
    });
    battleSideBlocA.state.artyLineCards.forEach((card) {
      if (!card.data.attHero && card.activeValue> highestValue)
        highestValue = card.activeValue;
    });
    battleSideBlocB.state.frontLineCards.forEach((card) {
      if (!card.data.attHero && card.activeValue> highestValue)
        highestValue = card.activeValue;
    });
    battleSideBlocB.state.backLineCards.forEach((card) {
      if (!card.data.attHero && card.activeValue> highestValue)
        highestValue = card.activeValue;
    });
    battleSideBlocB.state.artyLineCards.forEach((card) {
      if (!card.data.attHero && card.activeValue> highestValue)
        highestValue = card.activeValue;
    });
    return highestValue;
  }
}