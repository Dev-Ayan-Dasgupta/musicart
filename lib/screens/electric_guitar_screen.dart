import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:musicart/widgets/text_label.dart';
import 'package:provider/provider.dart';

import '../global_variables/global_variables.dart';
import '../services/firebase_auth_methods.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_radio_button.dart';
import '../widgets/instrument_card.dart';
import 'instrument_detail.dart';

class ElectricGuitarsScreen extends StatefulWidget {
  const ElectricGuitarsScreen({Key? key}) : super(key: key);

  @override
  State<ElectricGuitarsScreen> createState() => _ElectricGuitarsScreenState();
}

List<Map<String, dynamic>> guitarList = [];
List<Map<String, dynamic>> filteredGuitars = [];
List<Map<String, dynamic>> filteredGuitarsByBrands = [];
List<String> guitarBrandList = [];
List<String> selectedBrands = [];

String sortCriterion = "relevance";

void populateGuitarList() {
  guitarList.clear();
  for (int i = 0; i < instruments.length; i++) {
    if (instruments[i]["instrument"].toString().toLowerCase() == "guitar") {
      guitarList.add(instruments[i]);
    }
  }
}

void populateGuitarBrandList() {
  guitarBrandList.clear();
  for (int i = 0; i < guitarList.length; i++) {
    guitarBrandList.add(guitarList[i]["brand"]);
  }
  guitarBrandList = guitarBrandList.toSet().toList();
}

double minGuitarPrice = 10000000.0;
double maxGuitarPrice = -1.0;

void findMinPrice() {
  for (int i = 0; i < guitarList.length; i++) {
    if (guitarList[i]["price"] < minGuitarPrice) {
      minGuitarPrice = guitarList[i]["price"];
    }
  }
}

void findMaxPrice() {
  for (int i = 0; i < guitarList.length; i++) {
    if (guitarList[i]["price"] > maxGuitarPrice) {
      maxGuitarPrice = guitarList[i]["price"];
    }
  }
}

double minSearchPrice = minGuitarPrice;
double maxSearchPrice = maxGuitarPrice;

