import 'package:flutter/material.dart';

class CustomNumberPicker extends StatefulWidget {
  const CustomNumberPicker({
    required this.initialValue,
    required this.onIncrease,
    required this.onDecrease,
    required this.minValue,
    required this.maxValue,
    super.key,
  })  : assert(
  minValue <= maxValue, 'minValue($minValue) <= maxValue($maxValue)'),
        assert(minValue <= initialValue && maxValue >= initialValue,
        'initialValue should be between min and max');

  final int initialValue;
  final int minValue;
  final int maxValue;
  final void Function(int) onIncrease;
  final void Function(int) onDecrease;

  @override
  State<CustomNumberPicker> createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      IconButton(
        onPressed: () => increase(),
        icon: const Icon(Icons.arrow_upward,color: Colors.lightGreen,),
      ),
      Text('$value'),
      IconButton(
        onPressed: () => decrease(),
        icon: const Icon(Icons.arrow_downward,color:Colors.lightGreen ,),
      ),
    ],
  );

  void increase() {
    if (value + 1 <= widget.maxValue) {
      setState(() {
        value++;
      });

      widget.onIncrease.call(value);
    }
  }

  void decrease() {
    if (value - 1 >= widget.minValue) {
      setState(() {
        value--;
      });

      widget.onDecrease.call(value);
    }
  }
}
