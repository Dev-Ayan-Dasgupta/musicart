import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';

class InstrumentCard extends StatefulWidget {
  const InstrumentCard({
    Key? key,
    required this.width,
    required this.height,
    required this.instrumentImageUrl,
    required this.instrumentName,
    required this.instrumentMrp,
    required this.instrumentPrice,
    required this.paddingRight,
    required this.innerHorizontalSymmetricPadding,
    required this.innerVerticalSymmetricPadding,
    required this.instrumentDiscount,
    required this.onTap,
    required this.onWishTap,
    required this.onCartTap,
    required this.isWishlisted,
    required this.isCarted,
    required this.instrument,
  }) : super(key: key);

  final double width;
  final double height;
  final String instrumentImageUrl;
  final String instrumentName;
  final String instrumentMrp;
  final String instrumentPrice;
  final double paddingRight;
  final double innerHorizontalSymmetricPadding;
  final double innerVerticalSymmetricPadding;
  final String instrumentDiscount;
  final VoidCallback onTap;
  final VoidCallback onWishTap;
  final VoidCallback onCartTap;
  final bool isWishlisted;
  final bool isCarted;
  final Map<String, dynamic> instrument;

  @override
  State<InstrumentCard> createState() => _InstrumentCardState();
}

class _InstrumentCardState extends State<InstrumentCard> {
  bool isWishlisted = false;
  bool isCarted = false;
  @override
  void initState() {
    super.initState();
    isWishlisted = widget.isWishlisted;
    isCarted = widget.isCarted;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(right: widget.paddingRight),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    width: widget.width,
                    height: widget.width * 0.89,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.instrumentImageUrl),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey, width: 0.015),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: widget.height * 0.075,
                    child: Container(
                      width: widget.width * 0.25,
                      height: widget.height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: widget.width * 0.04,
                          top: widget.height * 0.016,
                        ),
                        child: Text(
                          widget.instrumentDiscount,
                          style: globalTextStyle.copyWith(
                            color: Colors.white70,
                            fontSize: widget.width * 0.05,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.innerHorizontalSymmetricPadding,
                  vertical: 4.5,
                ),
                child: Text(
                  widget.instrumentName,
                  style: globalTextStyle.copyWith(
                      color: Colors.black87,
                      fontSize: widget.width * 0.08,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: widget.width * 0.07)),
                  Text(
                    widget.instrumentPrice,
                    style: globalTextStyle.copyWith(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.width * 0.07,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: widget.width * 0.07)),
                  Text(
                    widget.instrumentMrp,
                    style: globalTextStyle.copyWith(
                      color: Colors.grey,
                      fontSize: widget.width * 0.06,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: widget.height * 0.025)),
              SizedBox(
                width: widget.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: (widget.width / 2) - 1,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.2),
                          right: BorderSide(color: Colors.grey, width: 0.2),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isWishlisted = !isWishlisted;
                          });
                          widget.onWishTap();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: widget.height * 0.0125),
                          child: (wishList.contains(widget.instrument))
                              ? Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red.shade900,
                                  size: widget.width * 0.1,
                                )
                              : Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.black87,
                                  size: widget.width * 0.1,
                                ),
                        ),
                      ),
                    ),
                    Container(
                      width: (widget.width / 2) - 1,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.2),
                          // right: BorderSide(color: Colors.grey, width: 0.2),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isCarted = !isCarted;
                          });
                          widget.onCartTap();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: widget.height * 0.0125),
                          child: (cartList.contains(widget.instrument))
                              ? Icon(
                                  Icons.shopping_cart_rounded,
                                  color: Colors.blue.shade900,
                                  size: widget.width * 0.1,
                                )
                              : Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black87,
                                  size: widget.width * 0.1,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
