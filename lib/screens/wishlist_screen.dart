import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../global_variables/global_variables.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/instrument_card.dart';
import 'instrument_detail.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({
    Key? key,
    required this.mywishList,
  }) : super(key: key);

  final Map<String, dynamic> mywishList;

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 1;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                        crossAxisSpacing: screenWidth * 0.01,
                        mainAxisSpacing: screenWidth * 0.01,
                        childAspectRatio: 0.75,
                        children: List.generate(wishList.length, (index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 2,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                  child: InstrumentCard(
                                      width: (screenWidth * 0.47),
                                      height: (screenWidth * 0.47) / 0.75,
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
                                          "${(((1 - (instruments[index]["price"] / instruments[index]["mrp"])) * 100).round()).toString()}% off",
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InstrumentDetail(
                                                        instrument:
                                                            wishList[index])));
                                      },
                                      onWishTap: () {
                                        setState(() {
                                          wishList.remove(wishList[index]);
                                          count++;
                                        });
                                      },
                                      onCartTap: () {
                                        if (cartList
                                                .contains(wishList[index]) ==
                                            false) {
                                          setState(() {
                                            cartList.add(instruments[index]);
                                            cartMap.addAll(
                                                {instruments[index]: 1});
                                          });
                                        } else {
                                          setState(() {
                                            cartList.remove(instruments[index]);
                                            cartMap.remove(instruments[index]);
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
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.025)),
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
