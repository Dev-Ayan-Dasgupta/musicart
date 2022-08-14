import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:musicart/lists/list_of_addresses.dart';
import 'package:musicart/screens/edit_address.dart';
import 'package:musicart/widgets/choose_address_card.dart';
import 'package:musicart/widgets/custom_appbar.dart';

import '../global_variables/global_variables.dart';
import '../widgets/animated_bottom_bar.dart';

class ChooseAddressScreen extends StatefulWidget {
  const ChooseAddressScreen({Key? key}) : super(key: key);

  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 3;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            searchBoxController: _searchBoxController,
            hintText: _hintText,
          ),
          (cartList.isNotEmpty)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (currentAddress != null)
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/select-address");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.04,
                              ),
                              child: Text(
                                currentAddress!.addressLine1,
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
                          Navigator.pushNamed(context, "/payments");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: screenWidth * 0.4,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
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
                )
              : const SizedBox(),
          SizedBox(
            width: screenWidth * 0.95,
            height: min(
                screenHeight * 0.7, screenHeight * 0.23 * myAddresses.length),
            child: Column(
              children: [
                Expanded(
                    child: AnimationLimiter(
                  key: ValueKey("list $count"),
                  child: ListView.builder(
                      itemCount: myAddresses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: ChooseAddressCard(
                                  width: screenWidth * 0.90,
                                  height: screenHeight * 0.155,
                                  isCurrentAddress:
                                      myAddresses[index].isCurrentAddress,
                                  addressPersonName:
                                      myAddresses[index].personName,
                                  addressLine1: myAddresses[index].addressLine1,
                                  addressLine2: myAddresses[index].addressLine2,
                                  landmark: myAddresses[index].landmark,
                                  city: myAddresses[index].city,
                                  state: myAddresses[index].state,
                                  pinCode: myAddresses[index].pinCode,
                                  onTap: () {
                                    setState(() {
                                      myAddresses[index].isCurrentAddress =
                                          true;
                                      setOtherAddressesToFalse(
                                          myAddresses[index]);
                                      count++;
                                    });
                                  },
                                  onEditTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditAddressScreen(
                                                  editingAddress:
                                                      myAddresses[index],
                                                  editingIndex: index,
                                                )));
                                  },
                                  onDeleteTap: () {
                                    setState(() {
                                      myAddresses.remove(myAddresses[index]);
                                      count++;
                                    });
                                  }),
                            ),
                          ),
                        );
                      }),
                )),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: screenHeight * 0.025)),
          SizedBox(
            width: screenWidth * 0.5,
            height: screenHeight * 0.05,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/payments");
              },
              style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text(
                "Confirm Address",
                style: globalTextStyle.copyWith(
                  color: tertiaryColor,
                  fontSize: screenWidth * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add-address");
        },
        backgroundColor: primaryColor,
        //foregroundColor: tertiaryColor,
        child: Icon(
          Icons.add_rounded,
          color: tertiaryColor,
        ),
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
    );
  }
}
