import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/model/card_data.dart';

part 'battle_side_event.dart';
part 'battle_side_state.dart';

class BattleSideBloc extends Bloc<BattleSideEvent, BattleSideState> {
  BattleSideBloc() : super(const BattleSideState()) {
    on<EmptyBattleSide>(_onEmptyBattleSide);
    on<CalculateScore>(_calculateScore);
    on<AddFrontlineCard>(_addFrontlineCard);
    on<AddBacklineCard>(_addBacklineCard);
    on<AddArtylineCard>(_addArtylineCard);
    on<RemoveFrontlineCard>(_removeFrontlineCard);
    on<RemoveBacklineCard>(_removeBacklineCard);
    on<RemoveArtylineCard>(_removeArtylineCard);
    on<ToggleFrontlineWeather>(_toggleFrontlineWeather);
    on<ToggleBacklineWeather>(_toggleBacklineWeather);
    on<ToggleArtylineWeather>(_toggleArtylineWeather);
    on<SetFrontlineWeather>(_setFrontlineWeather);
    on<SetBacklineWeather>(_setBacklineWeather);
    on<SetArtylineWeather>(_tsetArtylineWeather);
    on<ToggleFrontlineMorale>(_toggleFrontlineMorale);
    on<ToggleBacklineMorale>(_toggleBacklineMorale);
    on<ToggleArtylineMorale>(_toggleArtylineMorale);
    on<DeleteCardsWithValue>(_deleteCardsWithValue);
  }

  FutureOr<void> _onEmptyBattleSide(
    EmptyBattleSide event,
    Emitter<BattleSideState> emit,
  ) {
    emit(const BattleSideState());
  }

  FutureOr<void> _calculateScore(
    _,
    Emitter<BattleSideState> emit,
  ) {
    List<CardData> frontline = state.frontlineCards
        .map(
          (CardData data) => data.copyWith(
            initTime: DateTime.now(),
            activeValue: _battleLineCardValue(
              data,
              state.frontlineCards
                  .where((CardData other) => data != other)
                  .toList(),
              state.frontlineWeather,
              state.frontlineMorale,
            ),
          ),
        )
        .toList();
    List<CardData> backline = state.backlineCards
        .map(
          (CardData data) => data.copyWith(
            initTime: DateTime.now(),
            activeValue: _battleLineCardValue(
              data,
              state.backlineCards
                  .where((CardData other) => data != other)
                  .toList(),
              state.backlineWeather,
              state.backlineMorale,
            ),
          ),
        )
        .toList();
    List<CardData> artyline = state.artylineCards
        .map(
          (CardData data) => data.copyWith(
            initTime: DateTime.now(),
            activeValue: _battleLineCardValue(
              data,
              state.artylineCards
                  .where((CardData other) => data != other)
                  .toList(),
              state.artylineWeather,
              state.artylineMorale,
            ),
          ),
        )
        .toList();
    int score = 0;
    frontline.forEach((CardData data) => score += data.activeValue!);
    backline.forEach((CardData data) => score += data.activeValue!);
    artyline.forEach((CardData data) => score += data.activeValue!);
    emit(state.copyWith(
      frontlineCards: frontline,
      backlineCards: backline,
      artylineCards: artyline,
      score: score,
    ));
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
      if (otherCard.attMoral) {
        value += 1;
      }
    }
    // Double support cards affect
    for (CardData otherCard in otherCards) {
      if (otherCard.attDoubleMoral) {
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
    AddFrontlineCard event,
    Emitter<BattleSideState> emit,
  ) {
    CardData newCard = event.data.copyWith(initTime: DateTime.now());
    List<CardData> frontlineCards = state.frontlineCards.toList();
    frontlineCards.add(newCard);
    emit(
      state.copyWith(
        frontlineCards: frontlineCards,
      ),
    );
    add(CalculateScore());
  }

  FutureOr<void> _addBacklineCard(
    AddBacklineCard event,
    Emitter<BattleSideState> emit,
  ) {
    CardData newCard = event.data.copyWith(initTime: DateTime.now());
    List<CardData> backlineCards = state.backlineCards.toList();
    backlineCards.add(newCard);
    emit(
      state.copyWith(
        backlineCards: backlineCards,
      ),
    );
    add(CalculateScore());
  }

  FutureOr<void> _addArtylineCard(
    AddArtylineCard event,
    Emitter<BattleSideState> emit,
  ) {
    CardData newCard = event.data.copyWith(initTime: DateTime.now());
    List<CardData> artylineCards = state.artylineCards.toList();
    artylineCards.add(newCard);
    emit(
      state.copyWith(
        artylineCards: artylineCards,
      ),
    );
    add(CalculateScore());
  }

  FutureOr<void> _removeFrontlineCard(
    RemoveFrontlineCard event,
    Emitter<BattleSideState> emit,
  ) {
    List<CardData> frontlineCards = state.frontlineCards.toList();
    frontlineCards.remove(event.data.copyWith());
    emit(
      state.copyWith(
        frontlineCards: frontlineCards,
      ),
    );
    add(CalculateScore());
  }

  FutureOr<void> _removeBacklineCard(
    RemoveBacklineCard event,
    Emitter<BattleSideState> emit,
  ) {
    List<CardData> backlineCards = state.backlineCards.toList();
    backlineCards.remove(event.data.copyWith());
    emit(
      state.copyWith(
        backlineCards: backlineCards,
      ),
    );
    add(CalculateScore());
  }

  FutureOr<void> _removeArtylineCard(
    RemoveArtylineCard event,
    Emitter<BattleSideState> emit,
  ) {
    List<CardData> artylineCards = state.artylineCards.toList();
    artylineCards.remove(event.data.copyWith());
    emit(
      state.copyWith(
        artylineCards: artylineCards,
      ),
    );
    add(CalculateScore());
  }

  FutureOr<void> _toggleFrontlineWeather(
    ToggleFrontlineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(frontlineWeather: !state.frontlineWeather));
    add(CalculateScore());
  }

