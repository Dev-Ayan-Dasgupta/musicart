import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicart/screens/signin_screen.dart';
import 'package:musicart/utils/show_snackbar.dart';

import '../global_variables/global_variables.dart';
import '../widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      showSnackBar(context, "Password reset email sent");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
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
            return const SignInScreen();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "./assets/images/forgot_password.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                  CustomTextField(
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.8 / 6.8,
                    textEditingController: _emailController,
                    hintText: "Enter your email",
                    iconData: Icons.email_rounded,
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
                        resetPassword();
                        Navigator.pushNamed(context, "sign-in");
                      },
                      child: Text(
                        "Reset password",
                        style: globalTextStyle.copyWith(
                          color: tertiaryColor,
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
