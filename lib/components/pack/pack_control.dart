import 'package:flutter/material.dart';

import 'package:gwentboard/components/pack/pack_icon_switch.dart';

class PackControl extends StatelessWidget {
  const PackControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        TightBondIconSwitch(),
        HornIconSwitch(),
        MoralIconSwitch(),
        DoubleMoralIconSwitch(),
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
      children: const [
        TightBondIconSwitch(),
        HornIconSwitch(),
        MoralIconSwitch(),
        DoubleMoralIconSwitch(),
      ],
    );
  }
}
