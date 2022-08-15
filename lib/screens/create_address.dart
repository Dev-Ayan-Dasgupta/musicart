import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:musicart/global_variables/global_variables.dart';
import 'package:musicart/lists/list_of_addresses.dart';
import 'package:musicart/models/address_object.dart';
import 'package:musicart/widgets/custom_appbar.dart';

import '../widgets/animated_bottom_bar.dart';

//import 'dart:hmtl';

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

  GoogleMapController? _googleMapController;
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(0, 0));
  LatLng _latlong = LatLng(0, 0);

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await GeolocatorPlatform.instance.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await GeolocatorPlatform.instance.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await GeolocatorPlatform.instance.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    setState(() {
      _latlong = LatLng(position.latitude, position.longitude);
      _googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _latlong, zoom: 15)));
      //getAddress();
    });

    return position;
  }

  Position position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  List<Placemark>? placeMarks;

  getAddress() async {
    placeMarks =
        await placemarkFromCoordinates(_latlong.latitude, _latlong.longitude);
    Placemark placemark = placeMarks![0];
    // _addressController.text =
    //     "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.postalCode}, ${placemark.country}";
    _addressLine1Controller.text =
        "${placemark.street}, ${placemark.subThoroughfare}";
    _addressLine2Controller.text = "${placemark.thoroughfare}";
    _landmarkController.text = "${placemark.subThoroughfare}";
    _cityController.text = "${placemark.subLocality}";
    _stateController.text = "${placemark.administrativeArea}";
    _pinCodeController.text = "${placemark.postalCode}";
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      InkWell(
                        onTap: () async {
                          position = await GeolocatorPlatform.instance
                              .getCurrentPosition(
                                  locationSettings: const LocationSettings(
                                      accuracy: LocationAccuracy.high));
                          setState(() {
                            _latlong =
                                LatLng(position.latitude, position.longitude);
                            _googleMapController!.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: _latlong, zoom: 15)));
                            getAddress();
                          });
                        },
                        child: Row(
                          children: [
                            Text("Locate me ",
                                style: globalTextStyle.copyWith(
                                    color: primaryColor,
                                    fontSize: screenWidth * 0.025)),
                            SizedBox(width: screenWidth * 0.025),
                            const Icon(Icons.location_searching_rounded),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.225,
                    child: GoogleMap(
                      initialCameraPosition: _cameraPosition,
                      onMapCreated: (controller) {
                        setState(() {
                          _googleMapController = controller;
                        });
                      },
                      markers: Set<Marker>.of(<Marker>[
                        Marker(
                          markerId: MarkerId("1"),
                          position: _latlong,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                        ),
                      ]),
                      onCameraMove: (CameraPosition cameraposition) async {
                        _cameraPosition = cameraposition;
                        _latlong = LatLng(cameraposition.target.latitude,
                            cameraposition.target.longitude);
                        getAddress();

                        setState(() {
                          print("${_latlong.latitude}, ${_latlong.longitude}");
                          //print(_addressController.text);

                          //getMovedAddress(cameraposition);
                        });
                      },
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

  // void _updatePosition(CameraPosition _position) {
  //   gl.Position newMarkerPosition = gl.Position(
  //       latitude: _position.target.latitude,
  //       longitude: _position.target.longitude);
  //   Marker marker = markers["1"];

  //   setState(() {
  //     markers["1"] = marker.copyWith(
  //         positionParam:
  //             LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
  //   });
  // }

  

  

  
