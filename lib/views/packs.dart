import 'package:flutter/material.dart';

import 'package:gwentboard/components/_layout/side_page.dart';

// NOTE: This page has not been implemented yet.

class PacksPage extends StatelessWidget {
  const PacksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SidePage(
      body: Center(
        child: Root(),
      ),
    );
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool expanded = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTest(
            expanded: expanded,
          ),
          ElevatedButton(
              onPressed: () => setState(() {
                    expanded = !expanded;
                  }),
              child: const Text('Toggle')),
        ],
      ),
    );
  }
}

class AnimatedTest extends StatelessWidget {
  final bool expanded;
  const AnimatedTest({
    Key? key,
    required this.expanded,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(seconds: 1),
      firstChild: Stack(
        children: [
          Container(
            color: Colors.blue,
            width: 50,
            height: 300,
          )
        ],
      ),
      secondChild: Stack(
        children: [
          Container(
            color: Colors.blue,
            width: 50,
            height: 100,
          )
        ],
      ),
    );
  }
}
