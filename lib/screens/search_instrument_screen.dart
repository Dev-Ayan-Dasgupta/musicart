import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../global_variables/global_variables.dart';
import '../services/firebase_auth_methods.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/instrument_card.dart';
import 'instrument_detail.dart';

class SearchInstrumentScreen extends StatefulWidget {
  const SearchInstrumentScreen({Key? key}) : super(key: key);

  @override
  State<SearchInstrumentScreen> createState() => _SearchInstrumentScreenState();
}

class _SearchInstrumentScreenState extends State<SearchInstrumentScreen> {
  int _currentIndex = 1;
  TextEditingController _searchInstrumentController = TextEditingController();

  String searchInstrument = "";
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
            ),
            Center(
              child: Container(
                width: screenWidth * 0.95,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.25),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.grey,
                        size: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.84,
                      height: screenHeight * 0.05,
                      child: TextField(
                        controller: _searchInstrumentController,
                        cursorColor: Colors.grey,
                        autofocus: true,
                        onChanged: (p0) {
                          setState(() {
                            searchInstrument = p0;
                            populateSearchedInstruments(searchInstrument);
                            if (searchInstrument == "") {
                              searchedInstruments.clear();
                            }
                            count++;
                          });
                        },
                        style: globalTextStyle.copyWith(
                            color: Colors.grey, fontSize: screenWidth * 0.025),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "Search for instruments, products or brands...",
                          hintStyle: globalTextStyle.copyWith(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.025),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                searchInstrument = "";
                                _searchInstrumentController.text = "";
                                searchedInstruments.clear();
                                count++;
                              });
                            },
                            icon: Icon(
                              Icons.close_rounded,
                              size: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
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
                          children: List.generate(searchedInstruments.length,
                              (index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                    child: InstrumentCard(
                                        width: (screenWidth * 0.46),
                                        height: (screenWidth * 0.46) / 0.75,
                                        instrumentImageUrl:
                                            searchedInstruments[index]
                                                ["img-url"],
                                        instrumentName:
                                            searchedInstruments[index]["name"],
                                        instrumentMrp:
                                            "₹${searchedInstruments[index]["mrp"].toString()}",
                                        instrumentPrice:
                                            "₹${searchedInstruments[index]["price"].toString()}",
                                        paddingRight: 0,
                                        innerHorizontalSymmetricPadding: 10,
                                        innerVerticalSymmetricPadding: 0,
                                        instrumentDiscount:
                                            "${(((1 - (searchedInstruments[index]["price"] / searchedInstruments[index]["mrp"])) * 100).round()).toString()}% off",
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InstrumentDetail(
                                                          instrument:
                                                              searchedInstruments[
                                                                  index])));
                                        },
                                        onWishTap: () async {
                                          bool check = false;

                                          for (int i = 0;
                                              i < wishList.length;
                                              i++) {
                                            if (wishList[i]["iid"] ==
                                                searchedInstruments[index]
                                                    ["iid"]) {
                                              check = true;
                                              break;
                                            }
                                          }

                                          if (check) {
                                            setState(() {
                                              for (int i = 0;
                                                  i < wishList.length;
                                                  i++) {
                                                if (wishList[i]["iid"] ==
                                                    searchedInstruments[index]
                                                        ["iid"]) {
                                                  wishList.remove(wishList[i]);
                                                  break;
                                                }
                                              }

                                              //wishList = customerWishlist;

                                              if (currUser != null) {
                                                FirebaseFirestore.instance
                                                    .collection('customers')
                                                    .doc(currUser.uid)
                                                    .update({"wish": wishList});
                                              }
                                            });
                                          } else {
                                            setState(() {
                                              wishList.add(
                                                  searchedInstruments[index]);

                                              //wishList = customerWishlist;

                                              if (currUser != null) {
                                                FirebaseFirestore.instance
                                                    .collection('customers')
                                                    .doc(currUser.uid)
                                                    .update({"wish": wishList});
                                              }
                                            });
                                          }
                                        },
                                        onCartTap: () async {
                                          bool check = false;
                                          for (int i = 0;
                                              i < cartList.length;
                                              i++) {
                                            if (cartList[i]["iid"] ==
                                                searchedInstruments[index]
                                                    ["iid"]) {
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
                                                    searchedInstruments[index]
                                                        ["iid"]) {
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
                                            });
                                          } else {
                                            setState(() {
                                              cartList.add(
                                                  searchedInstruments[index]);
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
                                            });
                                          }
                                        },
                                        isWishlisted: (wishList.contains(
                                                searchedInstruments[index]))
                                            ? true
                                            : false,
                                        isCarted: (cartList.contains(
                                                searchedInstruments[index]))
                                            ? true
                                            : false,
                                        instrument:
                                            searchedInstruments[index])),
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
