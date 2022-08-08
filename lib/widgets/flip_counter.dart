import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:musicart/global_variables/global_variables.dart';

class FlipCounter extends StatefulWidget {
  const FlipCounter({
    Key? key,
    required this.count,
    required this.onAdd,
    required this.onRemove,
    required this.value,
  }) : super(key: key);

  final int count;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final double value;

  @override
  State<FlipCounter> createState() => _FlipCounterState();
}

class _FlipCounterState extends State<FlipCounter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: widget.onAdd,
            child: const Icon(
              Icons.add_circle,
              color: Colors.black,
              size: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AnimatedFlipCounter(
              value: widget.value,
              textStyle: globalTextStyle.copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: widget.onRemove,
            child: const Icon(
              Icons.remove_circle,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
