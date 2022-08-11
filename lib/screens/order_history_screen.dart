import 'package:flutter/material.dart';
import 'package:musicart/widgets/custom_appbar.dart';

import '../global_variables/global_variables.dart';
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
          SizedBox(
            width: screenWidth * 0.95,
            height: screenHeight * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: ordersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: screenWidth * 0.95,
                        height: screenHeight * 0.10 * ordersList[index].length,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${ordersDate[ordersList[index]]}"),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: ordersList[index].length,
                                  itemBuilder:
                                      (BuildContext context, int index2) {
                                    return ListTile(
                                      leading: Image(
                                          image: NetworkImage(ordersList[index]
                                              [index2]["img-url"])),
                                      title: Text(
                                        ordersList[index][index2]["name"],
                                        style: globalTextStyle.copyWith(
                                          color: primaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${ordersMap[index][ordersList[index][index2]].toString()} units",
                                        style: globalTextStyle.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      trailing: Text(
                                        "₹${ordersList[index][index2]["price"].toString()}",
                                        style: globalTextStyle.copyWith(
                                          color: primaryColor,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
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
