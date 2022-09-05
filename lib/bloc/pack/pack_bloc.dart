import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/model/card_data.dart';

part 'pack_event.dart';
part 'pack_state.dart';

class PackBloc extends Bloc<PackEvent, PackState> {
  PackBloc() : super(const PackState()) {
    on<TogglePackMorale>(_togglePackMorale);
    on<TogglePackGroup>(_togglePackGroup);
    on<TogglePackBrother>(_togglePackBrother);
    on<TogglePackSupport>(_togglePackSupport);
    on<TogglePackDoubleSupport>(_togglePackDoubleSupport);
  }

  FutureOr<void> _togglePackMorale(
    TogglePackMorale event,
    Emitter<PackState> emit,
  ) {
    emit(
      PackState(
        normalCards: defaultNormalCards
            .map((CardData data) => data.copyWith(attMoral: !state.moralCard))
            .toList(),
        moralCard: !state.moralCard,
      ),
    );
  }

  FutureOr<void> _togglePackGroup(
    TogglePackGroup event,
    Emitter<PackState> emit,
  ) {
    emit(
      PackState(
        normalCards: defaultNormalCards
            .map((CardData data) => data.copyWith(attGroup: !state.groupCard))
            .toList(),
        groupCard: !state.groupCard,
      ),
    );
  }

  FutureOr<void> _togglePackBrother(
    TogglePackBrother event,
    Emitter<PackState> emit,
  ) {
    emit(
      PackState(
        normalCards: defaultNormalCards
            .map((CardData data) =>
                data.copyWith(attBrothers: !state.brotherCard))
            .toList(),
        brotherCard: !state.brotherCard,
      ),
    );
  }

  FutureOr<void> _togglePackSupport(
    TogglePackSupport event,
    Emitter<PackState> emit,
  ) {
    emit(PackState(
      normalCards: defaultNormalCards
          .map((CardData data) => data.copyWith(attSupport: !state.supportCard))
          .toList(),
      supportCard: !state.supportCard,
    ));
  }

  FutureOr<void> _togglePackDoubleSupport(
    TogglePackDoubleSupport event,
    Emitter<PackState> emit,
  ) {
    emit(PackState(
      normalCards: defaultNormalCards
          .map((CardData data) =>
              data.copyWith(attDoubleSupport: !state.doubleSupportCard))
          .toList(),
      doubleSupportCard: !state.doubleSupportCard,
    ));
  }
}
