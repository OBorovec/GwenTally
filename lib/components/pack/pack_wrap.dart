import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/pack/pack_bloc.dart';
import 'package:gwentboard/components/game/cards.dart';
import 'package:gwentboard/model/card_data.dart';
import 'package:gwentboard/utils/board_sizer.dart';

class CardPackWrap extends StatelessWidget {
  const CardPackWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      builder: (context, state) {
        return WrapSuper(
          alignment: WrapSuperAlignment.center,
          children: (state.normalCards + state.goldCards)
              .map(
                (CardData cvd) => DraggableCard(
                  data: cvd,
                  // TODO: delete after they fix it
                  sizer: context.read<BoardSizer>(),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
