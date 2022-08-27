import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../global_variables/global_variables.dart';
import '../services/firebase_auth_methods.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/instrument_card.dart';
import 'instrument_detail.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({
    Key? key,
    //required this.mywishList,
  }) : super(key: key);

  //final Map<String, dynamic> mywishList;

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              searchBoxController: _searchBoxController,
              hintText: _hintText,
            ),
            (wishList.isEmpty)
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.2,
                        ),
                        child: Center(
                          child: Image.asset(
                            "./assets/images/empty_wishlist.png",
                            width: screenWidth * 0.33,
                            height: screenWidth * 0.33,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.02)),
                      Text(
                        "Nothing in wishlist, browse our products and add them here.",
                        style: globalTextStyle.copyWith(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.025,
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.all(screenHeight * 0.015),
                    child: Text(
                      "Hey user, this is your wishlist...",
                      style: globalTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                child: Column(
                  children: [
                    Expanded(
                      child: AnimationLimiter(
                        key: ValueKey("list $count"),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: screenWidth * 0.025,
                          mainAxisSpacing: screenWidth * 0.025,
                          childAspectRatio: 0.75,
                          children: List.generate(wishList.length, (index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                    child: InstrumentCard(
                                        width: (screenWidth * 0.46),
                                        height: (screenWidth * 0.46) / 0.75,
                                        instrumentImageUrl: wishList[index]
                                            ["img-url"],
                                        instrumentName: wishList[index]["name"],
                                        instrumentMrp:
                                            "₹${wishList[index]["mrp"].toString()}",
                                        instrumentPrice:
                                            "₹${wishList[index]["price"].toString()}",
                                        paddingRight: 0,
                                        innerHorizontalSymmetricPadding: 10,
                                        innerVerticalSymmetricPadding: 0,
                                        instrumentDiscount:
                                            "${(((1 - (wishList[index]["price"] / wishList[index]["mrp"])) * 100).round()).toString()}% off",
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InstrumentDetail(
                                                          instrument: wishList[
                                                              index])));
                                        },
                                        onWishTap: () async {
                                          setState(() {
                                            for (int i = 0;
                                                i < wishList.length;
                                                i++) {
                                              if (wishList[i]["iid"] ==
                                                  wishList[index]["iid"]) {
                                                wishList.remove(wishList[i]);
                                                break;
                                              }
                                            }
                                            //wishList = customerWishlist;
                                            //wishList.remove(wishList[index]);
                                            if (currUser != null) {
                                              FirebaseFirestore.instance
                                                  .collection('customers')
                                                  .doc(currUser.uid)
                                                  .update({"wish": wishList});
                                            }

                                            count++;
                                          });
                                        },
                                        onCartTap: () async {
                                          bool check = false;
                                          for (int i = 0;
                                              i < cartList.length;
                                              i++) {
                                            if (cartList[i]["iid"] ==
                                                wishList[index]["iid"]) {
                                              check = true;
                                              break;
                                            }
                                          }
                                          if (check) {
                                            setState(() {
                                              for (int i = 0;
                                                  i < cartList.length;
                                                  i++) {
                                                if (cartList[i]["iid"] ==
                                                    wishList[index]["iid"]) {
                                                  cartList.remove(cartList[i]);
                                                  cartMap.removeAt(i);
                                                  myCartValue =
                                                      computeCartValue();
                                                  // myCartValue =
                                                  //     customerCartValue;
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
                                                    .update(
                                                        {"cartMap": cartMap});
                                                FirebaseFirestore.instance
                                                    .collection('customers')
                                                    .doc(currUser.uid)
                                                    .update({
                                                  "cartValue": myCartValue
                                                });
                                              }

                                              count++;
                                            });
                                          } else {
                                            setState(() {
                                              cartList.add(wishList[index]);
                                              cartMap.add(1);
                                              myCartValue = computeCartValue();
                                              // myCartValue = customerCartValue;
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
                                                    .update(
                                                        {"cartMap": cartMap});
                                                FirebaseFirestore.instance
                                                    .collection('customers')
                                                    .doc(currUser.uid)
                                                    .update({
                                                  "cartValue": myCartValue
                                                });
                                              }

                                              count++;
                                            });
                                          }
                                        },
                                        isWishlisted:
                                            (wishList.contains(wishList[index]))
                                                ? true
                                                : false,
                                        isCarted:
                                            (cartList.contains(wishList[index]))
                                                ? true
                                                : false,
                                        instrument: wishList[index])),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.025)),
                  ],
                ),
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
