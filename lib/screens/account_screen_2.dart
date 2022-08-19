import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';
import 'package:provider/provider.dart';

import '../widgets/account_screen_info_list.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';
import '../services/firebase_auth_methods.dart';

class AccountScreen2 extends StatefulWidget {
  const AccountScreen2({Key? key}) : super(key: key);

  @override
  State<AccountScreen2> createState() => _AccountScreen2State();
}

class _AccountScreen2State extends State<AccountScreen2> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    final currUser = context.read<FirebaseAuthMethods>().user;

    print(currUser);
    if (!currUser!.isAnonymous && currUser.phoneNumber == null) {
      userName = currUser.email!;
      isSignedIn = true;
    }
    if (currUser.phoneNumber != null) {
      userName = currUser.phoneNumber!;
      isSignedIn = true;
    }
    if (currUser.isAnonymous) {
      isSignedIn = true;
    }

    if (currUser == null) {
      userName = "Guest";
      isSignedIn = false;
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: RichText(
                text: TextSpan(
                  text: "Hey ",
                  style: globalTextStyle.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: primaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: "$userName, ",
                      style: globalTextStyle.copyWith(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: "this is your account screen",
                      style: globalTextStyle.copyWith(
                        fontSize: screenWidth * 0.04,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: Container(
                width: screenWidth * 0.95,
                height: screenHeight * 0.10,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_rounded,
                            size: screenWidth * 0.075,
                            color: tertiaryColor,
                          ),
                          Text(
                            "Wallet",
                            style: globalTextStyle.copyWith(
                              color: tertiaryColor,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.support_agent_rounded,
                            size: screenWidth * 0.075,
                            color: tertiaryColor,
                          ),
                          Text(
                            "Support",
                            style: globalTextStyle.copyWith(
                              color: tertiaryColor,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/payments");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.payment_rounded,
                            size: screenWidth * 0.075,
                            color: tertiaryColor,
                          ),
                          Text(
                            "Payments",
                            style: globalTextStyle.copyWith(
                              color: tertiaryColor,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: Text(
                "YOUR INFORMATION",
                style: globalTextStyle.copyWith(
                    color: secondaryColor, fontSize: screenWidth * 0.03),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
            AccountScreenInfoList(
              screenWidth: screenWidth,
              iconData1: Icons.history_rounded,
              iconData2: Icons.book_rounded,
              iconData3: Icons.offline_share_rounded,
              text1: "Order History",
              text2: "Address Book",
              text3: "Share the app",
              onTap1: () {
                Navigator.pushNamed(context, "/orders-history");
              },
              onTap2: () {
                Navigator.pushNamed(context, "/select-address");
              },
              onTap3: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: Text(
                "OTHER INFORMATION",
                style: globalTextStyle.copyWith(
                    color: secondaryColor, fontSize: screenWidth * 0.03),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
            AccountScreenInfoList(
              screenWidth: screenWidth,
              iconData1: Icons.info_rounded,
              iconData2: Icons.star_rounded,
              iconData3: Icons.power_settings_new_rounded,
              text1: "About",
              text2: "Rate us on Play Store",
              text3: (isSignedIn) ? "Logout" : "Login",
              onTap1: () {},
              onTap2: () {},
              onTap3: () {
                (isSignedIn)
                    ? Navigator.pushNamed(context, "/my-account")
                    : Navigator.pushNamed(context, "/sign-in");
              },
            )
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
