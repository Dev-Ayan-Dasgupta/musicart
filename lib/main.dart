import 'package:flutter/material.dart';
import 'package:musicart/screens/account_screen.dart';
import 'package:musicart/screens/acoustic_guitars_screen.dart';
import 'package:musicart/screens/add_card_screen.dart';
import 'package:musicart/screens/bank_list_screen.dart';
import 'package:musicart/screens/bass_guitars_screen.dart';
import 'package:musicart/screens/categories_screen.dart';
import 'package:musicart/screens/drums_screen.dart';
import 'package:musicart/screens/order_history_screen.dart';
import 'package:musicart/screens/payments_screen.dart';
import 'package:musicart/screens/search_instrument_screen.dart';

import 'screens/electric_guitar_screen.dart';
import 'screens/home_welcome_screen.dart';
//import '/screens/screen2.dart';
//import '/screens/screen_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musicart',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomeWelcomeScreen(),
      initialRoute: "/",
      routes: {
        // "/": (context) => const HomeWelcomeScreen(),
        "/categories": (context) => const CategoriesScreen(),
        // "/instrumentDetail": (context) => const InstrumentDetail(),
        "/acoustic-guitars": (context) => const AcousticGuitarsScreen(),
        "/electric-guitars": (context) => const ElectricGuitarsScreen(),
        "/bass-guitars": (context) => const BassGuitarsScreen(),
        "/drums": (context) => const DrumsScreen(),
        "/search": (context) => const SearchInstrumentScreen(),
        "/my-account": (context) => const AccountScreen(),
        "/payments": (context) => const PaymentsScreen(),
        "/bank-list": (context) => const BankListScreen(),
        "/add-card": (context) => const AddCardScreen(),
        "/orders-history": (context) => const OrderHistoryScreen(),
      },
    );
  }
}
