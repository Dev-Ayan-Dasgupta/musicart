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
                      // context.read<FirebaseAuthMethods>().phoneLogin(
                      //     context, "+91${_phoneController.text}", verificationCode);
                      setState(() {
                        phn = _phoneController.text;
                      });

                      //Navigator.pushNamed(context, "/home");
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
                  onChanged: (pin) {
                    print(_otpController.text);
                    print(verificationCode);
                  },
                  onSubmitted: (pin) async {
                    try {
                      print(verificationCode);
                      await FirebaseAuth.instance.signInWithCredential(
                          PhoneAuthProvider.credential(
                              verificationId: verificationCode, smsCode: pin));
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
                        print(verificationCode);
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationCode,
                          smsCode: _otpController.text,
                        ));
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
                  onTap: () {},
                  child: Text(
                    "Haven't received OTP? Resend.",
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
