import 'package:flutter/material.dart';

import 'package:gwentboard/route_generator.dart';
import 'package:gwentboard/components/_layout/root_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      body: Column(
        children: [
          Expanded(
            child: AppBoardOption(
              text: 'Original',
              colorBackground: Theme.of(context).colorScheme.primary,
              colorText: Theme.of(context).colorScheme.onPrimary,
              onTap: () =>
                  Navigator.pushNamed(context, RoutePaths.originalBoard),
            ),
          ),
          Expanded(
            child: AppBoardOption(
              text: 'Gwent 2.0 \n Coming soon',
              colorBackground: Theme.of(context).colorScheme.background,
              colorText: Theme.of(context).colorScheme.onBackground,
              onTap: () => null,
              // onTap: () =>
              //     Navigator.pushNamed(context, RoutePaths.originalBoard),
            ),
          ),
        ],
      ),
      actionButtons: const [
        // ActionButton(
        //   onPressed: () => Navigator.pushNamed(context, RoutePaths.info),
        //   icon: const Icon(Icons.info),
        // ),
        // ActionButton(
        //   onPressed: () => Navigator.pushNamed(context, RoutePaths.packs),
        //   icon: const Icon(Icons.local_library),
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
  final String text;
  final Color colorBackground;
  final Color colorText;
  final Function() onTap;
  const AppBoardOption({
    Key? key,
    required this.text,
    required this.onTap,
    required this.colorBackground,
    required this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: colorBackground,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: colorText,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
