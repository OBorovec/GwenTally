import 'package:flutter/material.dart';
import 'package:gwentboard/components/_page/side_page.dart';

class PacksPage extends StatelessWidget {
  const PacksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SidePage(
      body: Center(
        child: Text('Packs'),
      ),
    );
  }
}
