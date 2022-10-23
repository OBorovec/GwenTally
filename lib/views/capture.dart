import 'package:flutter/material.dart';

import 'package:gwentboard/components/_layout/side_page.dart';

// NOTE: This page has not been implemented yet.

class CapturePage extends StatelessWidget {
  const CapturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      body: IconButton(
        icon: const Icon(Icons.camera_alt),
        onPressed: () {},
      ),
    );
  }
}
