import 'package:flutter/material.dart';

class ElectricGuitarsScreen extends StatefulWidget {
  const ElectricGuitarsScreen({Key? key}) : super(key: key);

  @override
  State<ElectricGuitarsScreen> createState() => _ElectricGuitarsScreenState();
}

class _ElectricGuitarsScreenState extends State<ElectricGuitarsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("This is Electric Guitars Screen"),
    );
  }
}
