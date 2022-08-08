import 'package:flutter/material.dart';
import 'package:musicart/screens/instrument_detail.dart';
import 'package:musicart/screens/wishlist_screen.dart';
import 'package:musicart/widgets/animated_bottom_bar.dart';
import 'package:musicart/widgets/brand_logo_card.dart';
import 'package:musicart/widgets/instrument_card.dart';
import 'package:musicart/widgets/search_widget.dart';
import 'package:musicart/widgets/text_label.dart';

import '../global_variables/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
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
                      // Padding(
                      //     padding: EdgeInsets.only(top: screenHeight * 0.01)),
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
                        child: const TextLabel(
                          width: 75,
                          labelText: "Top Brands",
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
                        child: const TextLabel(
                          width: 104,
                          labelText: "Trending Guitars",
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
                          height: screenWidth * 0.45 / 0.75,
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
                                      width: screenWidth * 0.45,
                                      height: screenWidth * 0.45 / 0.75,
                                      instrumentImageUrl: instruments[index]
                                          ["img-url"],
                                      instrumentName: instruments[index]
                                          ["name"],
                                      instrumentMrp:
                                          "₹${instruments[index]["mrp"].toString()}",
                                      instrumentPrice:
                                          "₹${instruments[index]["price"].toString()}",
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
                                                        instrument: instruments[
                                                            index])));
                                      },
                                      onWishTap: () {
                                        if (wishList
                                            .contains(instruments[index])) {
                                          setState(() {
                                            wishList.remove(instruments[index]);
                                          });
                                        } else {
                                          setState(() {
                                            wishList.add(instruments[index]);
                                          });
                                        }
                                      },
                                      onCartTap: () {
                                        if (cartList
                                            .contains(instruments[index])) {
                                          setState(() {
                                            cartList.remove(instruments[index]);
                                            cartMap.remove(instruments[index]);
                                          });
                                        } else {
                                          setState(() {
                                            cartList.add(instruments[index]);
                                            cartMap.addAll(
                                                {instruments[index]: 1});
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
                        child: const TextLabel(
                          width: 102,
                          labelText: "Trending Drums",
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
                                      instrumentMrp:
                                          instruments[index]["mrp"].toString(),
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