class _ElectricGuitarsScreenState extends State<ElectricGuitarsScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 1;
  int count = 0;

  bool isSortFilter = false;

  RangeValues rv = RangeValues(0, 1000000);

  double _animContWidth = 0.0;
  double _animContHeight = 0.0;

  void changeSearchPrice(double minsp, maxsp) {
    setState(() {
      minSearchPrice = minsp;
      maxSearchPrice = maxsp;
      populateGuitarList();
      count++;
    });
  }

  void populateFilteredGuitars(double minp, double maxp) {
    filteredGuitars.clear();

    filteredGuitarsByBrands.clear();

    if (selectedBrands.isNotEmpty) {
      for (int i = 0; i < guitarList.length; i++) {
        for (int j = 0; j < selectedBrands.length; j++) {
          if (guitarList[i]["brand"] == selectedBrands[j]) {
            filteredGuitarsByBrands.add(guitarList[i]);
          }
        }
      }
    }

    if (selectedBrands.isEmpty) {
      for (int i = 0; i < guitarList.length; i++) {
        if (guitarList[i]["price"] <= maxp && guitarList[i]["price"] >= minp) {
          filteredGuitars.add(guitarList[i]);
        }
      }
    } else {
      filteredGuitars.clear();
      for (int i = 0; i < filteredGuitarsByBrands.length; i++) {
        if (filteredGuitarsByBrands[i]["price"] <= maxp &&
            filteredGuitarsByBrands[i]["price"] >= minp) {
          filteredGuitars.add(filteredGuitarsByBrands[i]);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    populateGuitarList();
    findMinPrice();
    findMaxPrice();
    minSearchPrice = minGuitarPrice;
    maxSearchPrice = maxGuitarPrice;
    rv = RangeValues(minSearchPrice, maxSearchPrice);
    sortCriterion = "relevance";
    //guitarList.sort((a, b) => a["brand"].compareTo(b["brand"]));
    populateFilteredGuitars(minSearchPrice, maxSearchPrice);
    populateGuitarBrandList();
  }

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
    //wishList = customerWishlist;

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
    //cartList = customerCartlist;

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
    // cartMap = customerCartMap;

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
    //myCartValue = customerCartValue;

    double computeCartValue() {
      double cV = 0;
      for (int i = 0; i < customerCartlist.length; i++) {
        cV = cV + (customerCartlist[i]["price"] * customerCartMap[i]);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.025),
                  child: TextLabel(
                      width: screenWidth * 0.125,
                      labelText: "Guitars",
                      fontSize: screenWidth * 0.025),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.025),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (!isSortFilter) {
                          _animContWidth = screenWidth * 0.95;
                          _animContHeight = screenHeight * 0.236;
                        } else {
                          _animContWidth = 0;
                          _animContHeight = 0;
                        }
                        isSortFilter = !isSortFilter;
                      });
                    },
                    child: Icon(
                      Icons.sort_rounded,
                      size: screenWidth * 0.05,
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
            // (isSortFilter)
            //     ?
            AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutExpo,
              width: _animContWidth,
              height: _animContHeight,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "₹ $minGuitarPrice",
                        style: globalTextStyle.copyWith(
                          color: primaryColor,
                          fontSize: screenWidth * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.7,
                        child: RangeSlider(
                          min: minGuitarPrice,
                          max: maxGuitarPrice,
                          divisions: (maxGuitarPrice - minGuitarPrice).toInt(),
                          values: rv,
                          labels: RangeLabels(rv.start.round().toString(),
                              rv.end.round().toString()),
                          activeColor: primaryColor,
                          inactiveColor: Colors.grey,
                          onChanged: (values) {
                            setState(() {
                              rv = values;
                              populateFilteredGuitars(rv.start, rv.end);
                              count++;
                            });
                          },
                        ),
                      ),
                      Text(
                        "₹ $maxGuitarPrice",
                        style: globalTextStyle.copyWith(
                          color: primaryColor,
                          fontSize: screenWidth * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
                  SizedBox(
                    height: screenHeight * 0.025,
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: guitarBrandList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.02),
                                    child: InkWell(
                                      onTap: () {
                                        if (!selectedBrands
                                            .contains(guitarBrandList[index])) {
                                          setState(() {
                                            selectedBrands
                                                .add(guitarBrandList[index]);

                                            populateFilteredGuitars(
                                                rv.start, rv.end);
                                            count++;
                                          });
                                        } else {
                                          setState(() {
                                            selectedBrands
                                                .remove(guitarBrandList[index]);

                                            populateFilteredGuitars(
                                                rv.start, rv.end);

                                            count++;
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * 0.2,
                                        decoration: BoxDecoration(
                                          color: (!selectedBrands.contains(
                                                  guitarBrandList[index]))
                                              ? Colors.grey.shade200
                                              : primaryColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            guitarBrandList[index],
                                            style: globalTextStyle.copyWith(
                                              color: (!selectedBrands.contains(
                                                      guitarBrandList[index]))
                                                  ? primaryColor
                                                  : tertiaryColor,
                                              fontSize: screenWidth * 0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }))
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRadioButton(
                        screenWidth: screenWidth,
                        value: "relevance",
                        groupValue: sortCriterion,
                        onChanged: (value) {
                          setState(() {
                            sortCriterion = value.toString();
                            guitarList.sort(
                                (a, b) => a["brand"].compareTo(b["brand"]));
                            populateFilteredGuitars(rv.start, rv.end);
                            count++;
                          });
                        },
                        text: "Relevance",
                      ),
                      CustomRadioButton(
                        screenWidth: screenWidth,
                        value: "low to high",
                        groupValue: sortCriterion,
                        onChanged: (value) {
                          setState(() {
                            sortCriterion = value.toString();
                            guitarList.sort(
                                (a, b) => a["price"].compareTo(b["price"]));
                            populateFilteredGuitars(rv.start, rv.end);
                            count++;
                          });
                        },
                        text: "Low to High",
                      ),
                      CustomRadioButton(
                        screenWidth: screenWidth,
                        value: "high to low",
                        groupValue: sortCriterion,
                        onChanged: (value) {
                          setState(() {
                            sortCriterion = value.toString();
                            guitarList.sort(
                                (a, b) => b["price"].compareTo(a["price"]));
                            populateFilteredGuitars(rv.start, rv.end);
                            count++;
                          });
                        },
                        text: "High to Low",
                      ),
                      CustomRadioButton(
                        screenWidth: screenWidth,
                        value: "max discount",
                        groupValue: sortCriterion,
                        onChanged: (value) {
                          setState(() {
                            sortCriterion = value.toString();
                            guitarList.sort((a, b) => (a["price"] / a["mrp"])
                                .compareTo((b["price"] / b["mrp"])));
                            populateFilteredGuitars(rv.start, rv.end);
                            count++;
                          });
                        },
                        text: "Max Discount",
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.025),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedBrands.clear();
                              rv = RangeValues(minGuitarPrice, maxGuitarPrice);
                              populateFilteredGuitars(rv.start, rv.end);
                              count++;
                            });
                          },
                          child: Text(
                            "Clear filters",
                            style: globalTextStyle.copyWith(
                              color: primaryColor,
                              fontSize: screenWidth * 0.02,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
                ],
              ),
            ),
            //   )
            // : const SizedBox(),
            SizedBox(
              width: screenWidth,
              height:
                  (isSortFilter) ? screenHeight * 0.55 : screenHeight * 0.765,
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
                          children:
                              List.generate(filteredGuitars.length, (index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: InstrumentCard(
                                      width: (screenWidth * 0.46),
                                      height: (screenWidth * 0.46) / 0.75,
                                      instrumentImageUrl: filteredGuitars[index]
                                          ["img-url"],
                                      instrumentName: filteredGuitars[index]
                                          ["name"],
                                      instrumentMrp:
                                          "₹${filteredGuitars[index]["mrp"].toString()}",
                                      instrumentPrice:
                                          "₹${filteredGuitars[index]["price"].toString()}",
                                      paddingRight: 0,
                                      innerHorizontalSymmetricPadding: 10,
                                      innerVerticalSymmetricPadding: 0,
                                      instrumentDiscount:
                                          "${(((1 - (filteredGuitars[index]["price"] / filteredGuitars[index]["mrp"])) * 100).round()).toString()}% off",
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InstrumentDetail(
                                                        instrument:
                                                            filteredGuitars[
                                                                index])));
                                      },
                                      onWishTap: () async {
                                        bool check = false;

                                        for (int i = 0;
                                            i < customerWishlist.length;
                                            i++) {
                                          if (customerWishlist[i]["iid"] ==
                                              filteredGuitars[index]["iid"]) {
                                            check = true;
                                            break;
                                          }
                                        }

                                        if (check) {
                                          setState(() {
                                            for (int i = 0;
                                                i < customerWishlist.length;
                                                i++) {
                                              if (customerWishlist[i]["iid"] ==
                                                  filteredGuitars[index]
                                                      ["iid"]) {
                                                customerWishlist.remove(
                                                    customerWishlist[i]);
                                                break;
                                              }
                                            }

                                            wishList = customerWishlist;

                                            FirebaseFirestore.instance
                                                .collection('customers')
                                                .doc(currUser!.uid)
                                                .update(
                                                    {"wish": customerWishlist});
                                          });
                                        } else {
                                          setState(() {
                                            customerWishlist
                                                .add(filteredGuitars[index]);

                                            wishList = customerWishlist;

                                            FirebaseFirestore.instance
                                                .collection('customers')
                                                .doc(currUser!.uid)
                                                .update(
                                                    {"wish": customerWishlist});
                                          });
                                        }
                                      },
                                      onCartTap: () async {
                                        bool check = false;
                                        for (int i = 0;
                                            i < customerCartlist.length;
                                            i++) {
                                          if (customerCartlist[i]["iid"] ==
                                              filteredGuitars[index]["iid"]) {
                                            check = true;
                                            break;
                                          }
                                        }

                                        if (check) {
                                          setState(() {
                                            for (int i = 0;
                                                i < customerCartlist.length;
                                                i++) {
                                              if (customerCartlist[i]["iid"] ==
                                                  filteredGuitars[index]
                                                      ["iid"]) {
                                                customerCartlist.remove(
                                                    customerCartlist[i]);
                                                customerCartMap.removeAt(i);
                                                customerCartValue =
                                                    computeCartValue();
                                                myCartValue = customerCartValue;
                                                break;
                                              }
                                            }

                                            cartList = customerCartlist;
                                            cartMap = customerCartMap;

                                            FirebaseFirestore.instance
                                                .collection('customers')
                                                .doc(currUser!.uid)
                                                .update(
                                                    {"cart": customerCartlist});
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
                                              "cartValue": customerCartValue
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            customerCartlist
                                                .add(filteredGuitars[index]);
                                            customerCartMap.add(1);

                                            customerCartValue =
                                                computeCartValue();
                                            myCartValue = customerCartValue;

                                            cartList = customerCartlist;
                                            cartMap = customerCartMap;

                                            FirebaseFirestore.instance
                                                .collection('customers')
                                                .doc(currUser!.uid)
                                                .update(
                                                    {"cart": customerCartlist});
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
                                              "cartValue": customerCartValue
                                            });
                                          });
                                        }
                                      },
                                      isWishlisted: (wishList
                                              .contains(filteredGuitars[index]))
                                          ? true
                                          : false,
                                      isCarted: (cartList
                                              .contains(filteredGuitars[index]))
                                          ? true
                                          : false,
                                      instrument: filteredGuitars[index]),
                                ),
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
