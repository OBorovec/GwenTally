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

class HornIconSwitch extends PackIconSwitch {
  HornIconSwitch({
    Key? key,
    double? iconSize,
  }) : super(
          key: key,
          iconData: GwentIcons.commanderHorn,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.attHorn;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackHorn());
  }
}

class GroupIconSwitch extends PackIconSwitch {
  GroupIconSwitch({
    Key? key,
    double? iconSize,
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

class BrotherIconSwitch extends PackIconSwitch {
  BrotherIconSwitch({
    Key? key,
    double? iconSize,
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

class SupportIconSwitch extends PackIconSwitch {
  SupportIconSwitch({
    Key? key,
    double? iconSize,
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

class DoubleSupportIconSwitch extends PackIconSwitch {
  DoubleSupportIconSwitch({
    Key? key,
    double? iconSize,
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
