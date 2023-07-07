part of 'pack_bloc.dart';

abstract class PackEvent extends Equatable {
  const PackEvent();

  @override
  List<Object> get props => [];
}

class PackEventOpen extends PackEvent {
  const PackEventOpen();
}

class PackEventClose extends PackEvent {
  const PackEventClose();
}

class PackEventSetNum extends PackEvent {
  final int value;

  const PackEventSetNum({
    required this.value,
  });

  @override
  List<Object> get props => [value];
}

class PackEventSetAtt extends PackEvent {
  final PackCardAtt value;

  const PackEventSetAtt({
    required this.value,
  });

  @override
  List<Object> get props => [value];
}

class PackEventCardPlaced extends PackEvent {
  final CardData card;

  const PackEventCardPlaced({
    required this.card,
  });

  @override
  List<Object> get props => [card];
}

class PackEventUpdateOverview extends PackEvent {
  final CardData topCard;
  const PackEventUpdateOverview({
    required this.topCard,
  });

  @override
  List<Object> get props => [topCard];
}
