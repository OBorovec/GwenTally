import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gwentboard/bloc/pack/pack_bloc.dart';
import 'package:gwentboard/components/_control/toggle_icon.dart';
import 'package:gwentboard/constants/gwent_icons.dart';
import 'package:gwentboard/utils/board_sizer.dart';

abstract class PackIconSwitch extends StatelessWidget {
  final IconData iconData;
  const PackIconSwitch({
    Key? key,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      builder: (context, state) {
        final bool isOn = _getIsOn(state);
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.read<BoardSizer>().controlIconPaddingHorizontal,
            vertical: context.read<BoardSizer>().controlIconPaddingVertical,
          ),
          child: ToggleIcon(
            isOn: isOn,
            iconData: iconData,
            iconSize: context.read<BoardSizer>().controlIconSize,
            onTap: () => _onTap(context),
          ),
        );
      },
    );
  }

  bool _getIsOn(PackState state);

  void _onTap(BuildContext context);
}

// class HornIconSwitch extends PackIconSwitch {
//   HornIconSwitch({
//     Key? key,
//   }) : super(
//           key: key,
//           iconData: GwentIcons.commanderHorn,
//         );

//   @override
//   bool _getIsOn(PackState state) {
//     return state.attHorn;
//   }

//   @override
//   void _onTap(BuildContext context) {
//     BlocProvider.of<PackBloc>(context).add(TogglePackHorn());
//   }
// }

class HornIconSwitch extends StatelessWidget {
  const HornIconSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackBloc, PackState>(
      builder: (context, state) {
        final bool isOn = state.attHorn;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.read<BoardSizer>().controlIconPaddingHorizontal,
            vertical: context.read<BoardSizer>().controlIconPaddingVertical,
          ),
          child: InkWell(
            onTap: () =>
                BlocProvider.of<PackBloc>(context).add(TogglePackHorn()),
            child: ImageIcon(
              GwentIcons.commanderHorn,
              size: context.read<BoardSizer>().controlIconSize,
              color: isOn
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        );
      },
    );
  }
}

class MusterIconSwitch extends PackIconSwitch {
  const MusterIconSwitch({
    Key? key,
  }) : super(
          key: key,
          iconData: GwentIcons.muster,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.attMuster;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackMuster());
  }
}

class TightBondIconSwitch extends PackIconSwitch {
  const TightBondIconSwitch({
    Key? key,
  }) : super(
          key: key,
          iconData: GwentIcons.tightBond,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.attTightBond;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackTightBond());
  }
}

class MoralIconSwitch extends PackIconSwitch {
  const MoralIconSwitch({
    Key? key,
  }) : super(
          key: key,
          iconData: GwentIcons.moral,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.attMoral;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackMoral());
  }
}

class DoubleMoralIconSwitch extends PackIconSwitch {
  const DoubleMoralIconSwitch({
    Key? key,
  }) : super(
          key: key,
          iconData: GwentIcons.doubleMoral,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.attDoubleMoral;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackDoubleMoral());
  }
}
