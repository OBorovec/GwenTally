import 'package:flutter/material.dart';
import 'package:gwentboard/components/_page/root_page.dart';
import 'package:gwentboard/components/expandable_fab.dart';
import 'package:gwentboard/route_generator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      body: Column(
        children: [
          Expanded(
            child: AppBoardOption(
              label: 'Full board',
              background: Theme.of(context).primaryColorLight,
              onTap: () => Navigator.pushNamed(context, RoutePaths.fullBoard),
            ),
          ),
          Expanded(
            child: AppBoardOption(
              label: 'Half board',
              background: Theme.of(context).primaryColorDark,
              onTap: () => Navigator.pushNamed(context, RoutePaths.singleBoard),
            ),
          ),
        ],
      ),
      actionButtons: [
        ActionButton(
          onPressed: () => Navigator.pushNamed(context, RoutePaths.info),
          icon: const Icon(Icons.info),
        ),
        // ActionButton(
        //   onPressed: () => Navigator.pushNamed(context, RoutePaths.packs),
        //   icon: const Icon(Icons.card_membership),
        // ),
        // ActionButton(
        //   onPressed: () => Navigator.pushNamed(context, RoutePaths.capture),
        //   icon: const Icon(Icons.camera),
        // ),
        // ActionButton(
        //   onPressed: () => Navigator.pushNamed(context, RoutePaths.settings),
        //   icon: const Icon(Icons.settings),
        // )
      ],
    );
  }
}

class AppBoardOption extends StatelessWidget {
  final String label;
  final Color background;
  final Function() onTap;
  const AppBoardOption({
    Key? key,
    required this.label,
    required this.onTap,
    required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        color: background,
      ),
    );
  }
}
