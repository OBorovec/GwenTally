import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/views/board_v2/components/battle_line/bloc/battle_line_bloc.dart';

part 'battle_side_event.dart';
part 'battle_side_state.dart';

class BattleSideBloc extends Bloc<BattleSideEvent, BattleSideState> {
  final BattleLineBloc frontLineBloc;
  final BattleLineBloc backLineBloc;
  final BattleLineBloc siegeLineBloc;

  late final StreamSubscription _frontLineSubscription;
  late final StreamSubscription _backLineSubscription;
  late final StreamSubscription _siegeLineSubscription;

  BattleSideBloc({
    required this.frontLineBloc,
    required this.backLineBloc,
    required this.siegeLineBloc,
  }) : super(const BattleSideState()) {
    _frontLineSubscription = frontLineBloc.stream.listen((_) {
      add(const UpdateScore());
    });
    _backLineSubscription = backLineBloc.stream.listen((_) {
      add(const UpdateScore());
    });
    _siegeLineSubscription = siegeLineBloc.stream.listen((_) {
      add(const UpdateScore());
    });
    // General
    on<ResetBattleSide>(_onResetBattleSide);
    on<UpdateScore>(_onUpdateScore);
    // Other
    on<ToggleCommanderCard>(_toggleCommanderCard);
  }

  @override
  Future<void> close() {
    _frontLineSubscription.cancel();
    _backLineSubscription.cancel();
    _siegeLineSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onResetBattleSide(
    _,
    Emitter<BattleSideState> emit,
  ) {
    frontLineBloc.add(const ResetBattleLine());
    backLineBloc.add(const ResetBattleLine());
    siegeLineBloc.add(const ResetBattleLine());
    emit(const BattleSideState());
  }

  FutureOr<void> _onUpdateScore(
    _,
    Emitter<BattleSideState> emit,
  ) {
    emit(state.copyWith(
      score: frontLineBloc.state.score +
          backLineBloc.state.score +
          siegeLineBloc.state.score,
    ));
  }

  FutureOr<void> _toggleCommanderCard(
    ToggleCommanderCard event,
    Emitter<BattleSideState> emit,
  ) {}
}
