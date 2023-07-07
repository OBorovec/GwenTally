import 'package:gwentboard/components/gameplay/board_card.dart';

class BoardDims {
  // Board general
  static const double scoreFontSize = 22;

  // Board card defaults
  static const double cardHeight = 54; // Border width is 2 -> 50
  static const double cardWidth = 24; // Border width is 2 -> 20
  static const double cardPadding = 2;
  static const double cardInnerPadding = 2;
  static const double cardActiveFontSize = 12;
  static const double cardPassiveFontSize = 10;
  static const double cardIconSize = 16;

  // Battle line defaults
  static const double lineTopPadding = 20; // Space for line title
  static const double lineTitleTopOffset = 4;
  static const double lineTitleFontSize = 12;
  static const double lineWeatherIconSize = 20;
  static const double lineScoreFontSize = 20;

  // Board control icon defaults
  static const double controlIconSize = 24;
  static const double controlIconPaddingVertical = 3;
  static const double controlIconPaddingHorizontal = 6;

  // Dependent board dimensions
  static const double cardViewHeight = cardHeight + 2 * cardPadding;
  static const double cardViewWidth = cardWidth + 2 * cardPadding;
  static const double controlIconHeight =
      controlIconSize + 2 * controlIconPaddingVertical;
  static const double controlIconWidth =
      controlIconSize + 2 * controlIconPaddingHorizontal;
  static const double battleLineHeight = lineTopPadding + cardViewHeight;
  static const double battleSideHeight = battleLineHeight * 3;
  static const double controlLineHeight =
      controlIconSize * (5 / 4) + 2 * controlIconPaddingVertical;
  static const double controlLineWidth = 3 * controlIconSize * (4 / 3) +
      3 * controlIconSize +
      2 * 16 + // Default widget of VerticalDivider
      12 * controlIconPaddingHorizontal;

  // Board dimensions
  static const double minBoardWidth = controlLineWidth;
  static const double minBoardHeight =
      2 * battleSideHeight + 3 * cardHeight + controlLineHeight + 12 + 8;
  static const double maxBoardHeight = 1.6 * minBoardHeight;
}

class BoardCardSize extends CardConfig {
  BoardCardSize({required super.cardVerticalSpace});
}
