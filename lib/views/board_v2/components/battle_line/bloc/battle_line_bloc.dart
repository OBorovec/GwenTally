import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/model/card_played.dart';

part 'battle_line_event.dart';
part 'battle_line_state.dart';

class BattleLineBloc extends Bloc<BattleLineEvent, BattleLineState> {
  BattleLineBloc() : super(const BattleLineState()) {
    on<ResetBattleLine>(_onResetBattleLine);
    on<UpdateScore>(_onUpdateScore);
    on<AddCard>(_addCard);
    on<RemoveCard>(_removeCard);
    on<ToggleWeather>(_toggleWeather);
    on<ToggleHorn>(_toggleHorn);
    on<UpdateLastPlayerAction>(_updateLastPlayerAction);
  }

  FutureOr<void> _onResetBattleLine(
    ResetBattleLine event,
    Emitter<BattleLineState> emit,
  ) {
    emit(const BattleLineState());
  }

  FutureOr<void> _onUpdateScore(
    UpdateScore event,
    Emitter<BattleLineState> emit,
  ) {
    List<PlayedCard> cards = state.cards
        .map(
          (PlayedCard card) => card.copyWith(
            initTime: DateTime.now(),
            activeValue: _getActiveCardValue(
              card: card.data,
              otherCards: state.cards
                  .where(
                    (PlayedCard otherCard) =>
                        card.initTime != otherCard.initTime,
                  )
                  .map(
                    (PlayedCard otherCard) => otherCard.data,
                  )
                  .toList(),
              activeWeather: state.weather,
              activeCmdHorn: state.horn,
            ),
          ),
        )
        .toList();

    double score = 0;
    // Weather calculated for whole line only once
    cards.forEach((PlayedCard card) {
      if (card.data.attHero || card.data.attWeatherResistance) {
        score += card.activeValue;
      } else {
        score += card.activeValue / (state.weather ? 2 : 1);
      }
    });
    emit(state.copyWith(
      cards: cards,
      score: score.ceil(),
    ));
  }

  FutureOr<void> _addCard(
    AddCard event,
    Emitter<BattleLineState> emit,
  ) {
    emit(state.copyWith(
      cards: [
        ...state.cards,
        PlayedCard(
          initTime: DateTime.now(),
          activeValue: event.cardData.baseValue,
          data: event.cardData,
        ),
      ],
    ));
    add(const UpdateScore());
  }

  FutureOr<void> _removeCard(
    RemoveCard event,
    Emitter<BattleLineState> emit,
  ) {
    emit(state.copyWith(
      cards: state.cards
          .where((PlayedCard card) => card.initTime != event.card.initTime)
          .toList(),
    ));
    add(const UpdateScore());
  }

  FutureOr<void> _toggleWeather(
    ToggleWeather event,
    Emitter<BattleLineState> emit,
  ) {
    emit(state.copyWith(
      weather: !state.weather,
    ));
    add(const UpdateScore());
  }

  FutureOr<void> _toggleHorn(
    ToggleHorn event,
    Emitter<BattleLineState> emit,
  ) {
    emit(state.copyWith(
      horn: !state.horn,
    ));
    add(const UpdateScore());
  }

  FutureOr<void> _updateLastPlayerAction(
    UpdateLastPlayerAction event,
    Emitter<BattleLineState> emit,
  ) {
    emit(state.copyWith(
      lastPlayerAction: DateTime.now(),
    ));
  }

  // Support
  int _getActiveCardValue({
    required CardData card,
    required List<CardData> otherCards,
    required bool activeWeather,
    required bool activeCmdHorn,
  }) {
    double value = card.baseValue.toDouble();
    // Hero card value cannot be modified
    if (card.attHero) {
      return value.toInt();
    }
    // Tight bonds affect
    if (card.attTightBond) {
      int brothers = 1;
      for (CardData otherCard in otherCards) {
        if (otherCard.attTightBond && card.baseValue == otherCard.baseValue) {
          brothers += 1;
        }
      }
      value *= brothers;
    }
    // Evaluate morale cards
    for (CardData otherCard in otherCards) {
      if (otherCard.attMorale) {
        value += 1;
      }
    }
    if (card.attMorale) {
      value += 1; // Add morale value of the card itself
    }
    // Evaluate demorale cards
    for (CardData otherCard in otherCards) {
      if (otherCard.attDemorale) {
        value -= 1;
      }
    }
    if (card.attDemorale) {
      value -= 1; // Add demorale value of the card itself
    }
    // Weather affect - atm calculated for whole line
    // if (activeWeather) {
    //   value = value / 2;
    // }
    // Commander horn affect
    // CHeck if any card in otherCards has attCommanderHorn
    bool existsCmdHornCard =
        otherCards.any((otherCard) => otherCard.attCommanderHorn);
    if (card.attCommanderHorn || existsCmdHornCard || activeCmdHorn) {
      value *= 2;
    }
    return value.toInt();
  }
}