  FutureOr<void> _toggleBacklineWeather(
    ToggleBacklineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(backlineWeather: !state.backlineWeather));
    add(CalculateScore());
  }

  FutureOr<void> _toggleArtylineWeather(
    ToggleArtylineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(artylineWeather: !state.artylineWeather));
    add(CalculateScore());
  }

  FutureOr<void> _setFrontlineWeather(
    SetFrontlineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(frontlineWeather: event.value));
    add(CalculateScore());
  }

  FutureOr<void> _setBacklineWeather(
    SetBacklineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(backlineWeather: event.value));
    add(CalculateScore());
  }

  FutureOr<void> _tsetArtylineWeather(
    SetArtylineWeather event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(artylineWeather: event.value));
    add(CalculateScore());
  }

  FutureOr<void> _toggleFrontlineMorale(
    ToggleFrontlineMorale event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(frontlineMorale: !state.frontlineMorale));
    add(CalculateScore());
  }

  FutureOr<void> _toggleBacklineMorale(
    ToggleBacklineMorale event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(backlineMorale: !state.backlineMorale));
    add(CalculateScore());
  }

  FutureOr<void> _toggleArtylineMorale(
    ToggleArtylineMorale event,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(artylineMorale: !state.artylineMorale));
    add(CalculateScore());
  }

  FutureOr<void> _deleteCardsWithValue(
    DeleteCardsWithValue event,
    Emitter<BattleSideState> emit,
  ) {
    List<CardData> frontlineCards = state.frontlineCards
        .where((CardData cd) => cd.attHero || cd.activeValue! != event.value)
        .toList();
    List<CardData> backlineCards = state.backlineCards
        .where((CardData cd) => cd.attHero || cd.activeValue! != event.value)
        .toList();
    List<CardData> artylineCards = state.artylineCards
        .where((CardData cd) => cd.attHero || cd.activeValue! != event.value)
        .toList();
    emit(
      state.copyWith(
        frontlineCards: frontlineCards,
        backlineCards: backlineCards,
        artylineCards: artylineCards,
      ),
    );
    add(CalculateScore());
  }
}
