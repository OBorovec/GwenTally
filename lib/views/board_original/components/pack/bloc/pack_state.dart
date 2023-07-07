part of 'pack_bloc.dart';

const defaultNormalCards = <CardData>[
  CardData(baseValue: 0),
  CardData(baseValue: 1),
  CardData(baseValue: 2),
  CardData(baseValue: 3),
  CardData(baseValue: 4),
  CardData(baseValue: 5),
  CardData(baseValue: 6),
  CardData(baseValue: 7),
  CardData(baseValue: 8),
  CardData(baseValue: 9),
  CardData(baseValue: 10),
  CardData(baseValue: 12),
  CardData(baseValue: 14),
];

const defaultGoldCards = <CardData>[
  CardData(baseValue: 0, attHero: true),
  CardData(baseValue: 7, attHero: true),
  CardData(baseValue: 8, attHero: true),
  CardData(baseValue: 10, attHero: true),
  CardData(baseValue: 11, attHero: true),
  CardData(baseValue: 15, attHero: true),
];

class PackState extends Equatable {
  final List<CardData> normalCards;
  final List<CardData> goldCards;
  final bool attHorn;
  final bool attMuster;
  final bool attTightBond;
  final bool attMoral;
  final bool attDoubleMoral;
  const PackState({
    this.normalCards = defaultNormalCards,
    this.goldCards = defaultGoldCards,
    this.attHorn = false,
    this.attMuster = false,
    this.attTightBond = false,
    this.attMoral = false,
    this.attDoubleMoral = false,
  });

  @override
  List<Object> get props => [
        attHorn,
        attMuster,
        attTightBond,
        attMoral,
        attDoubleMoral,
      ];

  PackState copyWith({
    List<CardData>? normalCards,
    List<CardData>? goldCards,
    bool? attHorn,
    bool? attMuster,
    bool? attTightBond,
    bool? attMoral,
    bool? attDoubleMoral,
  }) {
    return PackState(
      normalCards: normalCards ?? this.normalCards,
      goldCards: goldCards ?? this.goldCards,
      attHorn: attHorn ?? this.attHorn,
      attMuster: attMuster ?? this.attMuster,
      attTightBond: attTightBond ?? this.attTightBond,
      attMoral: attMoral ?? this.attMoral,
      attDoubleMoral: attDoubleMoral ?? this.attDoubleMoral,
    );
  }
}
