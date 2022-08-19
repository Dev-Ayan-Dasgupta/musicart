import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:musicart/firebase_options.dart';
import 'package:musicart/screens/account_screen.dart';
import 'package:musicart/screens/acoustic_guitars_screen.dart';
import 'package:musicart/screens/add_card_screen.dart';
import 'package:musicart/screens/bank_list_screen.dart';
import 'package:musicart/screens/bass_guitars_screen.dart';
import 'package:musicart/screens/cart_screen.dart';
import 'package:musicart/screens/categories_screen.dart';
import 'package:musicart/screens/choose_address.dart';
import 'package:musicart/screens/create_address.dart';
import 'package:musicart/screens/drums_screen.dart';
import 'package:musicart/screens/forgot_password.dart';
import 'package:musicart/screens/order_history_screen.dart';
import 'package:musicart/screens/payments_screen.dart';
import 'package:musicart/screens/phone_signin_screen.dart';
import 'package:musicart/screens/search_instrument_screen.dart';
import 'package:musicart/screens/signup_screen.dart';
import 'package:musicart/screens/splash_screen.dart';
import 'package:musicart/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'screens/electric_guitar_screen.dart';
import 'screens/home_welcome_screen.dart';
import 'screens/signin_screen.dart';
import 'services/firebase_auth_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await FacebookAuth.i.webInitialize(
        appId: "796622648034407", cookie: true, xfbml: true, version: "v13.0");
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Musicart',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const AuthWrapper(),
        initialRoute: "/",
        routes: {
          "/home": (context) => const HomeWelcomeScreen(),
          // "/": (context) => const HomeWelcomeScreen(),
          "/categories": (context) => const CategoriesScreen(),
          // "/instrumentDetail": (context) => const InstrumentDetail(),
          "/acoustic-guitars": (context) => const AcousticGuitarsScreen(),
          "/electric-guitars": (context) => const ElectricGuitarsScreen(),
          "/bass-guitars": (context) => const BassGuitarsScreen(),
          "/drums": (context) => const DrumsScreen(),
          "/search": (context) => const SearchInstrumentScreen(),
          "/wishlist": (context) => const WishListScreen(),
          "/cart": (context) => const CartScreen(),
          "/my-account": (context) => const AccountScreen(),
          "/payments": (context) => const PaymentsScreen(),
          "/bank-list": (context) => const BankListScreen(),
          "/add-card": (context) => const AddCardScreen(),
          "/orders-history": (context) => const OrderHistoryScreen(),
          "/select-address": (context) => const ChooseAddressScreen(),
          "/add-address": (context) => const CreateAddressScreen(),
          "/sign-up": (context) => const SignUpScreen(),
          "/sign-in": (context) => const SignInScreen(),
          "/forgot-password": (context) => const ForgotPasswordScreen(),
          "/phone-signin": (context) => const PhoneSigninScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeWelcomeScreen();
    }
    return const SplashScreen();
  }
}
