import 'package:flutter/material.dart';

import '../global_variables/global_variables.dart';

class PopularBankTile extends StatelessWidget {
  const PopularBankTile({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.foregroundImage,
    required this.text,
    required this.onBankTap,
  }) : super(key: key);

  final double? screenHeight;
  final double? screenWidth;
  final NetworkImage foregroundImage;
  final String text;
  final VoidCallback onBankTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBankTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(foregroundImage: foregroundImage),
          Padding(padding: EdgeInsets.only(top: screenHeight! * 0.01)),
          Text(
            text,
            style: globalTextStyle.copyWith(
              color: primaryColor,
              fontSize: screenWidth! * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}
