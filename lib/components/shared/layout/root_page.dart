import 'package:flutter/material.dart';
import 'package:gwentboard/components/shared/expandable_btn.dart';
import 'package:gwentboard/utils/toasting.dart';
import 'dart:io';

class RootPage extends StatefulWidget {
  final Widget body;
  final List<ActionButton> actionButtons;

  const RootPage({
    Key? key,
    required this.body,
    required this.actionButtons,
  }) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  DateTime currentBackPressTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: null,
        extendBody: true,
        body: Stack(
          children: [
            Positioned.fill(child: widget.body),
            Center(
              child: ExpandableBtn(
                child: const Icon(Icons.menu),
                heroTag: 'menu_tag',
                distance: 96.0,
                alignment: Alignment.center,
                children: [
                  ...widget.actionButtons,
                  ActionButton(
                    onPressed: () => exit(0),
                    icon: const Icon(Icons.exit_to_app),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    final DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toasting.notifyToast(context, 'Double tab to exit.');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
