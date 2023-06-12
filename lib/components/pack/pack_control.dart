import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/pack/pack_bloc.dart';

import 'package:gwentboard/components/pack/pack_icon_switch.dart';
import 'package:gwentboard/utils/board_sizer.dart';

class PackControl extends StatelessWidget {
  const PackControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TightBondIconSwitch(),
        HornIconSwitch(),
        MoralIconSwitch(),
        // PopupMenuButton(
        //   itemBuilder: (BuildContext popupContext) {
        //     return [
        //       _buildMenuItem(
        //         context,
        //         icon: const SpyIconSwitch(),
        //       ),
        //       _buildMenuItem(
        //         context,
        //         icon: const HybridIconSwitch(),
        //       ),
        //     ];
        //   },
        //   child: Icon(
        //     Icons.more_horiz,
        //     size: context.read<BoardSizer>().controlIconSize,
        //     color: Theme.of(context).colorScheme.onSecondary,
        //   ),
        // ),
      ],
    );
  }

  PopupMenuItem<dynamic> _buildMenuItem(BuildContext context,
      {required Widget icon}) {
    return PopupMenuItem(
      child: BlocProvider.value(
        value: BlocProvider.of<PackBloc>(context),
        child: RepositoryProvider.value(
            value: context.read<BoardSizer>(), child: icon),
      ),
    );
  }
}

class PackControlRow extends StatelessWidget {
  const PackControlRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TightBondIconSwitch(),
        HornIconSwitch(),
        MoralIconSwitch(),
      ],
    );
  }
}
