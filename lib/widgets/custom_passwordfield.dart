import 'package:flutter/material.dart';

import '../global_variables/global_variables.dart';

class CustomPasswordField extends StatefulWidget {
  CustomPasswordField({
    Key? key,
    required this.width,
    required this.height,
    required this.textEditingController,
    required this.hintText,
    required this.isObscured,
    required this.onChanged,
  }) : super(key: key);

  final double width;
  final double height;
  final TextEditingController textEditingController;
  final String hintText;
  bool isObscured;
  final Function(String)? onChanged;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                  Icons.password_rounded,
                  color: Colors.grey,
                  size: widget.width * 0.04,
                ),
              ),
              SizedBox(
                width: widget.width * 0.85,
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: widget.textEditingController,
                  obscureText: widget.isObscured,
                  onChanged: widget.onChanged,
                  style: globalTextStyle.copyWith(
                      color: Colors.grey, fontSize: widget.width * 0.04),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: globalTextStyle.copyWith(
                        color: Colors.grey, fontSize: widget.width * 0.04),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.isObscured = !widget.isObscured;
                        });
                      },
                      icon: (widget.isObscured)
                          ? Icon(
                              Icons.visibility_outlined,
                              color: Colors.grey,
                              size: widget.width * 0.04,
                            )
                          : Icon(
                              Icons.visibility_off_rounded,
                              color: Colors.grey,
                              size: widget.width * 0.04,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
