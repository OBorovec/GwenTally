import 'package:flutter/material.dart';

class SidePage extends StatelessWidget {
  final Widget body;

  const SidePage({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: null,
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
