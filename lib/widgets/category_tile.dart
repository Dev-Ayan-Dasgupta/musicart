import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.onTap,
    required this.tileImageUrl,
    required this.width,
    required this.height,
    required this.title,
    required this.fontSize,
    required this.titlePosition,
  }) : super(key: key);
  final VoidCallback onTap;
  final String tileImageUrl;
  final double width;
  final double height;
  final String title;
  final double fontSize;
  final double titlePosition;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(tileImageUrl),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: titlePosition,
                child: Text(
                  title,
                  style: globalTextStyle.copyWith(
                    color: Colors.white70,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
