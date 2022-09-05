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
    bool? attGroup,
    bool? attBrothers,
    bool? attSupport,
    bool? attDoubleSupport,
    bool? attMoral,
    bool? attGolden,
  }) {
    return CardData(
      initTime: initTime ?? this.initTime,
      baseValue: baseValue ?? this.baseValue,
      activeValue: activeValue ?? this.activeValue,
      attMuster: attGroup ?? this.attMuster,
      attTightBond: attBrothers ?? this.attTightBond,
      attMoral: attSupport ?? this.attMoral,
      attDoubleMoral: attDoubleSupport ?? this.attDoubleMoral,
      attCommanderHorn: attMoral ?? this.attCommanderHorn,
      attHero: attGolden ?? this.attHero,
    );
  }
}
