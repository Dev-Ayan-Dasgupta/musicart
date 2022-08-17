import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTap;
  final String url;
  const RoundedButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          //borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
