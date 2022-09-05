import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/bloc/pack/pack_bloc.dart';
import 'package:gwentboard/components/_control/toggle_icon.dart';
import 'package:gwentboard/constants/gwent_icons.dart';

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
        return ToggleIcon(
          isOn: isOn,
          iconData: iconData,
          iconSize: 28,
          onTap: () => _onTap(context),
        );
      },
    );
  }

  bool _getIsOn(PackState state);

  void _onTap(BuildContext context);
}

class MoralIconSwitch extends PackIconSwitch {
  MoralIconSwitch({Key? key})
      : super(
          key: key,
          iconData: GwentIcons.commanderHorn,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.moralCard;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackMorale());
  }
}

class GroupIconSwitch extends PackIconSwitch {
  GroupIconSwitch({Key? key}) : super(key: key, iconData: GwentIcons.muster);

  @override
  bool _getIsOn(PackState state) {
    return state.groupCard;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackGroup());
  }
}

class BrotherIconSwitch extends PackIconSwitch {
  BrotherIconSwitch({Key? key})
      : super(
          key: key,
          iconData: GwentIcons.tightBond,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.brotherCard;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackBrother());
  }
}

class SupportIconSwitch extends PackIconSwitch {
  SupportIconSwitch({Key? key})
      : super(
          key: key,
          iconData: GwentIcons.moral,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.supportCard;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackSupport());
  }
}

class DoubleSupportIconSwitch extends PackIconSwitch {
  DoubleSupportIconSwitch({Key? key})
      : super(
          key: key,
          iconData: GwentIcons.doubleMoral,
        );

  @override
  bool _getIsOn(PackState state) {
    return state.doubleSupportCard;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<PackBloc>(context).add(TogglePackDoubleSupport());
  }
}
