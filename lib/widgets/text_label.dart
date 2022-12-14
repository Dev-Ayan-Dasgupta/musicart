import 'package:flutter/material.dart';

import '../global_variables/global_variables.dart';

class TextLabel extends StatelessWidget {
  const TextLabel({
    Key? key,
    required this.width,
    required this.labelText,
    required this.fontSize,
  }) : super(key: key);

  final double width;
  final String labelText;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      alignment: Alignment.centerLeft,
      child: Container(
        width: width,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            labelText,
            style: globalTextStyle.copyWith(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              //backgroundColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
