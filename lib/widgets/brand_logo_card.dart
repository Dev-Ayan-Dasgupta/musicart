import 'package:flutter/material.dart';

class BrandLogoCard extends StatelessWidget {
  final double width;
  final double? height;
  final String brandImageUrl;
  final double paddingRight;
  const BrandLogoCard({
    Key? key,
    required this.width,
    this.height,
    required this.brandImageUrl,
    required this.paddingRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(right: paddingRight),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(brandImageUrl),
              fit: BoxFit.fill,
              invertColors: true,
            ),
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
