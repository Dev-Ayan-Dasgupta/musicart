import 'package:flutter/material.dart';

import '../global_variables/global_variables.dart';

class PaymentsScreenSubTile extends StatelessWidget {
  const PaymentsScreenSubTile({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
    required this.onIconTap,
    required this.text,
    required this.imgUrl,
    required this.iconData,
  }) : super(key: key);

  final double? screenWidth;
  final double? screenHeight;
  final VoidCallback onTap;
  final VoidCallback onIconTap;
  final String text;
  final String imgUrl;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth! * 0.06,
                  height: screenWidth! * 0.06,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(imgUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: screenWidth! * 0.025)),
                Text(
                  text,
                  style: globalTextStyle.copyWith(
                    color: primaryColor,
                    fontSize: screenWidth! * 0.03,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight! * 0.05))
              ],
            ),
            Padding(padding: EdgeInsets.only(right: screenWidth! * 0.025)),
            InkWell(
              onTap: onIconTap,
              child: Icon(
                iconData,
                size: screenWidth! * 0.06,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
