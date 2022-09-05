import 'package:flutter/material.dart';
import 'package:gwentboard/components/pack/pack_control.dart';
import 'package:gwentboard/components/pack/pack_wrap.dart';

class CardPack extends StatelessWidget {
  const CardPack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: CardPackWrap()),
        PackContol(),
      ],
    );
  }
}
