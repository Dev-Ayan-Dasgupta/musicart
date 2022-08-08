import 'package:flutter/material.dart';

class BassGuitarsScreen extends StatefulWidget {
  const BassGuitarsScreen({Key? key}) : super(key: key);

  @override
  State<BassGuitarsScreen> createState() => _BassGuitarsScreenState();
}

class _BassGuitarsScreenState extends State<BassGuitarsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("This is Bass Guitars Screen"),
    );
  }
}
