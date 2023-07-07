import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/model/card_played.dart';

part 'battle_side_event.dart';
part 'battle_side_state.dart';

class BattleSideBloc extends Bloc<BattleSideEvent, BattleSideState> {
  BattleSideBloc() : super(const BattleSideState()) {
    on<ResetBattleSide>(_onResetBattleSide);
    on<UpdateScore>(_onUpdateScore);
    on<AddFrontLineCard>(_addFrontlineCard);
    on<AddBackLineCard>(_addBacklineCard);
    on<AddArtyLineCard>(_addArtylineCard);
    on<RemoveFrontLineCard>(_removeFrontlineCard);
    on<RemoveBackLineCard>(_removeBacklineCard);
    on<RemoveArtyLineCard>(_removeArtylineCard);
    on<ToggleFrontlineWeather>(_toggleFrontlineWeather);
    on<ToggleBackLineWeather>(_toggleBacklineWeather);
    on<ToggleArtyLineWeather>(_toggleArtylineWeather);
    on<SetFrontlineWeather>(_setFrontlineWeather);
    on<SetBackLineWeather>(_setBacklineWeather);
    on<SetArtyLineWeather>(_setArtylineWeather);
    on<ToggleFrontlineMorale>(_toggleFrontlineMorale);
    on<ToggleBackLineMorale>(_toggleBacklineMorale);
    on<ToggleArtyLineMorale>(_toggleArtylineMorale);
    on<DeleteCardsWithValue>(_deleteCardsWithValue);
    on<ToggleCommanderCard>(_toggleCommanderCard);
  }

  FutureOr<void> _onResetBattleSide(
    _,
    Emitter<BattleSideState> emit,
  ) {
    emit(const BattleSideState());
  }

  FutureOr<void> _onUpdateScore(
    _,
    Emitter<BattleSideState> emit,
  ) {
    List<PlayedCard> frontline = _updateLine(
      line: state.frontLineCards,
      weather: state.frontLineWeather,
      cmdHorn: state.frontLineMorale,
    );
    List<PlayedCard> backline = _updateLine(
      line: state.backLineCards,
      weather: state.backLineWeather,
      cmdHorn: state.backLineMorale,
    );
    List<PlayedCard> artyline = _updateLine(
      line: state.artyLineCards,
      weather: state.artyLineWeather,
      cmdHorn: state.artyLineMorale,
    );
    int score = 0;
    frontline.forEach((PlayedCard card) => score += card.activeValue);
    backline.forEach((PlayedCard card) => score += card.activeValue);
    artyline.forEach((PlayedCard card) => score += card.activeValue);
    emit(state.copyWith(
      frontlineCards: frontline,
      backlineCards: backline,
      artylineCards: artyline,
      score: score,
    ));
  }

  List<PlayedCard> _updateLine({
    required List<PlayedCard> line,
    required bool weather,
    required bool cmdHorn,
  }) {
    return line
        .map(
          (PlayedCard card) => card.copyWith(
            initTime: DateTime.now(),
            activeValue: _battleLineCardValue(
              card.data,
              line
                  .where((PlayedCard other) => card != other)
                  .map((PlayedCard otherCard) => otherCard.data)
                  .toList(),
              weather,
              cmdHorn,
            ),
          ),
        )
        .toList();
  }

  int _battleLineCardValue(
    CardData card,
    List<CardData> otherCards,
    bool activeWeather,
    bool activeMorale,
  ) {
    int value = card.baseValue;
    if (card.attHero) {
      return value;
    }
    // Weather affect
    if (activeWeather) {
      value = min(card.baseValue, 1);
    }
    // Brother cards affect
    if (card.attTightBond) {
      int brothers = 1;
      for (CardData otherCard in otherCards) {
        if (otherCard.attTightBond && card.baseValue == otherCard.baseValue) {
          brothers += 1;
        }
      }
      value *= brothers;
    }
    // Support cards affect
    for (CardData otherCard in otherCards) {
      if (otherCard.attMorale) {
        value += 1;
      }
    }
    // Double support cards affect
    for (CardData otherCard in otherCards) {
      if (otherCard.attDoubleMorale) {
        value += 2;
      }
    }
    // Moral cards affect
    // Moral can be applied only once
    bool applyMoral = false;
    if (activeMorale) {
      applyMoral = true;
    }
    for (CardData otherCard in otherCards) {
      if (otherCard.attCommanderHorn) {
        applyMoral = true;
      }
    }
    if (applyMoral) {
      value *= 2;
    }

    return value;
  }

  FutureOr<void> _addFrontlineCard(
    AddFrontLineCard event,
    Emitter<BattleSideState> emit,
  ) {
    PlayedCard newCard = PlayedCard(
      initTime: DateTime.now(),
      data: event.data,
      activeValue: event.data.baseValue,
    );
    emit(
      state.copyWith(
        frontlineCards: [
          ...state.frontLineCards,
          newCard,
        ],
      ),
    );
    add(const UpdateScore());
  }

