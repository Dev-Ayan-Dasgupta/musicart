import 'package:flutter/material.dart';

import '../global_variables/global_variables.dart';

class AccountScreenInfoList extends StatelessWidget {
  const AccountScreenInfoList({
    Key? key,
    required this.screenWidth,
    required this.iconData1,
    required this.iconData2,
    required this.iconData3,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
  }) : super(key: key);

  final double? screenWidth;
  final IconData iconData1;
  final IconData iconData2;
  final IconData iconData3;
  final String text1;
  final String text2;
  final String text3;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final VoidCallback onTap3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.025),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  iconData1,
                  size: screenWidth! * 0.06,
                ),
                Padding(padding: EdgeInsets.only(left: screenWidth! * 0.025)),
                Text(
                  text1,
                  style: globalTextStyle.copyWith(
                    fontSize: screenWidth! * 0.035,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: screenWidth! * 0.02)),
          InkWell(
            onTap: onTap2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  iconData2,
                  size: screenWidth! * 0.06,
                ),
                Padding(padding: EdgeInsets.only(left: screenWidth! * 0.025)),
                Text(text2,
                    style: globalTextStyle.copyWith(
                      fontSize: screenWidth! * 0.035,
                      color: primaryColor,
                    )),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: screenWidth! * 0.02)),
          InkWell(
            onTap: onTap3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  iconData3,
                  size: screenWidth! * 0.06,
                ),
                Padding(padding: EdgeInsets.only(left: screenWidth! * 0.025)),
                Text(text3,
                    style: globalTextStyle.copyWith(
                      fontSize: screenWidth! * 0.035,
                      color: primaryColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
