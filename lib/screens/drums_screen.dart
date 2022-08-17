import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:musicart/widgets/text_label.dart';

import '../global_variables/global_variables.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_radio_button.dart';
import '../widgets/instrument_card.dart';
import 'instrument_detail.dart';

class DrumsScreen extends StatefulWidget {
  const DrumsScreen({Key? key}) : super(key: key);

  @override
  State<DrumsScreen> createState() => _DrumsScreenState();
}

List<Map<String, dynamic>> drumList = [];
List<Map<String, dynamic>> filteredDrums = [];
//List<Map<String, dynamic>> filteredDrums2 = [];
List<Map<String, dynamic>> filteredDrumsByBrands = [];
//List<Map<String, dynamic>> filteredDrumsByPrice = [];
List<String> drumBrandList = [];
List<String> selectedDrumBrands = [];

String sortCriterion = "relevance";

void populatedrumList() {
  drumList.clear();
  for (int i = 0; i < instruments.length; i++) {
    if (instruments[i]["instrument"].toString().toLowerCase() == "drums") {
      drumList.add(instruments[i]);
    }
  }
}

void populatedrumBrandList() {
  drumBrandList.clear();
  for (int i = 0; i < drumList.length; i++) {
    drumBrandList.add(drumList[i]["brand"]);
  }
  drumBrandList = drumBrandList.toSet().toList();
}

double minDrumPrice = 10000000.0;
double maxDrumPrice = -1.0;

void findMinDrumPrice() {
  for (int i = 0; i < drumList.length; i++) {
    if (drumList[i]["price"] < minDrumPrice) {
      minDrumPrice = drumList[i]["price"];
    }
  }
}

void findMaxDrumPrice() {
  for (int i = 0; i < drumList.length; i++) {
    if (drumList[i]["price"] > maxDrumPrice) {
      maxDrumPrice = drumList[i]["price"];
    }
  }
}

double minDrumSearchPrice = minDrumPrice;
double maxDrumSearchPrice = maxDrumPrice;