  FutureOr<void> _addBacklineCard(
    AddBackLineCard event,
    Emitter<BattleSideState> emit,
  ) {
    PlayedCard newCard = PlayedCard(
      initTime: DateTime.now(),
      data: event.data,
      activeValue: event.data.baseValue,
    );
    emit(
      state.copyWith(backlineCards: [
        ...state.backLineCards,
        newCard,
      ]),
    );
    add(const UpdateScore());
  }

  FutureOr<void> _addArtylineCard(
    AddArtyLineCard event,
    Emitter<BattleSideState> emit,
  ) {
    PlayedCard newCard = PlayedCard(
      initTime: DateTime.now(),
      data: event.data,
      activeValue: event.data.baseValue,
    );
    emit(
      state.copyWith(
        artylineCards: [
          ...state.artyLineCards,
          newCard,
        ],
      ),
    );
    add(const UpdateScore());
  }

  FutureOr<void> _removeFrontlineCard(
    RemoveFrontLineCard event,
    Emitter<BattleSideState> emit,
  ) {
    List<PlayedCard> frontlineCards = state.frontLineCards.toList();
    frontlineCards.remove(event.card);
    emit(
      state.copyWith(
        frontlineCards: frontlineCards,
      ),
    );
    add(const UpdateScore());
  }

  FutureOr<void> _removeBacklineCard(
    RemoveBackLineCard event,
    Emitter<BattleSideState> emit,
  ) {
    List<PlayedCard> backlineCards = state.backLineCards.toList();
    backlineCards.remove(event.card.copyWith());
    emit(
      state.copyWith(
        backlineCards: backlineCards,
      ),
    );
    add(const UpdateScore());
  }

  FutureOr<void> _removeArtylineCard(
    RemoveArtyLineCard event,
    Emitter<BattleSideState> emit,
  ) {
    List<PlayedCard> artylineCards = state.artyLineCards.toList();
    artylineCards.remove(event.card.copyWith());
    emit(
      state.copyWith(
        artylineCards: artylineCards,
      ),
    );
    add(const UpdateScore());
  }

  FutureOr<void> _toggleFrontlineWeather(
    ToggleFrontlineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(frontlineWeather: !state.frontLineWeather));
    add(const UpdateScore());
  }

  FutureOr<void> _toggleBacklineWeather(
    ToggleBackLineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(backlineWeather: !state.backLineWeather));
    add(const UpdateScore());
  }

  FutureOr<void> _toggleArtylineWeather(
    ToggleArtyLineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(artylineWeather: !state.artyLineWeather));
    add(const UpdateScore());
  }

  FutureOr<void> _setFrontlineWeather(
    SetFrontlineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(frontlineWeather: event.value));
    add(const UpdateScore());
  }

  FutureOr<void> _setBacklineWeather(
    SetBackLineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(backlineWeather: event.value));
    add(const UpdateScore());
  }

  FutureOr<void> _setArtylineWeather(
    SetArtyLineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(artylineWeather: event.value));
    add(const UpdateScore());
  }

  FutureOr<void> _toggleFrontlineMorale(
    ToggleFrontlineMorale event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(frontlineMorale: !state.frontLineMorale));
    add(const UpdateScore());
  }

  FutureOr<void> _toggleBacklineMorale(
    ToggleBackLineMorale event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(backlineMorale: !state.backLineMorale));
    add(const UpdateScore());
  }

  FutureOr<void> _toggleArtylineMorale(
    ToggleArtyLineMorale event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(artylineMorale: !state.artyLineMorale));
    add(const UpdateScore());
  }

  FutureOr<void> _deleteCardsWithValue(
    DeleteCardsWithValue event,
    Emitter<BattleSideState> emit,
  ) {
    List<PlayedCard> frontlineCards = state.frontLineCards
        .where((PlayedCard card) =>
            card.data.attHero || card.activeValue != event.value)
        .toList();
    List<PlayedCard> backlineCards = state.backLineCards
        .where((PlayedCard card) =>
            card.data.attHero || card.activeValue != event.value)
        .toList();
    List<PlayedCard> artylineCards = state.artyLineCards
        .where((PlayedCard card) =>
            card.data.attHero || card.activeValue != event.value)
        .toList();
    emit(
      state.copyWith(
        frontlineCards: frontlineCards,
        backlineCards: backlineCards,
        artylineCards: artylineCards,
      ),
    );
    add(const UpdateScore());
  }

  FutureOr<void> _toggleCommanderCard(
    ToggleCommanderCard event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(
      commanderPlayed: !state.commanderPlayed,
    ));
  }
}
