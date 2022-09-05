part of 'battle_side_bloc.dart';

abstract class BattleSideEvent extends Equatable {
  const BattleSideEvent();

  @override
  List<Object> get props => [];
}

class EmptyBattleSide extends BattleSideEvent {}

class CalculateScore extends BattleSideEvent {}

class AddFrontlineCard extends BattleSideEvent {
  final CardData data;

  const AddFrontlineCard({
    required this.data,
  });
}

class AddBacklineCard extends BattleSideEvent {
  final CardData data;

  const AddBacklineCard({
    required this.data,
  });
}

class AddArtylineCard extends BattleSideEvent {
  final CardData data;

  const AddArtylineCard({
    required this.data,
  });
}

class RemoveFrontlineCard extends BattleSideEvent {
  final CardData data;

  const RemoveFrontlineCard({
    required this.data,
  });
}

class RemoveBacklineCard extends BattleSideEvent {
  final CardData data;

  const RemoveBacklineCard({
    required this.data,
  });
}

class RemoveArtylineCard extends BattleSideEvent {
  final CardData data;

  const RemoveArtylineCard({
    required this.data,
  });
}

class ToggleFrontlineWeather extends BattleSideEvent {}

class ToggleBacklineWeather extends BattleSideEvent {}

class ToggleArtylineWeather extends BattleSideEvent {}

class SetFrontlineWeather extends BattleSideEvent {
  final bool value;
  const SetFrontlineWeather({
    required this.value,
  });
}

class SetBacklineWeather extends BattleSideEvent {
  final bool value;
  const SetBacklineWeather({
    required this.value,
  });
}

class SetArtylineWeather extends BattleSideEvent {
  final bool value;
  const SetArtylineWeather({
    required this.value,
  });
}

class ToggleFrontlineMorale extends BattleSideEvent {}

class ToggleBacklineMorale extends BattleSideEvent {}

class ToggleArtylineMorale extends BattleSideEvent {}

class DeleteCardsWithValue extends BattleSideEvent {
  final int value;
  const DeleteCardsWithValue({
    required this.value,
  });
}
