import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gwentboard/utils/board_sizer.dart';
import 'package:gwentboard/components/pack/pack_icon_switch.dart';

class PackControl extends StatelessWidget {
  const PackControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BrotherIconSwitch(
          iconSize: context.read<BoardSizer>().controlIconSize,
        ),
        HornIconSwitch(
          iconSize: context.read<BoardSizer>().controlIconSize,
        ),
        SupportIconSwitch(
          iconSize: context.read<BoardSizer>().controlIconSize,
        ),
        DoubleSupportIconSwitch(
          iconSize: context.read<BoardSizer>().controlIconSize,
        ),
      ],
    );
  }
}

class PackControlRow extends StatelessWidget {
  const PackControlRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BrotherIconSwitch(
          iconSize: context.read<BoardSizer>().controlIconSize,
        ),
        HornIconSwitch(
          iconSize: context.read<BoardSizer>().controlIconSize,
        ),
        SupportIconSwitch(
          iconSize: context.read<BoardSizer>().controlIconSize,
        ),
        DoubleSupportIconSwitch(
          iconSize: context.read<BoardSizer>().controlIconSize,
        ),
      ],
    );
  }
}
