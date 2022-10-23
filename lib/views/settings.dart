import 'package:flutter/material.dart';

import 'package:gwentboard/components/_layout/side_page.dart';
import 'package:gwentboard/components/title_divider.dart';
import 'package:gwentboard/utils/board_sizer.dart';

// NOTE: This page has not been implemented yet.

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final BoardSizer boardSizer = BoardSizer.calcBoardSizer(
      width: width,
      height: height,
    );
    return SidePage(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleDivider(title: 'Display'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Scale:'), Text('${boardSizer.scale}')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
