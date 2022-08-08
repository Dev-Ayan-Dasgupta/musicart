import 'package:flutter/material.dart';

class AcousticGuitarsScreen extends StatefulWidget {
  const AcousticGuitarsScreen({Key? key}) : super(key: key);

  @override
  State<AcousticGuitarsScreen> createState() => _AcousticGuitarsScreenState();
}

class _AcousticGuitarsScreenState extends State<AcousticGuitarsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("This is Acoustic Guitars Screen"),
    );
  }
}
