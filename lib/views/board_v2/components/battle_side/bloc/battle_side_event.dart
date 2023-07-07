part of 'battle_side_bloc.dart';

abstract class BattleSideEvent extends Equatable {
  const BattleSideEvent();

  @override
  List<Object> get props => [];
}

class ResetBattleSide extends BattleSideEvent {
  const ResetBattleSide();
}

class BattleSideEventFrontScore extends BattleSideEvent {
  const BattleSideEventFrontScore();
}

class BattleSideEventBackScore extends BattleSideEvent {
  const BattleSideEventBackScore();
}

class BattleSideEventSiegeScore extends BattleSideEvent {
  const BattleSideEventSiegeScore();
}

class UpdateScore extends BattleSideEvent {
  const UpdateScore();
}

class ToggleCommanderCard extends BattleSideEvent {
  const ToggleCommanderCard();
}
