import 'dart:math';

import 'package:gwentboard/views/board_original/board_consts.dart';

// TODO: Make it more readable

class BoardSizer {
  // General variables
  final double scale;
  final double scoreFontSize;
  // Variables depending on scale
  final double cardHeight;
  final double cardWidth;
  final double cardPadding;
  final double cardInnerPadding;
  final double cardActiveFontSize;
  final double cardPassiveFontSize;
  final double cardIconSize;
  final double cardViewHeight;
  final double lineTopPadding;
  final double lineTitleTopOffset;
  final double lineTitleFontSize;
  final double lineWeatherIconSize;
  final double lineScoreFontSize;
  final double controlIconSize;
  final double controlIconPaddingVertical;
  final double controlIconPaddingHorizontal;
  // Computed variable from above
  final double controlIconWidth;
  final double controlIconHeight;
  final double battleSideHeight;
  final double controlLineHeight;
  final double controlLineWidth;
  // Flags
  final bool isSingleLinePack;
  final bool useFullViews;

  const BoardSizer({
    this.scale = 1,
    this.scoreFontSize = BoardDims.scoreFontSize,
    this.cardHeight = BoardDims.cardHeight,
    this.cardWidth = BoardDims.cardWidth,
    this.cardPadding = BoardDims.cardPadding,
    this.cardInnerPadding = BoardDims.cardInnerPadding,
    this.cardActiveFontSize = BoardDims.cardActiveFontSize,
    this.cardPassiveFontSize = BoardDims.cardPassiveFontSize,
    this.cardIconSize = BoardDims.cardIconSize,
    this.cardViewHeight = BoardDims.cardViewHeight,
    this.lineTopPadding = BoardDims.lineTopPadding,
    this.lineTitleTopOffset = BoardDims.lineTitleTopOffset,
    this.lineTitleFontSize = BoardDims.lineTitleFontSize,
    this.lineWeatherIconSize = BoardDims.lineWeatherIconSize,
    this.lineScoreFontSize = BoardDims.lineScoreFontSize,
    this.controlIconSize = BoardDims.controlIconSize,
    this.controlIconPaddingVertical = BoardDims.controlIconPaddingVertical,
    this.controlIconPaddingHorizontal = BoardDims.controlIconPaddingHorizontal,
    this.controlIconWidth =
        BoardDims.controlIconSize + 2 * BoardDims.controlIconPaddingHorizontal,
    this.controlIconHeight =
        BoardDims.controlIconSize + 2 * BoardDims.controlIconPaddingVertical,
    this.battleSideHeight = (BoardDims.lineTopPadding +
            BoardDims.cardHeight +
            2 * BoardDims.cardPadding) *
        3,
    this.controlLineHeight = (BoardDims.controlIconSize * (5 / 4) +
        2 * BoardDims.controlIconPaddingVertical),
    this.controlLineWidth = 3 * BoardDims.controlIconSize * (4 / 3) +
        3 * BoardDims.controlIconSize +
        2 * 16 +
        12 * BoardDims.controlIconPaddingHorizontal,
    this.isSingleLinePack = false,
    this.useFullViews = true,
  });

  static BoardSizer calcBoardSizer({
    required double width,
    required double height,
  }) {
    double scale =
        min(height * 0.95, BoardDims.maxBoardHeight) / BoardDims.minBoardHeight;
    scale = (scale * 10).floorToDouble() / 10;
    // Show minimal board size with collapsible sides
    if (scale < 1) {
      return BoardSizer(
        scale: scale,
        useFullViews: false,
      );
    }
    // Show scaled up board
    return BoardSizer(
      scale: scale,
      useFullViews: true,
      scoreFontSize: (BoardDims.scoreFontSize * scale).floorToDouble(),
      cardHeight: (BoardDims.cardHeight * scale).floorToDouble(),
      cardWidth: (BoardDims.cardWidth * scale).floorToDouble(),
      cardPadding: (BoardDims.cardPadding * scale).floorToDouble(),
      cardInnerPadding: (BoardDims.cardInnerPadding * scale).floorToDouble(),
      cardActiveFontSize:
          (BoardDims.cardActiveFontSize * scale).floorToDouble(),
      cardPassiveFontSize:
          (BoardDims.cardPassiveFontSize * scale).floorToDouble(),
      cardIconSize: (BoardDims.cardIconSize * scale).floorToDouble(),
      cardViewHeight: (BoardDims.cardViewHeight * scale).floorToDouble(),
      lineTopPadding: (BoardDims.lineTopPadding * scale).floorToDouble(),
      lineTitleTopOffset:
          (BoardDims.lineTitleTopOffset * scale).floorToDouble(),
      lineTitleFontSize: (BoardDims.lineTitleFontSize * scale).floorToDouble(),
      lineWeatherIconSize:
          (BoardDims.lineWeatherIconSize * scale).floorToDouble(),
      lineScoreFontSize: (BoardDims.lineScoreFontSize * scale).floorToDouble(),
      controlIconSize: (BoardDims.controlIconSize * scale).floorToDouble(),
      controlIconPaddingVertical:
          (BoardDims.controlIconPaddingVertical * scale).floorToDouble(),
      controlIconPaddingHorizontal:
          (BoardDims.controlIconPaddingHorizontal * scale).floorToDouble(),
      controlIconWidth: ((BoardDims.controlIconSize +
                  2 * BoardDims.controlIconPaddingHorizontal) *
              scale)
          .floorToDouble(),
      controlIconHeight: ((BoardDims.controlIconSize +
                  2 * BoardDims.controlIconPaddingVertical) *
              scale)
          .floorToDouble(),
      battleSideHeight: ((BoardDims.lineTopPadding +
                  BoardDims.cardHeight +
                  2 * BoardDims.cardPadding) *
              3 *
              scale)
          .floorToDouble(),
      controlLineHeight: ((BoardDims.controlIconSize * (5 / 4) +
                  2 * BoardDims.controlIconPaddingVertical) *
              scale)
          .floorToDouble(),
      controlLineWidth: ((3 * BoardDims.controlIconSize * (4 / 3) +
                  3 * BoardDims.controlIconSize +
                  2 * 16 +
                  12 * BoardDims.controlIconPaddingHorizontal) *
              scale)
          .floorToDouble(),
    );
  }
}
