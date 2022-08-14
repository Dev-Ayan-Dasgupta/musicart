import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:geolocator/geolocator.dart' as gl;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:musicart/global_variables/global_variables.dart';
import 'package:musicart/lists/list_of_addresses.dart';
import 'package:musicart/models/address_object.dart';
import 'package:musicart/widgets/custom_appbar.dart';

import '../widgets/animated_bottom_bar.dart';

import 'package:location/location.dart';

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

  late LocationData _currentPosition;
  final gl.LocationSettings locationSettings = gl.LocationSettings(
    accuracy: gl.LocationAccuracy.high,
    distanceFilter: 100,
  );

  late GoogleMapController mapController;
  late Marker marker;
  Location location = Location();
  //String location2 = 'Null, Press Button';
  //String address = 'Locate me';

  late GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  LatLng _initialcameraposition2 = LatLng(0.5937, 0.9629);

  @override
  void initState() {
    super.initState();

    getLoc();
  }

  void _onMapCreated(GoogleMapController cntlr) {
    _controller = cntlr;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 17),
        ),
      );
    });
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
                          gl.Position position =
                              await _getGeoLocationPosition();
                          // location2 =
                          //     'Lat: ${position.latitude} , Long: ${position.longitude}';
                          getAddressFromLatLong(position);
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
                      initialCameraPosition: CameraPosition(
                        target: _initialcameraposition,
                        zoom: 17,
                      ),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      markers: Set<Marker>.of(<Marker>[
                        Marker(
                            draggable: true,
                            markerId: MarkerId("1"),
                            position: LatLng(0, 0)),
                      ]),
                      myLocationButtonEnabled: true,
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

  Future<gl.Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await gl.Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await gl.Geolocator.getCurrentPosition(
        desiredAccuracy: gl.LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(gl.Position position) async {
    List<gc.Placemark> placemarks = await gc.placemarkFromCoordinates(
        position.latitude, position.longitude);
    print(placemarks);
    gc.Placemark place = placemarks[0];
    //address =
    '${place.street}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';
    _addressLine1Controller.text = "${place.street}, ${place.subThoroughfare}";
    _addressLine2Controller.text = "${place.thoroughfare}";
    _landmarkController.text = "${place.subThoroughfare}";
    _cityController.text = "${place.subLocality}";
    _stateController.text = "${place.administrativeArea}";
    _pinCodeController.text = "${place.postalCode}";
  }

  getLoc() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _initialcameraposition =
        LatLng(_currentPosition.latitude!, _currentPosition.longitude!);

    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude!, _currentPosition.longitude!);

        DateTime now = DateTime.now();
      });
    });
  }
}
