import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:musicart/screens/instrument_detail.dart';
import 'package:musicart/widgets/cart_card.dart';

import '../global_variables/global_variables.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/date_symbol_data_local.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.mycartList}) : super(key: key);

  final List<Map<String, dynamic>> mycartList;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 1;
  int count = 0;

  double computeCartValue(double cV) {
    for (int i = 0; i < cartList.length; i++) {
      cV = cV + (cartList[i]["price"] * cartMap[cartList[i]]);
    }
    return cV;
  }

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    myCartValue = computeCartValue(cartValue);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              searchBoxController: _searchBoxController,
              hintText: _hintText),
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.015),
            child: Text(
              "Hey user, this is your cart...",
              style: globalTextStyle.copyWith(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "₹",
                  style: globalTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 3)),
                AnimatedFlipCounter(
                  value: myCartValue,
                  textStyle: globalTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.8,
            child: Column(
              children: [
                Expanded(
                  child: AnimationLimiter(
                    key: ValueKey("list $count"),
                    child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: CartCard(
                                  leading: Image(
                                      image: NetworkImage(
                                          cartList[index]["img-url"])),
                                  title: Text(
                                    cartList[index]["name"],
                                    style: globalTextStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "${cartMap[cartList[index]].toString()} units",
                                    style: globalTextStyle.copyWith(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    "₹${cartList[index]["price"].toString()}",
                                    style: globalTextStyle.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onCardTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InstrumentDetail(
                                                    instrument:
                                                        cartList[index])));
                                  },
                                  onRemoveTap: () {
                                    setState(() {
                                      cartMap.remove(cartList[index]);
                                      cartList.remove(cartList[index]);
                                      count++;
                                    });
                                  },
                                  onMoveToWishlist: () {
                                    setState(() {
                                      if (wishList.contains(cartList[index]) ==
                                          false) {
                                        wishList.add(cartList[index]);
                                        cartMap.remove(cartList[index]);
                                        cartList.remove(cartList[index]);
                                      }
                                      count++;
                                    });
                                  },
                                  onAddTap: () {
                                    setState(() {
                                      cartMap.update(
                                          cartList[index],
                                          (value) =>
                                              cartMap[cartList[index]]! + 1);
                                      count++;
                                    });
                                  },
                                  onReduceTap: () {
                                    setState(() {
                                      if (cartMap[cartList[index]]! > 1) {
                                        cartMap.update(
                                            cartList[index],
                                            (value) =>
                                                cartMap[cartList[index]]! - 1);
                                      }
                                      // else {
                                      //   cartMap.remove(cartList[index]);
                                      //   cartList.remove(cartList[index]);
                                      // }
                                      count++;
                                    });
                                  },
                                  width: screenWidth * 0.95,
                                  height: screenHeight,
                                  unitsBought: cartMap[cartList[index]]!,
                                  instrument: cartList[index],
                                  delDate: DateFormat.yMMMMEEEEd().format(
                                    DateTime.now().add(
                                      Duration(
                                          days: cartList[index]["del-days"]),
                                    ) as DateTime,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.06),
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
          containerHeight: 56,
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
    );
  }
}
