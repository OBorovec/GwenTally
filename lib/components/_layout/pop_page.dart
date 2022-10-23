import 'package:flutter/material.dart';

class PopDialogPage extends StatefulWidget {
  final Widget body;

  const PopDialogPage({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  State<PopDialogPage> createState() => _PopDialogPageState();
}

class _PopDialogPageState extends State<PopDialogPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: widget.body,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Leaving board'),
            content: const Text('Do you want to return ti the main page?'),
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
