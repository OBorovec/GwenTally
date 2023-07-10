import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TightBondDialog extends StatefulWidget {
  final int initValue;
  final Function(int) onSet;
  const TightBondDialog({
    Key? key,
    required this.initValue,
    required this.onSet,
  }) : super(key: key);

  @override
  State<TightBondDialog> createState() => _TightBondDialogState();
}

class _TightBondDialogState extends State<TightBondDialog> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Alter tight bond:',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => setState(() {
              if (_currentValue > 1) _currentValue--;
            }),
            icon: const Icon(Icons.arrow_drop_up_sharp),
          ),
          NumberPicker(
            value: _currentValue,
            minValue: 1,
            maxValue: 6,
            onChanged: (value) => setState(() => _currentValue = value),
          ),
          IconButton(
            onPressed: () => setState(() {
              if (_currentValue < 6) _currentValue++;
            }),
            icon: const Icon(Icons.arrow_drop_down_sharp),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Dismiss'),
        ),
        TextButton(
          onPressed: () {
            widget.onSet(_currentValue);
            Navigator.pop(context, false);
          },
          child: const Text('Set'),
        ),
      ],
    );
  }
}
