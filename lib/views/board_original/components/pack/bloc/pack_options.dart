part of 'pack_bloc.dart';

const baseCards = <CardData>[
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
  // CardData(baseValue: 12),
  // CardData(baseValue: 14),
];

const heroCards = <CardData>[
  CardData(baseValue: 0, attHero: true),
  CardData(baseValue: 7, attHero: true),
  CardData(baseValue: 8, attHero: true),
  CardData(baseValue: 8, attHero: true, attMorale: true),
  CardData(baseValue: 10, attHero: true),
  CardData(baseValue: 10, attHero: true, attMorale: true),
  CardData(baseValue: 11, attHero: true),
  CardData(baseValue: 15, attHero: true),
];

const moraleCards = <CardData>[
  CardData(baseValue: 1, attMorale: true),
  CardData(baseValue: 6, attMorale: true),
  CardData(baseValue: 8, attMorale: true),
  CardData(baseValue: 10, attMorale: true),
  CardData(baseValue: 12, attMorale: true),
  CardData(baseValue: 14, attMorale: true),
];

const tightBondCards = <CardData>[
  CardData(baseValue: 1, attTightBond: true),
  CardData(baseValue: 2, attTightBond: true),
  CardData(baseValue: 3, attTightBond: true),
  CardData(baseValue: 4, attTightBond: true),
  CardData(baseValue: 5, attTightBond: true),
  CardData(baseValue: 6, attTightBond: true),
  CardData(baseValue: 8, attTightBond: true),
];

const cmdHornCards = <CardData>[
  CardData(baseValue: 2, attCommanderHorn: true),
];
