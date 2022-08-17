import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';

class CustomDivider extends StatelessWidget {
  final String content;
  final double width;
  final double fontSize;
  const CustomDivider({
    Key? key,
    required this.content,
    required this.width,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          height: 0.5,
          width: width,
        ),
        const Padding(padding: EdgeInsets.all(5)),
        Text(
          content,
          style: globalTextStyle.copyWith(
            color: Colors.grey,
            fontSize: fontSize,
          ),
          textScaleFactor: 0.8,
        ),
        const Padding(padding: EdgeInsets.all(5)),
        Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          height: 0.5,
          width: width,
        ),
      ],
    );
  }
}
