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

import '../lists/list_of_addresses.dart';
import '../lists/list_of_banks.dart';
import '../lists/list_of_cards.dart';
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

      Future<List> generateFutureCustomerCards() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('cards'));
      }

      void generateCustomerCards() async {
        myCards = await generateFutureCustomerCards();
      }

      generateCustomerCards();
      //myAddresses = customerAddresses;
      //customerCards = myCards;

      Future<List> generateFutureCustomerBanks() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('banks'));
      }

      void generateCustomerBanks() async {
        myBanks = await generateFutureCustomerBanks();
      }

      generateCustomerBanks();

      Future<List> generateFutureCustomerAddresses() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('addresses'));
      }

      void generateCustomerAddresses() async {
        myAddresses = await generateFutureCustomerAddresses();
      }

      generateCustomerAddresses();

      Future<List> generateFutureCustomerCurrentAddress() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('currAddress'));
      }

      void generateCustomerCurrentAddress() async {
        currentAddress = await generateFutureCustomerCurrentAddress();
      }

      generateCustomerCurrentAddress();

      Future<List> generateFutureCustomerOrderlist() async {
        return FirebaseFirestore.instance
            .collection('customers')
            .doc(currUser.uid)
            .get()
            .then((value) => value.get('orders'));
      }

      void generateCustomerOrderslist() async {
        ordersList = await generateFutureCustomerOrderlist();
      }

      generateCustomerOrderslist();
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
                            width: screenWidth * 0.17,
                            labelText: "New Arrivals",
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
                                        itemCount: 5,
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
                                                  i < wishList.length;
                                                  i++) {
                                                if (wishList[i]["iid"] ==
                                                    storedInstruments[index]
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
                                                        storedInstruments[index]
                                                            ["iid"]) {
                                                      wishList
                                                          .remove(wishList[i]);
                                                      break;
                                                    }
                                                  }
                                                  if (currUser != null) {
                                                    FirebaseFirestore.instance
                                                        .collection('customers')
                                                        .doc(currUser.uid)
                                                        .update(
                                                            {"wish": wishList});
                                                  }
                                                });
                                              } else {
                                                setState(() {
                                                  wishList.add(
                                                      storedInstruments[index]);

                                                  if (currUser != null) {
                                                    FirebaseFirestore.instance
                                                        .collection('customers')
                                                        .doc(currUser.uid)
                                                        .update(
                                                            {"wish": wishList});
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
                                                    storedInstruments[index]
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
                                                        storedInstruments[index]
                                                            ["iid"]) {
                                                      cartList.remove(
                                                          customerCartlist[i]);
                                                      cartMap.removeAt(i);
                                                      myCartValue =
                                                          computeCartValue();
                                                      // myCartValue =
                                                      //     customerCartValue;
                                                      break;
                                                    }
                                                  }

                                                  if (currUser != null) {
                                                    FirebaseFirestore.instance
                                                        .collection('customers')
                                                        .doc(currUser.uid)
                                                        .update(
                                                            {"cart": cartList});
                                                    FirebaseFirestore.instance
                                                        .collection('customers')
                                                        .doc(currUser.uid)
                                                        .update({
                                                      "cartMap": cartMap
                                                    });
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
                                                      storedInstruments[index]);

                                                  cartMap.add(1);

                                                  myCartValue =
                                                      computeCartValue();
                                                  // myCartValue =
                                                  //     customerCartValue;

                                                  if (currUser != null) {
                                                    FirebaseFirestore.instance
                                                        .collection('customers')
                                                        .doc(currUser.uid)
                                                        .update(
                                                            {"cart": cartList});

                                                    FirebaseFirestore.instance
                                                        .collection('customers')
                                                        .doc(currUser.uid)
                                                        .update({
                                                      "cartMap": cartMap
                                                    });

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
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    //shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InstrumentCard(
                                        width: screenWidth * 0.4,
                                        height: screenWidth * 0.4 / 0.75,
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
                                        instrumentDiscount:
                                            "${(((1 - (instruments[index]["price"] / instruments[index]["mrp"])) * 100).round()).toString()}% off",
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InstrumentDetail(
                                                          instrument:
                                                              instruments[
                                                                  index])));
                                        },
                                        onWishTap: () {
                                          bool check = false;
                                          for (int i = 0;
                                              i < wishList.length;
                                              i++) {
                                            if (wishList[i]["iid"] ==
                                                instruments[index]["iid"]) {
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
                                                    instruments[index]["iid"]) {
                                                  wishList.remove(wishList[i]);
                                                  break;
                                                }
                                              }
                                              if (currUser != null) {
                                                FirebaseFirestore.instance
                                                    .collection('customers')
                                                    .doc(currUser.uid)
                                                    .update({"wish": wishList});
                                              }
                                            });
                                          } else {
                                            setState(() {
                                              wishList.add(instruments[index]);

                                              if (currUser != null) {
                                                FirebaseFirestore.instance
                                                    .collection('customers')
                                                    .doc(currUser.uid)
                                                    .update({"wish": wishList});
                                              }
                                            });
                                          }
                                        },
                                        onCartTap: () {
                                          bool check = false;
                                          for (int i = 0;
                                              i < cartList.length;
                                              i++) {
                                            if (cartList[i]["iid"] ==
                                                instruments[index]["iid"]) {
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
                                                    instruments[index]["iid"]) {
                                                  cartList.remove(
                                                      customerCartlist[i]);
                                                  cartMap.removeAt(i);
                                                  myCartValue =
                                                      computeCartValue();
                                                  // myCartValue =
                                                  //     customerCartValue;
                                                  break;
                                                }
                                              }

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
                                              cartList.add(instruments[index]);

                                              cartMap.add(1);

                                              myCartValue = computeCartValue();
                                              // myCartValue =
                                              //     customerCartValue;

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
                            height: screenWidth * 0.4 / 0.75,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 5,
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
                                            instruments[index + 10]["img-url"],
                                        instrumentName: instruments[index + 10]
                                            ["name"],
                                        instrumentMrp: instruments[index + 10]
                                                ["mrp"]
                                            .toString(),
                                        instrumentPrice: instruments[index + 10]
                                                ["price"]
                                            .toString(),
                                        paddingRight: screenHeight * 0.015,
                                        innerHorizontalSymmetricPadding:
                                            screenWidth * 0.025,
                                        innerVerticalSymmetricPadding:
                                            screenHeight * 0.00,
                                        instrumentDiscount:
                                            "${(((1 - (instruments[index + 10]["price"] / instruments[index + 10]["mrp"])) * 100).round()).toString()}% off",
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InstrumentDetail(
                                                          instrument:
                                                              instruments[
                                                                  index +
                                                                      10])));
                                        },
                                        onWishTap: () {
                                          bool check = false;
                                          for (int i = 0;
                                              i < wishList.length;
                                              i++) {
                                            if (wishList[i]["iid"] ==
                                                instruments[index + 10]
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
                                                    instruments[index + 10]
                                                        ["iid"]) {
                                                  wishList.remove(wishList[i]);
                                                  break;
                                                }
                                              }
                                              if (currUser != null) {
                                                FirebaseFirestore.instance
                                                    .collection('customers')
                                                    .doc(currUser.uid)
                                                    .update({"wish": wishList});
                                              }
                                            });
                                          } else {
                                            setState(() {
                                              wishList
                                                  .add(instruments[index + 10]);

                                              if (currUser != null) {
                                                FirebaseFirestore.instance
                                                    .collection('customers')
                                                    .doc(currUser.uid)
                                                    .update({"wish": wishList});
                                              }
                                            });
                                          }
                                        },
                                        onCartTap: () {
                                          bool check = false;
                                          for (int i = 0;
                                              i < cartList.length;
                                              i++) {
                                            if (cartList[i]["iid"] ==
                                                instruments[index + 10]
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
                                                    instruments[index + 10]
                                                        ["iid"]) {
                                                  cartList.remove(
                                                      customerCartlist[i]);
                                                  cartMap.removeAt(i);
                                                  myCartValue =
                                                      computeCartValue();
                                                  // myCartValue =
                                                  //     customerCartValue;
                                                  break;
                                                }
                                              }

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
                                              cartList
                                                  .add(instruments[index + 10]);

                                              cartMap.add(1);

                                              myCartValue = computeCartValue();
                                              // myCartValue =
                                              //     customerCartValue;

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
                                                instruments[index + 10]))
                                            ? true
                                            : false,
                                        isCarted: (cartList.contains(
                                                instruments[index + 10]))
                                            ? true
                                            : false,
                                        instrument: instruments[index + 10],
                                      );
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
                        SizedBox(
                          height: screenHeight * 0.2,
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
