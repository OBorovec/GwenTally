import 'package:flutter/material.dart';
import 'package:gwentboard/components/pack/pack_icon_switch.dart';

class PackContol extends StatelessWidget {
  const PackContol({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MoralIconSwitch(),
        SupportIconSwitch(),
        BrotherIconSwitch(),
        DoubleSupportIconSwitch(),
      ],
    );
  }
}
