part of 'battle_side_bloc.dart';

abstract class BattleSideEvent extends Equatable {
  const BattleSideEvent();

  @override
  List<Object> get props => [];
}

class ResetBattleSide extends BattleSideEvent {
  const ResetBattleSide();
}

class UpdateScore extends BattleSideEvent {
  const UpdateScore();
}

class AddFrontLineCard extends BattleSideEvent {
  final CardData data;

  const AddFrontLineCard({
    required this.data,
  });
}

class AddBackLineCard extends BattleSideEvent {
  final CardData data;

  const AddBackLineCard({
    required this.data,
  });
}

class AddArtyLineCard extends BattleSideEvent {
  final CardData data;

  const AddArtyLineCard({
    required this.data,
  });
}

class RemoveFrontLineCard extends BattleSideEvent {
  final PlayedCard card;

  const RemoveFrontLineCard({
    required this.card,
  });
}

class RemoveBackLineCard extends BattleSideEvent {
  final PlayedCard card;

  const RemoveBackLineCard({
    required this.card,
  });
}

class RemoveArtyLineCard extends BattleSideEvent {
  final PlayedCard card;

  const RemoveArtyLineCard({
    required this.card,
  });
}

class ToggleFrontlineWeather extends BattleSideEvent {
  const ToggleFrontlineWeather();
}

class ToggleBackLineWeather extends BattleSideEvent {
  const ToggleBackLineWeather();
}

class ToggleArtyLineWeather extends BattleSideEvent {
  const ToggleArtyLineWeather();
}

class SetFrontlineWeather extends BattleSideEvent {
  final bool value;
  const SetFrontlineWeather({
    required this.value,
  });
}

class SetBackLineWeather extends BattleSideEvent {
  final bool value;
  const SetBackLineWeather({
    required this.value,
  });
}

class SetArtyLineWeather extends BattleSideEvent {
  final bool value;
  const SetArtyLineWeather({
    required this.value,
  });
}

class ToggleFrontlineMorale extends BattleSideEvent {
  const ToggleFrontlineMorale();
}

class ToggleBackLineMorale extends BattleSideEvent {
  const ToggleBackLineMorale();
}

class ToggleArtyLineMorale extends BattleSideEvent {
  const ToggleArtyLineMorale();
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
