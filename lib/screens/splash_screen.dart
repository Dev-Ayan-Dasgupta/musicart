import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _imageAnimationController;
  late final Animation _imageWidthAnimation;
  late final Animation _imageHeightAnimation;
  late final AnimationController _progressAnimationController;
  late final Animation _progressLengthAnimation;

  @override
  void initState() {
    super.initState();
    _imageAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _imageWidthAnimation = Tween<double>(begin: 36, end: 150).animate(
        CurvedAnimation(
            parent: _imageAnimationController, curve: Curves.easeInQuad));
    _imageHeightAnimation = Tween<double>(begin: 18, end: 70).animate(
        CurvedAnimation(
            parent: _imageAnimationController, curve: Curves.easeInQuad));
    _progressAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _progressLengthAnimation = Tween<double>(begin: 0, end: 120).animate(
        CurvedAnimation(
            parent: _progressAnimationController, curve: Curves.easeInExpo));

    _imageAnimationController.addListener(() {
      setState(() {});
    });

    _progressAnimationController.addListener(() {
      setState(() {});
    });

    _imageAnimationController.forward();
    _progressAnimationController.forward();

    Timer(const Duration(milliseconds: 3500),
        () => Navigator.pushNamed(context, "/home"));
  }

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: primaryColor,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.4),
                ),
                Container(
                  width: _imageWidthAnimation.value,
                  height: _imageHeightAnimation.value,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("./assets/images/logo.png"),
                      fit: BoxFit.fill,
                      invertColors: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.033),
                ),
                Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 3,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: _progressLengthAnimation.value,
                      height: 3,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                      //color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
