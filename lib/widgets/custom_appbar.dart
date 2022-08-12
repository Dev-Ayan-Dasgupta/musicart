import 'package:flutter/material.dart';
import 'package:musicart/screens/cart_screen.dart';
import 'package:musicart/widgets/search_widget.dart';

import '../global_variables/global_variables.dart';
import '../screens/wishlist_screen.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required TextEditingController searchBoxController,
    required String hintText,
  })  : _searchBoxController = searchBoxController,
        _hintText = hintText,
        super(key: key);

  final double? screenWidth;
  final double? screenHeight;
  final TextEditingController _searchBoxController;
  final String _hintText;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.screenHeight! * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: widget.screenWidth! * 0.025),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: widget.screenWidth! * 0.05,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: widget.screenWidth! * 0.025,
                right: widget.screenWidth! * 0.33),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/");
              },
              child: Image(
                image: const AssetImage("./assets/images/logo.png"),
                height: 40,
                width: widget.screenWidth! * 0.25,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: widget.screenWidth! * 0.025),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/search");
              },
              child: Icon(
                Icons.search_rounded,
                color: Colors.black,
                size: widget.screenWidth! * 0.08,
              ),
            ),
            // SearchWidget(
            //   width: widget.screenWidth! * 0.3,
            //   onChanged: (p0) {},
            //   searchController: widget._searchBoxController,
            //   onTap: () {
            //     Navigator.pushNamed(context, "/search");
            //   },
            //   hintText: widget._hintText,
            // ),
          ),
          Padding(
            padding: EdgeInsets.only(right: widget.screenWidth! * 0.025),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WishListScreen(mywishList: wishList[0])));
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.black87,
                    size: widget.screenWidth! * 0.08,
                  ),
                  Positioned(
                    top: widget.screenWidth! * 0.0075,
                    right: widget.screenWidth! * 0.0025,
                    child: Container(
                      width: widget.screenWidth! * 0.025,
                      height: widget.screenWidth! * 0.025,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (wishList.isNotEmpty)
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  Positioned(
                    top: widget.screenWidth! * 0.0075,
                    right: widget.screenWidth! * 0.0025,
                    child: Container(
                      width: widget.screenWidth! * 0.02,
                      height: widget.screenWidth! * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (wishList.isNotEmpty)
                            ? Colors.red.shade900
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: widget.screenWidth! * 0.025),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CartScreen(mycartList: cartList)));
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black87,
                    size: widget.screenWidth! * 0.08,
                  ),
                  Positioned(
                    top: widget.screenWidth! * 0.0075,
                    right: widget.screenWidth! * 0.005,
                    child: Container(
                      width: widget.screenWidth! * 0.025,
                      height: widget.screenWidth! * 0.025,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (cartList.isNotEmpty)
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  Positioned(
                    top: widget.screenWidth! * 0.0075,
                    right: widget.screenWidth! * 0.005,
                    child: Container(
                      width: widget.screenWidth! * 0.02,
                      height: widget.screenWidth! * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (cartList.isNotEmpty)
                            ? Colors.blue.shade900
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
