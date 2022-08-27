import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:musicart/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../global_variables/global_variables.dart';
import '../services/firebase_auth_methods.dart';
import '../widgets/animated_bottom_bar.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 3;
  int count = 0;
  num totalItemsOrdered = 0;

  @override
  Widget build(BuildContext context) {
    final currUser = context.read<FirebaseAuthMethods>().user;
    if (currUser != null) {
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
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
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
            (ordersList.isEmpty)
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.2,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "./assets/images/empty_order_history.svg",
                            width: screenWidth * 0.33,
                            height: screenWidth * 0.33,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.025)),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            right: screenWidth * 0.05),
                        child: Text(
                          "You haven't ordered anything to us yet, please browse products and order them.",
                          style: globalTextStyle.copyWith(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.025,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: ordersList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: screenWidth,
                                height: (screenHeight *
                                    0.125 *
                                    ordersList[index]["items"].length),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.01),
                                      child:
                                          // Text("dateTime"),
                                          Text(
                                        DateFormat.yMMMMEEEEd().format(
                                            ordersList[index]["dateTime"]
                                                .toDate()),
                                        style: globalTextStyle.copyWith(
                                          color: Colors.grey,
                                          fontSize: screenWidth * 0.03,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount:
                                              ordersList[index]["items"].length,
                                          itemBuilder: (BuildContext context,
                                              int index2) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.01,
                                                  left: screenWidth * 0.025,
                                                  right: screenWidth * 0.025),
                                              child: Container(
                                                width: screenWidth * 0.95,
                                                height: screenHeight * 0.08,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 0.25,
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                child:
                                                    //Text("itemDetail"),
                                                    ListTile(
                                                  leading: Image(
                                                      image: NetworkImage(
                                                          ordersList[index]
                                                                      ["items"]
                                                                  [index2]
                                                              ["img-url"])),
                                                  title: Text(
                                                    ordersList[index]["items"]
                                                        [index2]["name"],
                                                    style: globalTextStyle
                                                        .copyWith(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    "${ordersList[index]["units"][index2].toString()} units",
                                                    style: globalTextStyle
                                                        .copyWith(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  trailing: Text(
                                                    "₹ ${ordersList[index]["items"][index2]["price"].toString()}",
                                                    style: globalTextStyle
                                                        .copyWith(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.01,
                                        horizontal: screenWidth * 0.03,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Text("addressOfOrder"),
                                          Text(
                                            ordersList[index]["addressOfOrder"]
                                                ["addressLine1"],
                                            style: globalTextStyle.copyWith(
                                              color: Colors.grey,
                                              fontSize: screenWidth * 0.025,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          //Text("orderValue"),
                                          Text(
                                            "₹ ${ordersList[index]["orderValue"].toString()}",
                                            style: globalTextStyle.copyWith(
                                              color: Colors.grey,
                                              fontSize: screenWidth * 0.03,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // const Divider(
                                    //   color: Colors.grey,
                                    //   height: 1,
                                    //   indent: 20,
                                    //   endIndent: 20,
                                    // ),
                                    // SizedBox(
                                    //   height: screenHeight * 0.01,
                                    // )
                                  ],
                                ),
                              );
                            },
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
