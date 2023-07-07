import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/components/gameplay/board_card.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/views/board_original/board_consts.dart';
import 'package:gwentboard/views/board_original/components/pack/bloc/pack_bloc.dart';

class CardPackWrap extends StatelessWidget {
  const CardPackWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      builder: (context, state) {
        return WrapSuper(
          wrapType: WrapType.balanced,
          alignment: WrapSuperAlignment.center,
          children: (state.normalCards + state.goldCards)
              .map(
                (CardData cardData) => BoardCard(
                  config: context.read<BoardCardSize>(),
                  data: cardData,
                  isDraggable: true,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
