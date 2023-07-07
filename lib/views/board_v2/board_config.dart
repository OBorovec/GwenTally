import 'package:flutter/material.dart';
import 'package:gwentboard/components/gameplay/board_card.dart';
import 'package:gwentboard/views/board_v2/components/battle_line/battle_line.dart';
import 'package:gwentboard/views/board_v2/components/pack/pack_overlay.dart';
import 'package:gwentboard/views/board_v2/components/pack/pack_overview.dart';

class BoardConfig {
  late final PackOverviewConfig packOverviewConfig;
  late final PackOverlayConfig packOverlayConfig;
  late final BattleLineConfig lineConfig;
  late final CardConfig boardCard;
  late final CardConfig packTopCard;

  BoardConfig({
    required double height,
    required double width,
  }) {
    final double _controlHeight = height * 0.16;
    final double _battleSideHeight = height * 0.42;
    final double _lineHeight = _battleSideHeight / 3;
    final double _lineSplitRatio = 0.8;
    final double _cardVerticalSpace = _lineHeight * _lineSplitRatio;
    final double _packRadius = width * 0.35;
    final double _packTopCardHeight = _controlHeight * 0.8;

    debugPrint('BoardConfig: height: $height, width: $width');
    debugPrint('BoardConfig: controlHeight: $_controlHeight');
    debugPrint('BoardConfig: battleSideHeight: $_battleSideHeight');
    debugPrint('BoardConfig: lineHeight: $_lineHeight');
    debugPrint('BoardConfig: cardVerticalSpace: $_cardVerticalSpace');
    debugPrint('BoardConfig: packRadius: $_packRadius');
    debugPrint('BoardConfig: packTopCardHeight: $_packTopCardHeight');

    packOverviewConfig = PackOverviewConfig(
      height: _controlHeight,
    );
    packOverlayConfig = PackOverlayConfig(
      radius: _packRadius,
      optBtnSize: 48,
      optBtnPadding: 8,
      optBtnFont: 24,
      optBtnIconSize: 24,
    );
    lineConfig = BattleLineConfig(
      splitRatio: _lineSplitRatio,
      height: _lineHeight,
      width: width,
    );
    boardCard = CardConfig(
      cardVerticalSpace: _cardVerticalSpace,
    );
    packTopCard = CardConfig(
      cardVerticalSpace: _packTopCardHeight,
    );
  }
}
