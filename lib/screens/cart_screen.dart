//import 'dart:ffi';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:musicart/lists/list_of_addresses.dart';
import 'package:musicart/screens/instrument_detail.dart';
import 'package:musicart/widgets/cart_card.dart';
import 'package:provider/provider.dart';

import '../global_variables/global_variables.dart';
import '../services/firebase_auth_methods.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//import 'package:intl/date_symbol_data_local.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
    //required this.mycartList,
  }) : super(key: key);

  //final List<Map<String, dynamic>> mycartList;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 1;
  int count = 0;

  List customerWishlist = [];
  List customerCartlist = [];
  List customerCartMap = [];
  double customerCartValue = 0;

  @override
  Widget build(BuildContext context) {
    final currUser = context.read<FirebaseAuthMethods>().user;

    if (currUser != null) {
      Future<List> generateFutureCustomerWishlist() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('wish'));
      }

      void generateCustomerWishList() async {
        wishList = await generateFutureCustomerWishlist();
      }

      generateCustomerWishList();
      customerWishlist = wishList;

      Future<List> generateFutureCustomerCartlist() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('cart'));
      }

      void generateCustomerCartList() async {
        cartList = await generateFutureCustomerCartlist();
      }

      generateCustomerCartList();
      customerCartlist = cartList;

      Future<List> generateFutureCustomerCartMap() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('cartMap'));
      }

      void generateCustomerCartMap() async {
        cartMap = await generateFutureCustomerCartMap();
      }

      generateCustomerCartMap();
      customerCartMap = cartMap;

      Future<double> generateFutureCustomerCartValue() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('cartValue'));
      }

      void generateCustomerCartValue() async {
        myCartValue = await generateFutureCustomerCartValue();
      }

      generateCustomerCartValue();
      customerCartValue = myCartValue;
    }

    double computeCartValue() {
      double cV = 0;
      for (int i = 0; i < cartList.length; i++) {
        cV = cV + (cartList[i]["price"] * cartMap[i]);
      }
      return cV;
    }

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
            // ElevatedButton(
            //   onPressed: () {
            //     print(currentAddress.length);
            //     print(currentAddress);
            //     print(myAddresses.length);
            //     print(myAddresses);
            //   },
            //   child: const Text("Test"),
            // ),
            (cartList.isEmpty)
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.2,
                        ),
                        child: Center(
                          child: Image.asset(
                            "./assets/images/empty_cart.png",
                            width: screenWidth * 0.33,
                            height: screenWidth * 0.33,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.02)),
                      Text(
                        "Nothing in the cart, browse our products and add them here.",
                        style: globalTextStyle.copyWith(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.025,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (currentAddress.isNotEmpty)
                          ? InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/select-address");
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: screenWidth * 0.04,
                                ),
                                child: Text(
                                  currentAddress[0]["addressLine1"],
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
                            Navigator.pushNamed(context, "/select-address");
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
                  ),
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
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
                                      "${cartMap[index].toString()} units",
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
                                    onRemoveTap: () async {
                                      setState(() {
                                        for (int i = 0;
                                            i < cartList.length;
                                            i++) {
                                          if (cartList[i]["iid"] ==
                                              cartList[index]["iid"]) {
                                            cartList.remove(cartList[i]);
                                            cartMap.removeAt(i);
                                            myCartValue = computeCartValue();
                                            //myCartValue = customerCartValue;
                                            break;
                                          }
                                        }
                                        // cartList = customerCartlist;
                                        // cartMap = customerCartMap;
                                        if (currUser != null) {
                                          FirebaseFirestore.instance
                                              .collection('customers')
                                              .doc(currUser.uid)
                                              .update({"cart": cartList});
                                          FirebaseFirestore.instance
                                              .collection('customers')
                                              .doc(currUser.uid)
                                              .update({"cartMap": cartMap});
                                          FirebaseFirestore.instance
                                              .collection('customers')
                                              .doc(currUser.uid)
                                              .update(
                                                  {"cartValue": myCartValue});
                                        }

                                        //cartMap.remove(cartList[index]);
                                        //cartList.remove(cartList[index]);
                                        count++;
                                      });
                                    },
                                    onMoveToWishlist: () {
                                      setState(() {
                                        bool check = false;
                                        for (int i = 0;
                                            i < wishList.length;
                                            i++) {
                                          if (wishList[i]["iid"] ==
                                              cartList[index]["iid"]) {
                                            check = true;
                                            break;
                                          }
                                        }
                                        if (!check) {
                                          wishList.add(cartList[index]);
                                          //wishList = customerWishlist;
                                          FirebaseFirestore.instance
                                              .collection('customers')
                                              .doc(currUser!.uid)
                                              .update({"wish": wishList});
                                          for (int i = 0;
                                              i < cartList.length;
                                              i++) {
                                            if (cartList[i]["iid"] ==
                                                cartList[index]["iid"]) {
                                              cartList.remove(cartList[i]);
                                              cartMap.removeAt(i);
                                              myCartValue = computeCartValue();
                                              //myCartValue = customerCartValue;
                                              break;
                                            }
                                          }
                                          // cartList = customerCartlist;
                                          // cartMap = customerCartMap;
                                          if (currUser != null) {
                                            FirebaseFirestore.instance
                                                .collection('customers')
                                                .doc(currUser.uid)
                                                .update({"cart": cartList});
                                            FirebaseFirestore.instance
                                                .collection('customers')
                                                .doc(currUser.uid)
                                                .update({"cartMap": cartMap});
                                            FirebaseFirestore.instance
                                                .collection('customers')
                                                .doc(currUser.uid)
                                                .update(
                                                    {"cartValue": myCartValue});
                                          }
                                        }
                                        // if (wishList
                                        //         .contains(cartList[index]) ==
                                        //     false) {
                                        //   wishList.add(cartList[index]);
                                        //   //cartMap.remove(cartList[index]);
                                        //   cartList.remove(cartList[index]);
                                        // }
                                        count++;
                                      });
                                    },
                                    onAddTap: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < cartList.length;
                                            i++) {
                                          if (cartList[i]["iid"] ==
                                              cartList[index]["iid"]) {
                                            cartMap[i]++;
                                          }
                                        }
                                        myCartValue = computeCartValue();
                                        //myCartValue = customerCartValue;
                                        //cartMap = customerCartMap;
                                        if (currUser != null) {
                                          FirebaseFirestore.instance
                                              .collection('customers')
                                              .doc(currUser.uid)
                                              .update({"cartMap": cartMap});
                                          FirebaseFirestore.instance
                                              .collection('customers')
                                              .doc(currUser.uid)
                                              .update(
                                                  {"cartValue": myCartValue});
                                        }
                                      });
                                    },
                                    onReduceTap: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < cartList.length;
                                            i++) {
                                          if (cartList[i]["iid"] ==
                                              cartList[index]["iid"]) {
                                            if (cartMap[i] > 1) {
                                              cartMap[i]--;
                                            }
                                          }
                                        }
                                        myCartValue = computeCartValue();
                                        //myCartValue = customerCartValue;
                                        //cartMap = customerCartMap;
                                        if (currUser != null) {
                                          FirebaseFirestore.instance
                                              .collection('customers')
                                              .doc(currUser.uid)
                                              .update({"cartMap": cartMap});
                                          FirebaseFirestore.instance
                                              .collection('customers')
                                              .doc(currUser.uid)
                                              .update(
                                                  {"cartValue": myCartValue});
                                        }
                                      });
                                    },
                                    width: screenWidth * 0.95,
                                    height: screenHeight,
                                    unitsBought: cartMap[index],
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
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.06),
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
