part of 'battle_line_bloc.dart';

abstract class BattleLineEvent extends Equatable {
  const BattleLineEvent();

  @override
  List<Object> get props => [];
}

class ResetBattleLine extends BattleLineEvent {
  const ResetBattleLine();
}

class UpdateScore extends BattleLineEvent {
  const UpdateScore();
}

class AddCard extends BattleLineEvent {
  final CardData cardData;

  const AddCard({
    required this.cardData,
  });
}

class RemoveCard extends BattleLineEvent {
  final PlayedCard card;

  const RemoveCard({
    required this.card,
  });
}

class ToggleWeather extends BattleLineEvent {
  const ToggleWeather();
}

class ToggleHorn extends BattleLineEvent {
  const ToggleHorn();
}

class UpdateLastPlayerAction extends BattleLineEvent {
  const UpdateLastPlayerAction();
}
