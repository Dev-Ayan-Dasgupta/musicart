import 'package:flutter/material.dart';

import '../global_variables/global_variables.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.screenWidth,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  final double? screenWidth;
  final String value;
  final String? groupValue;
  final Function(String?)? onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
        ),
        Padding(
          padding: EdgeInsets.only(left: screenWidth! * 0.01),
        ),
        Text(
          text,
          style: globalTextStyle.copyWith(
            color: primaryColor,
            fontSize: screenWidth! * 0.02,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: screenWidth! * 0.02),
        ),
      ],
    );
  }
}
