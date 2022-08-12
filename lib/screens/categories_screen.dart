import 'package:flutter/material.dart';
import 'package:musicart/widgets/category_tile.dart';

import '../global_variables/global_variables.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _searchBoxController = TextEditingController();

  final String _hintText = "Search instruments...";

  int _currentIndex = 1;

  int _crossAxisCount = 0;

  int getCrossAxisCount(double sw) {
    if (sw < 720) {
      return 3;
    } else if (sw > 720 && sw < 1000) {
      return 4;
    } else {
      return 5;
    }
  }

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
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: getCrossAxisCount(screenWidth),
                      crossAxisSpacing: screenWidth * 0.025,
                      mainAxisSpacing: screenWidth * 0.025,
                      children:
                          List.generate(categoryTileImageUrls.length, (index) {
                        return CategoryTile(
                          onTap: () {
                            Navigator.pushNamed(context,
                                categoryTileImageUrls[index].routeName);
                          },
                          tileImageUrl: categoryTileImageUrls[index].imgUrl,
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.3,
                          title: categoryTileImageUrls[index].title,
                          fontSize: screenWidth * 0.03,
                          titlePosition: screenWidth * 0.04,
                        );
                      }),
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
