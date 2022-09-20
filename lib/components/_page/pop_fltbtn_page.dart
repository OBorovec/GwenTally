import 'package:flutter/material.dart';

class PopFltBtnPage extends StatefulWidget {
  final Widget body;
  final List<IconButton> actionButtons;

  const PopFltBtnPage({
    Key? key,
    required this.body,
    this.actionButtons = const <IconButton>[],
  }) : super(key: key);

  @override
  State<PopFltBtnPage> createState() => _PopFltBtnPageState();
}

class _PopFltBtnPageState extends State<PopFltBtnPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: null,
        body: widget.body,
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            _onWillPop().then((value) {
              if (value) Navigator.of(context).pop();
            });
          },
          heroTag: 'menu_tag',
          child: const Icon(Icons.cancel),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Leaving board'),
            content: const Text('Do you want to exit current board?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
