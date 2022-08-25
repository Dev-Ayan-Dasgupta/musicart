import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:musicart/models/card_object.dart';
import 'package:musicart/widgets/make_card_payment_widget.dart';

import '../global_variables/global_variables.dart';
import '../lists/list_of_addresses.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';

class MakeCardPaymentScreen extends StatefulWidget {
  const MakeCardPaymentScreen({
    Key? key,
    required this.myCard,
  }) : super(key: key);
  final Map myCard;

  @override
  State<MakeCardPaymentScreen> createState() => _MakeCardPaymentScreenState();
}

class _MakeCardPaymentScreenState extends State<MakeCardPaymentScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  final TextEditingController _cvvController = TextEditingController();
  int _currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              searchBoxController: _searchBoxController,
              hintText: _hintText,
            ),
            (cartList.isNotEmpty)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (currentAddress != null)
                          ? InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/select-address");
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: screenWidth * 0.04,
                                ),
                                child: Text(
                                  currentAddress!.addressLine1,
                                  style: globalTextStyle.copyWith(
                                      color: primaryColor,
                                      fontSize: screenWidth * 0.015),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: screenWidth * 0.04,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/payments");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.05,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Checkout    ₹",
                                      style: globalTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 3)),
                                    AnimatedFlipCounter(
                                      value: myCartValue,
                                      textStyle: globalTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: screenHeight * 0.4 / 2)),
                Center(
                  child: MakeCardPayment(
                    width: screenWidth * 0.95,
                    height: screenWidth * 0.95 * 0.618,
                    cardProviderImgUrl: widget.myCard["providerImgUrl"],
                    ownerName: widget.myCard["ownerName"],
                    cardNumber: widget.myCard["cardNum"],
                    expiryMonth: widget.myCard["monthOfExpiry"],
                    expiryDay: widget.myCard["dayofExpiry"],
                    cvvController: _cvvController,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: screenWidth * 0.025)),
                SizedBox(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.05,
                  child: ElevatedButton(
                    onPressed: () {
                      ordersList.add(cartList.toList());
                      //ordersDate[cartList.toList()] = 10;
                      orderDate.add(OrderDate(
                          order: cartList.toList(), date: DateTime.now()));
                      //ordersMap.add(Map.of(cartMap));
                      cartList.clear();
                      cartMap.clear();
                      Navigator.pushNamed(context, "/orders-history");
                    },
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(
                      "Pay     ₹$myCartValue",
                      style: globalTextStyle.copyWith(
                        color: tertiaryColor,
                        fontSize: screenWidth * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
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
