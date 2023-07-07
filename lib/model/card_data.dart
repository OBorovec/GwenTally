// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CardData extends Equatable {
  final int baseValue;
  final bool attMuster;
  final bool attTightBond;
  final bool attMorale;
  final bool attDoubleMorale;
  final bool attDemorale;
  final bool attCommanderHorn;
  final bool attWeatherResistance;
  final bool attHero;

  const CardData({
    required this.baseValue,
    this.attMuster = false,
    this.attTightBond = false,
    this.attMorale = false,
    this.attDoubleMorale = false,
    this.attDemorale = false,
    this.attCommanderHorn = false,
    this.attWeatherResistance = false,
    this.attHero = false,
  });

  @override
  List<Object?> get props => [
        baseValue,
        attMuster,
        attTightBond,
        attMorale,
        attDoubleMorale,
        attDemorale,
        attCommanderHorn,
        attWeatherResistance,
        attHero
      ];

  CardData copyWith({
    int? baseValue,
    bool? attMuster,
    bool? attTightBond,
    bool? attMorale,
    bool? attDoubleMorale,
    bool? attDemorale,
    bool? attCommanderHorn,
    bool? attWeatherResistance,
    bool? attHero,
  }) {
    return CardData(
      baseValue: baseValue ?? this.baseValue,
      attMuster: attMuster ?? this.attMuster,
      attTightBond: attTightBond ?? this.attTightBond,
      attMorale: attMorale ?? this.attMorale,
      attDoubleMorale: attDoubleMorale ?? this.attDoubleMorale,
      attDemorale: attDemorale ?? this.attDemorale,
      attCommanderHorn: attCommanderHorn ?? this.attCommanderHorn,
      attWeatherResistance: attWeatherResistance ?? this.attWeatherResistance,
      attHero: attHero ?? this.attHero,
    );
  }
}
