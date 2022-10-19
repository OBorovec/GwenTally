part of 'battle_side_bloc.dart';

abstract class BattleSideEvent extends Equatable {
  const BattleSideEvent();

  @override
  List<Object> get props => [];
}

class EmptyBattleSide extends BattleSideEvent {
  const EmptyBattleSide();
}

class CalculateScore extends BattleSideEvent {
  const CalculateScore();
}

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

class ToggleFrontlineWeather extends BattleSideEvent {
  const ToggleFrontlineWeather();
}

class ToggleBacklineWeather extends BattleSideEvent {
  const ToggleBacklineWeather();
}

class ToggleArtylineWeather extends BattleSideEvent {
  const ToggleArtylineWeather();
}

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

class ToggleFrontlineMorale extends BattleSideEvent {
  const ToggleFrontlineMorale();
}

class ToggleBacklineMorale extends BattleSideEvent {
  const ToggleBacklineMorale();
}

class ToggleArtylineMorale extends BattleSideEvent {
  const ToggleArtylineMorale();
}

class DeleteCardsWithValue extends BattleSideEvent {
  final int value;
  const DeleteCardsWithValue({
    required this.value,
  });
}

class ToggleCommanderCard extends BattleSideEvent {
  const ToggleCommanderCard();
}
