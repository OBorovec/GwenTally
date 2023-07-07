import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/model/card_data.dart';

part 'pack_event.dart';
part 'pack_options.dart';
part 'pack_state.dart';

class PackBloc extends Bloc<PackEvent, PackState> {
  final int maxRecentCards;

  PackBloc({
    this.maxRecentCards = 3,
  }) : super(const PackState()) {
    on<PackEventOpen>(_openPack);
    on<PackEventClose>(_closePack);
    on<PackEventSetNum>(_setPackNum);
    on<PackEventSetAtt>(_setPackAtt);
    on<PackEventCardPlaced>(_cardPlaced);
    on<PackEventUpdateOverview>(_updateOverview);
  }

  FutureOr<void> _openPack(
    PackEventOpen event,
    Emitter<PackState> emit,
  ) {
    emit(state.copyWith(
      stage: PackStage.num,
    ));
  }

  FutureOr<void> _closePack(
    PackEventClose event,
    Emitter<PackState> emit,
  ) {
    if (state.stage == PackStage.num && state.topCard != null) {
      emit(state.copyWith(
        stage: PackStage.closed,
        topCard: CardData(baseValue: state.topCard!.baseValue),
      ));
    }
    emit(state.copyWith(
      stage: PackStage.closed,
    ));
  }

  FutureOr<void> _setPackNum(
    PackEventSetNum event,
    Emitter<PackState> emit,
  ) {
    emit(state.copyWith(
      isEmpty: false,
      stage: PackStage.att,
      topCard: CardData(
        baseValue: event.value,
      ),
    ));
  }

  FutureOr<void> _setPackAtt(
    PackEventSetAtt event,
    Emitter<PackState> emit,
  ) {
    late final CardData newCardData;
    switch (event.value) {
      case PackCardAtt.horn:
        newCardData = state.topCard!.copyWith(
          attCommanderHorn: true,
        );
        break;
      case PackCardAtt.bond:
        newCardData = state.topCard!.copyWith(
          attTightBond: true,
        );
        break;
      case PackCardAtt.morale:
        newCardData = state.topCard!.copyWith(
          attMorale: true,
        );
        break;
      case PackCardAtt.demorale:
        newCardData = state.topCard!.copyWith(
          attDemorale: true,
        );
        break;
      case PackCardAtt.hero:
        newCardData = state.topCard!.copyWith(
          attHero: true,
        );
        break;
    }
    emit(state.copyWith(
      isEmpty: false,
      // Hero cards can have additional attributesPackStage.closed,
      stage: event.value == PackCardAtt.hero ? PackStage.att : PackStage.closed,
      topCard: newCardData,
    ));
  }

  FutureOr<void> _cardPlaced(
    PackEventCardPlaced event,
    Emitter<PackState> emit,
  ) {
    final List<CardData> usedCards = [
      event.card,
      ...state.usedCards,
    ];

    emit(state.copyWith(
      usedCards: usedCards,
    ));
    add(PackEventUpdateOverview(
      topCard: event.card,
    ));
  }

  FutureOr<void> _updateOverview(
    PackEventUpdateOverview event,
    Emitter<PackState> emit,
  ) {
    List<CardData> recentCards = [];
    for (final card in state.usedCards) {
      if (recentCards.length == maxRecentCards) break;
      if (!recentCards.contains(card) && card != event.topCard) {
        recentCards.add(card);
      }
    }
    emit(state.copyWith(
      recentCards: recentCards,
      topCard: event.topCard,
    ));
  }
}
