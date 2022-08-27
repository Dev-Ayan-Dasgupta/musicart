import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';
import 'package:musicart/screens/account_screen.dart';
import 'package:musicart/services/firebase_auth_methods.dart';
import 'package:musicart/utils/show_snackbar.dart';
import 'package:musicart/widgets/custom_divider.dart';
import 'package:musicart/widgets/custom_textfield.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../models/customer_model.dart';

class PhoneSigninScreen extends StatefulWidget {
  const PhoneSigninScreen({Key? key}) : super(key: key);

  @override
  State<PhoneSigninScreen> createState() => _PhoneSigninScreenState();
}

class _PhoneSigninScreenState extends State<PhoneSigninScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  String verificationCode = "";
  String phn = "";

  phoneLogin(
    BuildContext context,
    String? phoneNumber,
  ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        showSnackBar(context, e.message!);
      },
      codeSent: (String verificationID, int? resendToken) {
        verificationCode = verificationID;
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        //verificationCode = verificationID;
      },
      timeout: const Duration(seconds: 120),
    );
  }

  late Timer _timer;
  int start = 60;
  String resendMessage = "";
  //bool timerStarted = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (start == 0) {
        setState(() {
          _timer.cancel();
          (start == 0)
              ? resendMessage = "Haven't received OTP? Resend."
              : (start >= 10)
                  ? resendMessage = " Resend OTP in 00:$start"
                  : resendMessage = " Resend OTP in 00:0$start";
        });
      } else {
        setState(() {
          start--;
          (start == 0)
              ? resendMessage = "Haven't received OTP? Resend."
              : (start >= 10)
                  ? resendMessage = " Resend OTP in 00:$start"
                  : resendMessage = " Resend OTP in 00:0$start";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const AccountScreen();
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your phone number",
                  style: globalTextStyle.copyWith(
                      color: primaryColor, fontSize: screenWidth * 0.03),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                CustomTextField(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.8 / 6.8,
                  textEditingController: _phoneController,
                  hintText: "e.g., 6290986442",
                  keyboardType: TextInputType.number,
                  iconData: Icons.phone_android_rounded,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.8 / 6.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      phoneLogin(context, "+91${_phoneController.text}");

                      setState(() {
                        phn = _phoneController.text;
                      });

                      if (start == 0) {
                        start = 60;
                      }

                      startTimer();
                    },
                    child: Text(
                      "Generate OTP",
                      style: globalTextStyle.copyWith(
                        color: tertiaryColor,
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                CustomDivider(
                  content: "Enter OTP received on +91-$phn",
                  width: screenWidth * 0.05,
                  fontSize: screenWidth * 0.025,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: screenWidth * 0.11,
                    height: screenWidth * 0.11,
                    textStyle: globalTextStyle.copyWith(
                      fontSize: screenWidth * 0.03,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  controller: _otpController,
                  onChanged: (pin) {},
                  onSubmitted: (pin) async {
                    try {
                      UserCredential cred = await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: verificationCode, smsCode: pin));

                      Customer customer = Customer(
                        uid: cred.user!.uid,
                        username: cred.user!.phoneNumber!,
                        cart: [],
                        cartMap: [],
                        cartValue: 0.0,
                        wish: [],
                        orders: [],
                        // ordersMap: [],
                        // orderDate: [],
                        cards: [],
                        banks: [],
                        addresses: [],
                        currAddress: [],
                      );

                      await FirebaseFirestore.instance
                          .collection('customers')
                          .doc(cred.user!.uid)
                          .set(customer.toJson());
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }
                  },
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.8 / 6.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () async {
                      try {
                        UserCredential cred = await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationCode,
                          smsCode: _otpController.text,
                        ));

                        Customer customer = Customer(
                            uid: cred.user!.uid,
                            username: cred.user!.email!,
                            cart: [],
                            cartMap: [],
                            cartValue: 0.0,
                            wish: [],
                            orders: [],
                            // ordersMap: [],
                            // orderDate: [],
                            cards: [],
                            banks: [],
                            addresses: [],
                            currAddress: []);

                        await FirebaseFirestore.instance
                            .collection('customers')
                            .doc(cred.user!.uid)
                            .set(customer.toJson());
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
                      //Navigator.pushNamed(context, "/home");
                    },
                    child: Text(
                      "Submit OTP",
                      style: globalTextStyle.copyWith(
                        color: tertiaryColor,
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                InkWell(
                  onTap: () {
                    if (start == 0) {
                      phoneLogin(context, "+91${_phoneController.text}");

                      setState(() {
                        phn = _phoneController.text;
                      });

                      if (start == 0) {
                        start = 60;
                      }

                      startTimer();
                    }
                  },
                  child: Text(
                    resendMessage,
                    style: globalTextStyle.copyWith(
                      color: Colors.blueGrey,
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    )));
  }
}
