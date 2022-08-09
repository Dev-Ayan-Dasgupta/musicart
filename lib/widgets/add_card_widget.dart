import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';

class AddCard extends StatefulWidget {
  const AddCard({
    Key? key,
    required this.width,
    required this.height,
    required this.nameController,
    required this.cardNumController,
    required this.expiryDateController,
    required this.cvvController,
    required this.onChanged,
    required this.cardProviderImgUrl,
  }) : super(key: key);
  final double width;
  final double height;
  final TextEditingController nameController;
  final TextEditingController cardNumController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final Function(String)? onChanged;
  final String cardProviderImgUrl;

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String firstDigit = "";
  int cardProviderIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.width * 0.04,
              vertical: widget.height * 0.06,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: widget.width * 0.2,
                  height: widget.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(widget.cardProviderImgUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.width * 0.05,
              vertical: widget.height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Name",
                  style: globalTextStyle.copyWith(
                      color: tertiaryColor, fontSize: widget.width * 0.02),
                ),
                Padding(padding: EdgeInsets.only(top: widget.height * 0.025)),
                Container(
                  width: widget.width * 0.55,
                  height: widget.height * 0.1,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(color: tertiaryColor, width: 0.25),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: widget.width * 0.025,
                      right: widget.width * 0.025,
                      bottom: widget.height * 0.045,
                    ),
                    child: TextField(
                      controller: widget.nameController,
                      cursorColor: tertiaryColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: globalTextStyle.copyWith(
                          color: tertiaryColor, fontSize: widget.width * 0.025),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: widget.height * 0.03)),
                Text(
                  "Card No.",
                  style: globalTextStyle.copyWith(
                      color: tertiaryColor, fontSize: widget.width * 0.02),
                ),
                Padding(padding: EdgeInsets.only(top: widget.height * 0.025)),
                Container(
                  width: widget.width * 0.9,
                  height: widget.height * 0.1,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(color: tertiaryColor, width: 0.25),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: widget.width * 0.025,
                      right: widget.width * 0.025,
                      bottom: widget.height * 0.045,
                    ),
                    child: TextField(
                      controller: widget.cardNumController,
                      onChanged: widget.onChanged,
                      cursorColor: tertiaryColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: globalTextStyle.copyWith(
                          color: tertiaryColor, fontSize: widget.width * 0.025),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: widget.height * 0.03)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expiry Date (MM/YY)",
                          style: globalTextStyle.copyWith(
                              color: tertiaryColor,
                              fontSize: widget.width * 0.02),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: widget.height * 0.025)),
                        Container(
                          width: widget.width * 0.2,
                          height: widget.height * 0.1,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            border:
                                Border.all(color: tertiaryColor, width: 0.25),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.width * 0.025,
                              right: widget.width * 0.025,
                              bottom: widget.height * 0.045,
                            ),
                            child: TextField(
                              controller: widget.expiryDateController,
                              cursorColor: tertiaryColor,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: globalTextStyle.copyWith(
                                  color: tertiaryColor,
                                  fontSize: widget.width * 0.025),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: widget.height * 0.03)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CVV",
                          style: globalTextStyle.copyWith(
                              color: tertiaryColor,
                              fontSize: widget.width * 0.02),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: widget.height * 0.025)),
                        Container(
                          width: widget.width * 0.15,
                          height: widget.height * 0.1,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            border:
                                Border.all(color: tertiaryColor, width: 0.25),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.width * 0.025,
                              right: widget.width * 0.025,
                              bottom: widget.height * 0.045,
                            ),
                            child: TextField(
                              controller: widget.cvvController,
                              cursorColor: tertiaryColor,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: globalTextStyle.copyWith(
                                  color: tertiaryColor,
                                  fontSize: widget.width * 0.025),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: widget.height * 0.03)),
                      ],
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: widget.height * 0.02)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
