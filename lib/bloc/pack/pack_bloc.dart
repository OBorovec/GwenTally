import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/model/card_data.dart';

part 'pack_event.dart';
part 'pack_state.dart';

class PackBloc extends Bloc<PackEvent, PackState> {
  PackBloc() : super(const PackState()) {
    on<TogglePackHorn>(_togglePackHorn);
    on<TogglePackMuster>(_togglePackMuster);
    on<TogglePackTightBond>(_togglePackTightBond);
    on<TogglePackMoral>(_togglePackMoral);
    on<TogglePackDoubleMoral>(_togglePackDoubleMoral);
  }

  FutureOr<void> _togglePackHorn(
    TogglePackHorn event,
    Emitter<PackState> emit,
  ) {
    emit(
      PackState(
        normalCards: defaultNormalCards
            .map((CardData data) =>
                data.copyWith(attCommanderHorn: !state.attHorn))
            .toList(),
        attHorn: !state.attHorn,
      ),
    );
  }

  FutureOr<void> _togglePackMuster(
    TogglePackMuster event,
    Emitter<PackState> emit,
  ) {
    emit(
      PackState(
        normalCards: defaultNormalCards
            .map((CardData data) => data.copyWith(attMuster: !state.attMuster))
            .toList(),
        attMuster: !state.attMuster,
      ),
    );
  }

  FutureOr<void> _togglePackTightBond(
    TogglePackTightBond event,
    Emitter<PackState> emit,
  ) {
    emit(
      PackState(
        normalCards: defaultNormalCards
            .map((CardData data) =>
                data.copyWith(attTightBond: !state.attTightBond))
            .toList(),
        attTightBond: !state.attTightBond,
      ),
    );
  }

  FutureOr<void> _togglePackMoral(
    TogglePackMoral event,
    Emitter<PackState> emit,
  ) {
    emit(PackState(
      normalCards: defaultNormalCards
          .map((CardData data) => data.copyWith(attMoral: !state.attMoral))
          .toList(),
      attMoral: !state.attMoral,
    ));
  }

  FutureOr<void> _togglePackDoubleMoral(
    TogglePackDoubleMoral event,
    Emitter<PackState> emit,
  ) {
    emit(PackState(
      normalCards: defaultNormalCards
          .map((CardData data) =>
              data.copyWith(attDoubleMoral: !state.attDoubleMoral))
          .toList(),
      attDoubleMoral: !state.attDoubleMoral,
    ));
  }
}
