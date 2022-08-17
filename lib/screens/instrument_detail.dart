import 'package:flutter/material.dart';
import 'package:musicart/widgets/flip_counter.dart';

import '../global_variables/global_variables.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';

class InstrumentDetail extends StatefulWidget {
  const InstrumentDetail({
    Key? key,
    required this.instrument,
  }) : super(key: key);

  final Map<String, dynamic> instrument;

  @override
  State<InstrumentDetail> createState() => _InstrumentDetailState();
}

class _InstrumentDetailState extends State<InstrumentDetail> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 1;

  bool isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    bool isWishlisted = wishList.contains(widget.instrument);
    bool isCarted = cartList.contains(widget.instrument);
    int unitsCarted =
        cartList.contains(widget.instrument) ? cartMap[widget.instrument]! : 0;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                searchBoxController: _searchBoxController,
                hintText: _hintText),
            Container(
              width: screenWidth * 0.95,
              height: screenHeight * 0.6525,
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
                children: [
                  Stack(
                    children: [
                      Container(
                        width: screenWidth * 0.95,
                        height: screenHeight * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.instrument["img-url"]),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.grey, width: 0.015),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.95,
                        height: screenHeight * 0.5,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black26,
                              Colors.black12,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.03,
                        right: screenWidth * 0.055,
                        child: Stack(
                          children: [
                            Container(
                              width: screenWidth * 0.09,
                              height: screenWidth * 0.09,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white38,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share_rounded,
                                size: screenWidth * 0.055,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenWidth * 0.025,
                        left: screenWidth * 0.025,
                        right: screenWidth * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.instrument["name"],
                          style: globalTextStyle.copyWith(
                            color: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rated ${widget.instrument["rating"]}/5 on ${widget.instrument["reviews"]} reviews",
                          style: globalTextStyle.copyWith(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005,
                          horizontal: screenWidth * 0.025)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        child: RichText(
                          text: TextSpan(
                              text: "₹${widget.instrument["price"].toString()}",
                              style: globalTextStyle.copyWith(
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "\t\t ₹${widget.instrument["mrp"].toString()}",
                                  style: globalTextStyle.copyWith(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        child: FlipCounter(
                          count: unitsCarted,
                          onAdd: () {
                            setState(() {
                              unitsCarted++;
                              if (cartList.contains(widget.instrument) ==
                                  false) {
                                cartList.add(widget.instrument);
                                cartMap.addAll({widget.instrument: 1});
                                isCarted = !isCarted;
                              } else {
                                cartMap.update(
                                    widget.instrument, (value) => unitsCarted);
                              }
                              isButtonClicked = true;
                            });
                          },
                          onRemove: () {
                            setState(() {
                              if (unitsCarted > 0) {
                                unitsCarted--;
                                if (unitsCarted == 0) {
                                  cartList.remove(widget.instrument);
                                  cartMap.remove(widget.instrument);
                                  isCarted = !isCarted;
                                } else {
                                  cartMap.update(widget.instrument,
                                      (value) => unitsCarted);
                                }
                              }
                              isButtonClicked = true;
                            });
                          },
                          value: unitsCarted.toDouble(),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.025)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: (screenWidth * 0.95 / 2) - 1,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.2),
                            right: BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              (isWishlisted)
                                  ? wishList.remove(widget.instrument)
                                  : wishList.add(widget.instrument);
                              isWishlisted = !isWishlisted;
                            });
                            // widget.onWishTap();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.5 * 0.0125),
                            child: (isWishlisted)
                                ? Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.red.shade900,
                                  )
                                : const Icon(
                                    Icons.favorite_border_rounded,
                                    color: Colors.black87,
                                  ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.95 / 2,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.2),
                            right: BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              // (cartList.contains(widget.instrument))
                              //     ? cartList.remove(widget.instrument)
                              //     : cartList.add(widget.instrument);
                              if (cartList.contains(widget.instrument)) {
                                cartList.remove(widget.instrument);
                                cartMap.remove(widget.instrument);
                                unitsCarted = 0;
                              } else {
                                cartList.add(widget.instrument);
                                cartMap.addAll({widget.instrument: 1});
                                unitsCarted = 1;
                              }
                              isCarted = !isCarted;
                            });
                            // widget.onCartTap();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.5 * 0.0125),
                            child: (isCarted)
                                ? Icon(Icons.shopping_cart_rounded,
                                    color: Colors.blue.shade900)
                                : const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.black87,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.025, vertical: screenHeight * 0.015),
          child: CustomAnimatedBottomBar(
            containerHeight: screenHeight * 0.06,
            backgroundColor: Colors.black87,
            selectedIndex: _currentIndex,
            showElevation: true,
            itemCornerRadius: 10,
            curve: Curves.easeIn,
            items: navBarItems,
            onItemSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