class _DrumsScreenState extends State<DrumsScreen> {
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
      minDrumSearchPrice = minsp;
      maxDrumSearchPrice = maxsp;
      populatedrumList();
      count++;
    });
  }

  void populatefilteredDrums(double minp, double maxp) {
    filteredDrums.clear();

    filteredDrumsByBrands.clear();
    //filteredDrumsByPrice.clear();

    if (selectedDrumBrands.isNotEmpty) {
      for (int i = 0; i < drumList.length; i++) {
        for (int j = 0; j < selectedDrumBrands.length; j++) {
          if (drumList[i]["brand"] == selectedDrumBrands[j]) {
            filteredDrumsByBrands.add(drumList[i]);
          }
        }
      }
    }

    if (selectedDrumBrands.isEmpty) {
      for (int i = 0; i < drumList.length; i++) {
        if (drumList[i]["price"] <= maxp && drumList[i]["price"] >= minp) {
          filteredDrums.add(drumList[i]);
        }
      }
    } else {
      filteredDrums.clear();
      for (int i = 0; i < filteredDrumsByBrands.length; i++) {
        if (filteredDrumsByBrands[i]["price"] <= maxp &&
            filteredDrumsByBrands[i]["price"] >= minp) {
          filteredDrums.add(filteredDrumsByBrands[i]);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    populatedrumList();
    findMinDrumPrice();
    findMaxDrumPrice();
    minDrumSearchPrice = minDrumPrice;
    maxDrumSearchPrice = maxDrumPrice;
    rv = RangeValues(minDrumSearchPrice, maxDrumSearchPrice);
    sortCriterion = "relevance";
    //drumList.sort((a, b) => a["brand"].compareTo(b["brand"]));
    populatefilteredDrums(minDrumSearchPrice, maxDrumSearchPrice);
    populatedrumBrandList();
  }

  @override
  Widget build(BuildContext context) {
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
                      labelText: "Drums",
                      fontSize: screenWidth * 0.025),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.025),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (!isSortFilter) {
                          _animContWidth = screenWidth * 0.95;
                          _animContHeight = screenHeight * 0.205;
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
                        "₹ $minDrumPrice",
                        style: globalTextStyle.copyWith(
                          color: primaryColor,
                          fontSize: screenWidth * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.7,
                        child: RangeSlider(
                          min: minDrumPrice,
                          max: maxDrumPrice,
                          divisions: (maxDrumPrice - minDrumPrice).toInt(),
                          values: rv,
                          labels: RangeLabels(rv.start.round().toString(),
                              rv.end.round().toString()),
                          activeColor: primaryColor,
                          inactiveColor: Colors.grey,
                          onChanged: (values) {
                            setState(() {
                              rv = values;
                              populatefilteredDrums(rv.start, rv.end);
                              count++;
                            });
                          },
                        ),
                      ),
                      Text(
                        "₹ $maxDrumPrice",
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
                                itemCount: drumBrandList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.02),
                                    child: InkWell(
                                      onTap: () {
                                        if (!selectedDrumBrands
                                            .contains(drumBrandList[index])) {
                                          setState(() {
                                            selectedDrumBrands
                                                .add(drumBrandList[index]);

                                            populatefilteredDrums(
                                                rv.start, rv.end);
                                            count++;
                                          });
                                        } else {
                                          setState(() {
                                            selectedDrumBrands
                                                .remove(drumBrandList[index]);

                                            populatefilteredDrums(
                                                rv.start, rv.end);

                                            count++;
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * 0.2,
                                        decoration: BoxDecoration(
                                          color: (!selectedDrumBrands.contains(
                                                  drumBrandList[index]))
                                              ? Colors.grey.shade200
                                              : primaryColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            drumBrandList[index],
                                            style: globalTextStyle.copyWith(
                                              color:
                                                  (!selectedDrumBrands.contains(
                                                          drumBrandList[index]))
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
                            drumList.sort(
                                (a, b) => a["brand"].compareTo(b["brand"]));
                            populatefilteredDrums(rv.start, rv.end);
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
                            drumList.sort(
                                (a, b) => a["price"].compareTo(b["price"]));
                            populatefilteredDrums(rv.start, rv.end);
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
                            drumList.sort(
                                (a, b) => b["price"].compareTo(a["price"]));
                            populatefilteredDrums(rv.start, rv.end);
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
                            drumList.sort((a, b) => (a["price"] / a["mrp"])
                                .compareTo((b["price"] / b["mrp"])));
                            populatefilteredDrums(rv.start, rv.end);
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
                              selectedDrumBrands.clear();
                              rv = RangeValues(minDrumPrice, maxDrumPrice);
                              populatefilteredDrums(rv.start, rv.end);
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
            SizedBox(
              width: screenWidth,
              height:
                  (isSortFilter) ? screenHeight * 0.55 : screenHeight * 0.76,
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
                              List.generate(filteredDrums.length, (index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: InstrumentCard(
                                      width: (screenWidth * 0.46),
                                      height: (screenWidth * 0.46) / 0.75,
                                      instrumentImageUrl: filteredDrums[index]
                                          ["img-url"],
                                      instrumentName: filteredDrums[index]
                                          ["name"],
                                      instrumentMrp:
                                          "₹${filteredDrums[index]["mrp"].toString()}",
                                      instrumentPrice:
                                          "₹${filteredDrums[index]["price"].toString()}",
                                      paddingRight: 0,
                                      innerHorizontalSymmetricPadding: 10,
                                      innerVerticalSymmetricPadding: 0,
                                      instrumentDiscount:
                                          "${(((1 - (filteredDrums[index]["price"] / filteredDrums[index]["mrp"])) * 100).round()).toString()}% off",
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InstrumentDetail(
                                                        instrument:
                                                            filteredDrums[
                                                                index])));
                                      },
                                      onWishTap: () {
                                        if (wishList
                                            .contains(filteredDrums[index])) {
                                          setState(() {
                                            wishList
                                                .remove(filteredDrums[index]);
                                            //count++;
                                          });
                                        } else {
                                          setState(() {
                                            wishList.add(filteredDrums[index]);
                                          });
                                        }
                                      },
                                      onCartTap: () {
                                        if (cartList.contains(
                                                filteredDrums[index]) ==
                                            false) {
                                          setState(() {
                                            cartList.add(filteredDrums[index]);
                                            cartMap.addAll(
                                                {filteredDrums[index]: 1});
                                          });
                                        } else {
                                          setState(() {
                                            cartList
                                                .remove(filteredDrums[index]);
                                            cartMap
                                                .remove(filteredDrums[index]);
                                          });
                                        }
                                      },
                                      isWishlisted: (wishList
                                              .contains(filteredDrums[index]))
                                          ? true
                                          : false,
                                      isCarted: (cartList
                                              .contains(filteredDrums[index]))
                                          ? true
                                          : false,
                                      instrument: filteredDrums[index]),
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
