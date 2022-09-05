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
  CardData(baseValue: 11),
];

const defaultGoldCards = <CardData>[
  CardData(baseValue: 0, attHero: true),
  CardData(baseValue: 7, attHero: true),
  CardData(baseValue: 8, attHero: true),
  CardData(baseValue: 10, attHero: true),
  CardData(baseValue: 15, attHero: true),
];

class PackState extends Equatable {
  final List<CardData> normalCards;
  final List<CardData> goldCards;
  final bool moralCard;
  final bool groupCard;
  final bool brotherCard;
  final bool supportCard;
  final bool doubleSupportCard;
  const PackState({
    this.normalCards = defaultNormalCards,
    this.goldCards = defaultGoldCards,
    this.moralCard = false,
    this.groupCard = false,
    this.brotherCard = false,
    this.supportCard = false,
    this.doubleSupportCard = false,
  });

  @override
  List<Object> get props => [
        moralCard,
        groupCard,
        brotherCard,
        supportCard,
        doubleSupportCard,
      ];

  PackState copyWith({
    List<CardData>? normalCards,
    List<CardData>? goldCards,
    bool? moralCard,
    bool? groupCard,
    bool? brotherCard,
    bool? supportCard,
    bool? doubleSupportCard,
  }) {
    return PackState(
      normalCards: normalCards ?? this.normalCards,
      goldCards: goldCards ?? this.goldCards,
      moralCard: moralCard ?? this.moralCard,
      groupCard: groupCard ?? this.groupCard,
      brotherCard: brotherCard ?? this.brotherCard,
      supportCard: supportCard ?? this.supportCard,
      doubleSupportCard: doubleSupportCard ?? this.doubleSupportCard,
    );
  }
}
