import 'package:flutter/material.dart';

import '../global_variables/global_variables.dart';

class MakeCardPayment extends StatefulWidget {
  const MakeCardPayment({
    Key? key,
    required this.width,
    required this.height,
    required this.cardProviderImgUrl,
    required this.ownerName,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryDay,
    required this.cvvController,
  }) : super(key: key);
  final double width;
  final double height;
  final String cardProviderImgUrl;
  final String ownerName;
  final String cardNumber;
  final String expiryMonth;
  final String expiryDay;
  final TextEditingController cvvController;

  @override
  State<MakeCardPayment> createState() => _MakeCardPaymentState();
}

class _MakeCardPaymentState extends State<MakeCardPayment> {
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
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: widget.width * 0.025,
                      right: widget.width * 0.025,
                      bottom: widget.height * 0.045,
                    ),
                    child: Text(
                      widget.ownerName.toUpperCase(),
                      style: globalTextStyle.copyWith(
                        color: tertiaryColor,
                        fontSize: widget.width * 0.03,
                      ),
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
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: widget.width * 0.025,
                      right: widget.width * 0.025,
                      bottom: widget.height * 0.045,
                    ),
                    child: Text(
                      widget.cardNumber,
                      style: globalTextStyle.copyWith(
                        color: tertiaryColor,
                        fontSize: widget.width * 0.03,
                      ),
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
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.width * 0.025,
                              right: widget.width * 0.025,
                              bottom: widget.height * 0.045,
                            ),
                            child: Text(
                              "${widget.expiryMonth}/${widget.expiryDay}",
                              style: globalTextStyle.copyWith(
                                color: tertiaryColor,
                                fontSize: widget.width * 0.03,
                              ),
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
                              keyboardType: TextInputType.number,
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
