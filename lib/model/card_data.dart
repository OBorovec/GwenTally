import 'package:equatable/equatable.dart';

class CardData extends Equatable {
  final DateTime? initTime;
  final int baseValue;
  final int? activeValue;
  final bool attMuster;
  final bool attTightBond;
  final bool attMoral;
  final bool attDoubleMoral;
  final bool attCommanderHorn;
  final bool attHero;

  const CardData({
    this.initTime,
    required this.baseValue,
    this.activeValue,
    this.attMuster = false,
    this.attTightBond = false,
    this.attMoral = false,
    this.attDoubleMoral = false,
    this.attCommanderHorn = false,
    this.attHero = false,
  });

  @override
  List<Object?> get props => [initTime];

  CardData copyWith({
    DateTime? initTime,
    int? baseValue,
    int? activeValue,
    bool? attMuster,
    bool? attTightBond,
    bool? attMoral,
    bool? attDoubleMoral,
    bool? attCommanderHorn,
    bool? attHero,
  }) {
    return CardData(
      initTime: initTime ?? this.initTime,
      baseValue: baseValue ?? this.baseValue,
      activeValue: activeValue ?? this.activeValue,
      attMuster: attMuster ?? this.attMuster,
      attTightBond: attTightBond ?? this.attTightBond,
      attMoral: attMoral ?? this.attMoral,
      attDoubleMoral: attDoubleMoral ?? this.attDoubleMoral,
      attCommanderHorn: attCommanderHorn ?? this.attCommanderHorn,
      attHero: attHero ?? this.attHero,
    );
  }
}
