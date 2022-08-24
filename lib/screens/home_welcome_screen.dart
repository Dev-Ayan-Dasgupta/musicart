import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicart/screens/instrument_detail.dart';
import 'package:musicart/screens/wishlist_screen.dart';
import 'package:musicart/widgets/animated_bottom_bar.dart';
import 'package:musicart/widgets/brand_logo_card.dart';
import 'package:musicart/widgets/instrument_card.dart';

import 'package:musicart/widgets/text_label.dart';
import 'package:provider/provider.dart';

import '../global_variables/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../services/firebase_auth_methods.dart';
import '../widgets/custom_appbar.dart';

class HomeWelcomeScreen extends StatefulWidget {
  const HomeWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeWelcomeScreen> createState() => _HomeWelcomeScreenState();
}

class _HomeWelcomeScreenState extends State<HomeWelcomeScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 0;
  int _currentCarouselIndex = 0;

  final Stream<QuerySnapshot> instrumentsStream =
      FirebaseFirestore.instance.collection("instrument").snapshots();

  final List storedInstruments = [];
  List customerWishlist = [];
  List customerCartlist = [];
  List customerCartMap = [];
  double customerCartValue = 0;

  @override
  Widget build(BuildContext context) {
    final currUser = context.read<FirebaseAuthMethods>().user;

    Future<List> generateFutureCustomerWishlist() async {
      return FirebaseFirestore.instance
          .collection('customers')
          .doc(currUser!.uid)
          .get()
          .then((value) => value.get('wish'));
    }

    void generateCustomerWishList() async {
      customerWishlist = await generateFutureCustomerWishlist();
    }

    generateCustomerWishList();
    wishList = customerWishlist;

    Future<List> generateFutureCustomerCartlist() async {
      return FirebaseFirestore.instance
          .collection('customers')
          .doc(currUser!.uid)
          .get()
          .then((value) => value.get('cart'));
    }

    void generateCustomerCartList() async {
      customerCartlist = await generateFutureCustomerCartlist();
    }

    generateCustomerCartList();
    cartList = customerCartlist;

    Future<List> generateFutureCustomerCartMap() async {
      return FirebaseFirestore.instance
          .collection('customers')
          .doc(currUser!.uid)
          .get()
          .then((value) => value.get('cartMap'));
    }

    void generateCustomerCartMap() async {
      customerCartMap = await generateFutureCustomerCartMap();
    }

    generateCustomerCartMap();
    cartMap = customerCartMap;

    Future<double> generateFutureCustomerCartValue() async {
      return FirebaseFirestore.instance
          .collection('customers')
          .doc(currUser!.uid)
          .get()
          .then((value) => value.get('cartValue'));
    }

    void generateCustomerCartValue() async {
      customerCartValue = await generateFutureCustomerCartValue();
    }

    generateCustomerCartValue();
    myCartValue = customerCartValue;

    double computeCartValue() {
      double cV = 0;
      for (int i = 0; i < customerCartlist.length; i++) {
        cV = cV + (customerCartlist[i]["price"] * customerCartMap[i]);
      }
      return cV;
    }

    // customerCartValue = computeCartValue();
    // myCartValue = customerCartValue;

    // FirebaseFirestore.instance
    //     .collection('customers')
    //     .doc(currUser!.uid)
    //     .update({"cartValue": customerCartValue});

    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    List<Widget> indicators(imagesLength, currentIndex) {
      return List<Widget>.generate(imagesLength, (index) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01,
            horizontal: 2,
          ),
          width: currentIndex == index ? 15 : 10,
          height: 3,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black87 : Colors.grey,
            borderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
          ),
        );
      });
    }

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
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        CarouselSlider(
                          items: carouselImageList.map<Widget>((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: screenWidth * 0.95,
                                  decoration: BoxDecoration(
                                    image:
                                        DecorationImage(image: NetworkImage(i)),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                              height: screenHeight * 0.25,
                              aspectRatio: 16 / 9,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              initialPage: 0,
                              viewportFraction: 1,
                              onPageChanged: (index, timed) {
                                setState(() {
                                  _currentCarouselIndex = index;
                                });
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: indicators(
                              carouselImageList.length, _currentCarouselIndex),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.025,
                            top: screenHeight * 0.005,
                          ),
                          child: TextLabel(
                            width: screenWidth * 0.15,
                            labelText: "Top Brands",
                            fontSize: screenWidth * 0.0225,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.025,
                              top: screenWidth * 0.025),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: SizedBox(
                            height: screenHeight * 0.1,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: brandLogos.length,
                                    scrollDirection: Axis.horizontal,
                                    //shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return BrandLogoCard(
                                          width: screenWidth * 0.33,
                                          height: screenHeight * 0.18,
                                          brandImageUrl: brandLogos[index]
                                              ["img-url"],
                                          paddingRight: screenWidth * 0.015);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.025,
                              top: screenWidth * 0.025),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.025,
                          ),
                          child: TextLabel(
                            width: screenWidth * 0.2,
                            labelText: "Trending Guitars",
                            fontSize: screenWidth * 0.0225,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.025,
                              top: screenWidth * 0.025),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: SizedBox(
                            height: screenWidth * 0.4 / 0.75,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: instrumentsStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  print("Someting went wrong");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                storedInstruments.clear();
                                snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map a =
                                      document.data() as Map<String, dynamic>;
                                  storedInstruments.add(a);
                                }).toList();

                                return Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: storedInstruments.length,
                                        scrollDirection: Axis.horizontal,
                                        //shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InstrumentCard(
                                            width: screenWidth * 0.4,
                                            height: screenWidth * 0.4 / 0.75,
                                            instrumentImageUrl:
                                                storedInstruments[index]
                                                    ["img-url"],
                                            instrumentName:
                                                storedInstruments[index]
                                                    ["name"],
                                            instrumentMrp:
                                                "₹${storedInstruments[index]["mrp"].toString()}",
                                            instrumentPrice:
                                                "₹${storedInstruments[index]["price"].toString()}",
                                            paddingRight: screenHeight * 0.015,
                                            innerHorizontalSymmetricPadding:
                                                screenWidth * 0.025,
                                            innerVerticalSymmetricPadding:
                                                screenHeight * 0.00,
                                            instrumentDiscount:
                                                "${(((1 - (storedInstruments[index]["price"] / storedInstruments[index]["mrp"])) * 100).round()).toString()}% off",
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          InstrumentDetail(
                                                              instrument:
                                                                  storedInstruments[
                                                                      index])));
                                            },
                                            onWishTap: () async {
                                              bool check = false;
                                              for (int i = 0;
                                                  i < customerWishlist.length;
                                                  i++) {
                                                if (customerWishlist[i]
                                                        ["iid"] ==
                                                    storedInstruments[index]
                                                        ["iid"]) {
                                                  check = true;
                                                  break;
                                                }
                                              }

                                              if (check) {
                                                setState(() {
                                                  for (int i = 0;
                                                      i <
                                                          customerWishlist
                                                              .length;
                                                      i++) {
                                                    if (customerWishlist[i]
                                                            ["iid"] ==
                                                        storedInstruments[index]
                                                            ["iid"]) {
                                                      customerWishlist.remove(
                                                          customerWishlist[i]);
                                                      break;
                                                    }
                                                  }

                                                  FirebaseFirestore.instance
                                                      .collection('customers')
                                                      .doc(currUser!.uid)
                                                      .update({
                                                    "wish": customerWishlist
                                                  });
                                                });
                                              } else {
                                                setState(() {
                                                  customerWishlist.add(
                                                      storedInstruments[index]);

                                                  FirebaseFirestore.instance
                                                      .collection('customers')
                                                      .doc(currUser!.uid)
                                                      .update({
                                                    "wish": customerWishlist
                                                  });
                                                });
                                              }
                                            },
                                            onCartTap: () async {
                                              bool check = false;
                                              for (int i = 0;
                                                  i < customerCartlist.length;
                                                  i++) {
                                                if (customerCartlist[i]
                                                        ["iid"] ==
                                                    storedInstruments[index]
                                                        ["iid"]) {
                                                  check = true;
                                                  break;
                                                }
                                              }

                                              if (check) {
                                                setState(() {
                                                  for (int i = 0;
                                                      i <
                                                          customerCartlist
                                                              .length;
                                                      i++) {
                                                    if (customerCartlist[i]
                                                            ["iid"] ==
                                                        storedInstruments[index]
                                                            ["iid"]) {
                                                      customerCartlist.remove(
                                                          customerCartlist[i]);
                                                      customerCartMap
                                                          .removeAt(i);
                                                      customerCartValue =
                                                          computeCartValue();
                                                      myCartValue =
                                                          customerCartValue;
                                                      break;
                                                    }
                                                  }

                                                  FirebaseFirestore.instance
                                                      .collection('customers')
                                                      .doc(currUser!.uid)
                                                      .update({
                                                    "cart": customerCartlist
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('customers')
                                                      .doc(currUser.uid)
                                                      .update({
                                                    "cartMap": customerCartMap
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('customers')
                                                      .doc(currUser.uid)
                                                      .update({
                                                    "cartValue":
                                                        customerCartValue
                                                  });
                                                });
                                              } else {
                                                setState(() {
                                                  customerCartlist.add(
                                                      storedInstruments[index]);

                                                  customerCartMap.add(1);

                                                  customerCartValue =
                                                      computeCartValue();
                                                  myCartValue =
                                                      customerCartValue;

                                                  FirebaseFirestore.instance
                                                      .collection('customers')
                                                      .doc(currUser!.uid)
                                                      .update({
                                                    "cart": customerCartlist
                                                  });

                                                  FirebaseFirestore.instance
                                                      .collection('customers')
                                                      .doc(currUser.uid)
                                                      .update({
                                                    "cartMap": customerCartMap
                                                  });

                                                  FirebaseFirestore.instance
                                                      .collection('customers')
                                                      .doc(currUser.uid)
                                                      .update({
                                                    "cartValue":
                                                        customerCartValue
                                                  });
                                                });
                                              }
                                            },
                                            isWishlisted: (wishList.contains(
                                                    instruments[index]))
                                                ? true
                                                : false,
                                            isCarted: (cartList.contains(
                                                    instruments[index]))
                                                ? true
                                                : false,
                                            instrument:
                                                storedInstruments[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.025,
                              top: screenWidth * 0.025),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.025,
                          ),
                          child: TextLabel(
                            width: screenWidth * 0.20,
                            labelText: "Trending Drums",
                            fontSize: screenWidth * 0.0225,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.025,
                              top: screenWidth * 0.025),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: SizedBox(
                            height: screenHeight * 0.4,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: instruments.length,
                                    scrollDirection: Axis.horizontal,
                                    //shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InstrumentCard(
                                        width: screenWidth * 0.4,
                                        height: screenHeight * 0.4,
                                        instrumentImageUrl: instruments[index]
                                            ["img-url"],
                                        instrumentName: instruments[index]
                                            ["name"],
                                        instrumentMrp: instruments[index]["mrp"]
                                            .toString(),
                                        instrumentPrice: instruments[index]
                                                ["price"]
                                            .toString(),
                                        paddingRight: screenHeight * 0.015,
                                        innerHorizontalSymmetricPadding:
                                            screenWidth * 0.025,
                                        innerVerticalSymmetricPadding:
                                            screenHeight * 0.00,
                                        instrumentDiscount: "Hello",
                                        onTap: () {},
                                        onWishTap: () {},
                                        onCartTap: () {},
                                        isWishlisted: (wishList
                                                .contains(instruments[index]))
                                            ? true
                                            : false,
                                        isCarted: (cartList
                                                .contains(instruments[index]))
                                            ? true
                                            : false,
                                        instrument: instruments[index],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
