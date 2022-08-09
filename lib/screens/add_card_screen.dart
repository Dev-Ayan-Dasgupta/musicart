import 'package:flutter/material.dart';
import 'package:musicart/lists/list_of_cards.dart';
import 'package:musicart/models/card_object.dart';
import 'package:musicart/widgets/add_card_widget.dart';
import 'package:musicart/widgets/custom_appbar.dart';

import '../global_variables/global_variables.dart';
import '../widgets/animated_bottom_bar.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 3;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  int cardProviderIndex = 3;

  String getCardProviderUrl(String s) {
    if (s == "4") {
      return cardProviderUrls[0];
    } else if (s == "5") {
      return cardProviderUrls[1];
    } else if (s == "6") {
      return cardProviderUrls[2];
    } else {
      return cardProviderUrls[3];
    }
  }

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    String firstDigit = "";

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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: screenHeight * 0.4 / 2)),
              Center(
                child: AddCard(
                  width: screenWidth * 0.95,
                  height: screenWidth * 0.95 * 0.618,
                  nameController: _nameController,
                  cardNumController: _cardNumController,
                  expiryDateController: _expiryDateController,
                  cvvController: _cvvController,
                  onChanged: (p0) {
                    setState(() {
                      if (p0.isNotEmpty) {
                        firstDigit = p0.substring(0, 1);
                        if (firstDigit == "4") {
                          cardProviderIndex = 0;
                        } else if (firstDigit == "5") {
                          cardProviderIndex = 1;
                        } else if (firstDigit == "6") {
                          cardProviderIndex = 2;
                        } else {
                          cardProviderIndex = 3;
                        }
                      } else {
                        cardProviderIndex = 3;
                      }
                    });
                  },
                  cardProviderImgUrl: cardProviderUrls[cardProviderIndex],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: screenWidth * 0.025)),
              SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    myCards.add(
                      CardObject(
                        ownerName: _nameController.text,
                        cardNum: _cardNumController.text,
                        monthOfExpiry:
                            _expiryDateController.text.substring(0, 2),
                        dayofExpiry: _expiryDateController.text.substring(
                            _expiryDateController.text.length - 2,
                            _expiryDateController.text.length),
                        cvv: _cvvController.text,
                        providerImgUrl: getCardProviderUrl(
                          _cardNumController.text.substring(0, 1),
                        ),
                      ),
                    );
                    Navigator.pushNamed(context, "/payments");
                  },
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    "Add Card",
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
