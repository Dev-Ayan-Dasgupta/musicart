import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';
import 'package:musicart/lists/list_of_addresses.dart';
import 'package:musicart/models/address_object.dart';
import 'package:musicart/widgets/custom_appbar.dart';

import '../widgets/animated_bottom_bar.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({Key? key}) : super(key: key);

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 3;

  final TextEditingController _personNameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: SizedBox(
              width: screenHeight * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name*",
                    style: globalTextStyle.copyWith(
                      color: primaryColor,
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.01)),
                  Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.25, color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                      child: TextField(
                        controller: _personNameController,
                        cursorColor: Colors.grey,
                        style: globalTextStyle.copyWith(
                            color: Colors.grey, fontSize: screenWidth * 0.025),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your name...",
                          hintStyle: globalTextStyle.copyWith(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.025),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.015)),
                  Text(
                    "Address Line 1*",
                    style: globalTextStyle.copyWith(
                      color: primaryColor,
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.01)),
                  Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.25, color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                      child: TextField(
                        controller: _addressLine1Controller,
                        cursorColor: Colors.grey,
                        style: globalTextStyle.copyWith(
                            color: Colors.grey, fontSize: screenWidth * 0.025),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Apartment name, flat no.",
                          hintStyle: globalTextStyle.copyWith(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.025),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.015)),
                  Text(
                    "Address Line 2*",
                    style: globalTextStyle.copyWith(
                      color: primaryColor,
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.01)),
                  Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.25, color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                      child: TextField(
                        controller: _addressLine2Controller,
                        cursorColor: Colors.grey,
                        style: globalTextStyle.copyWith(
                            color: Colors.grey, fontSize: screenWidth * 0.025),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Locality or street name...",
                          hintStyle: globalTextStyle.copyWith(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.025),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.015)),
                  Text(
                    "Landmark",
                    style: globalTextStyle.copyWith(
                      color: primaryColor,
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.01)),
                  Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.25, color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                      child: TextField(
                        controller: _landmarkController,
                        cursorColor: Colors.grey,
                        style: globalTextStyle.copyWith(
                            color: Colors.grey, fontSize: screenWidth * 0.025),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Police station/mall/stadium, etc.",
                          hintStyle: globalTextStyle.copyWith(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.025),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.015)),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "City*",
                            style: globalTextStyle.copyWith(
                              color: primaryColor,
                              fontSize: screenWidth * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.01)),
                          Container(
                            width: screenWidth * 0.285,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.25, color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.025),
                              child: TextField(
                                controller: _cityController,
                                cursorColor: Colors.grey,
                                style: globalTextStyle.copyWith(
                                    color: Colors.grey,
                                    fontSize: screenWidth * 0.025),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "e.g. Kolkata",
                                  hintStyle: globalTextStyle.copyWith(
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.025),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.02)),
                      Column(
                        children: [
                          Text(
                            "State*",
                            style: globalTextStyle.copyWith(
                              color: primaryColor,
                              fontSize: screenWidth * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.01)),
                          Container(
                            width: screenWidth * 0.285,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.25, color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.025),
                              child: TextField(
                                controller: _stateController,
                                cursorColor: Colors.grey,
                                style: globalTextStyle.copyWith(
                                    color: Colors.grey,
                                    fontSize: screenWidth * 0.025),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "e.g. West Bengal",
                                  hintStyle: globalTextStyle.copyWith(
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.025),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.02)),
                      Column(
                        children: [
                          Text(
                            "PIN Code*",
                            style: globalTextStyle.copyWith(
                              color: primaryColor,
                              fontSize: screenWidth * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.01)),
                          Container(
                            width: screenWidth * 0.285,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.25, color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.025),
                              child: TextField(
                                controller: _pinCodeController,
                                cursorColor: Colors.grey,
                                keyboardType: TextInputType.number,
                                style: globalTextStyle.copyWith(
                                    color: Colors.grey,
                                    fontSize: screenWidth * 0.025),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "e.g. 700135",
                                  hintStyle: globalTextStyle.copyWith(
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.025),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: screenWidth * 0.025)),
                  SizedBox(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        myAddresses.add(
                          AddressObject(
                            personName: _personNameController.text,
                            addressLine1: _addressLine1Controller.text,
                            addressLine2: _addressLine2Controller.text,
                            landmark: _landmarkController.text,
                            city: _cityController.text,
                            state: _stateController.text,
                            pinCode: _pinCodeController.text,
                            isCurrentAddress: false,
                          ),
                        );
                        Navigator.pushNamed(context, "/select-address");
                      },
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(
                        "Add Address",
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
    );
  }
}
