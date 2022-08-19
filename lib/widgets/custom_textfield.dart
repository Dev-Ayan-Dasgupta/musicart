import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.width,
    required this.height,
    required this.textEditingController,
    required this.hintText,
    this.keyboardType,
    required this.iconData,
  }) : super(key: key);

  final double width;
  final double height;
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType? keyboardType;
  final IconData iconData;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.25,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.width * 0.04),
            child: Icon(
              widget.iconData,
              color: Colors.grey,
              size: widget.width * 0.04,
            ),
          ),
          SizedBox(
            width: widget.width * 0.85,
            child: TextField(
              cursorColor: Colors.grey,
              controller: widget.textEditingController,
              style: globalTextStyle.copyWith(
                  color: Colors.grey, fontSize: widget.width * 0.04),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: globalTextStyle.copyWith(
                    color: Colors.grey, fontSize: widget.width * 0.04),
              ),
              keyboardType: widget.keyboardType,
            ),
          ),
        ],
      ),
    );
  }
}
