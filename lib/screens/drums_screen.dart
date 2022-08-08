import 'package:flutter/material.dart';

class DrumsScreen extends StatefulWidget {
  const DrumsScreen({Key? key}) : super(key: key);

  @override
  State<DrumsScreen> createState() => _DrumsScreenState();
}

class _DrumsScreenState extends State<DrumsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("This is Drums Screen"),
    );
  }
}
