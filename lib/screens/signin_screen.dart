import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicart/main.dart';
import 'package:musicart/screens/account_screen.dart';
import 'package:musicart/services/firebase_auth_methods.dart';
import 'package:musicart/utils/show_snackbar.dart';
import 'package:musicart/widgets/custom_divider.dart';
import 'package:musicart/widgets/custom_rounded_button.dart';
import 'package:provider/provider.dart';

import '../global_variables/global_variables.dart';
import '../widgets/custom_passwordfield.dart';
import '../widgets/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signInUser() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    context.read<FirebaseAuthMethods>().loginWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context);

    navigatorKey.currentState!.popUntil((route) => route.isCurrent);
    //Navigator.popUntil(context, ModalRoute.withName("/my-account"));
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
            }
            // else if (snapshot.hasError) {
            //   return const Center(
            //     child: Text("Something went wrong"),
            //   );
            // } else if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(
            //     child: CircularProgressIndicator(
            //       color: primaryColor,
            //     ),
            //   );
            // }
            else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "./assets/images/sign_in.png",
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
                    CustomPasswordField(
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8 / 6.8,
                      textEditingController: _passwordController,
                      hintText: "Enter a password",
                      isObscured: true,
                      onChanged: (p0) {},
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/forgot-password");
                            },
                            child: Text(
                              "Forgot password?",
                              style: globalTextStyle.copyWith(
                                fontSize: screenWidth * 0.02,
                                color: Colors.blueGrey,
                                //decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          signInUser();
                          //Navigator.pushNamed(context, "/home");
                        },
                        child: Text(
                          "Sign in",
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
                      content: "Alternatively, sign in using",
                      width: screenWidth * 0.1,
                      fontSize: screenWidth * 0.025,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          width: screenWidth * 0.1,
                          height: screenWidth * 0.1,
                          onTap: () {
                            context
                                .read<FirebaseAuthMethods>()
                                .loginWithGoogle(context);
                            //Navigator.pushNamed(context, "/home");
                            //Navigator.pop(context);
                          },
                          url:
                              "https://cdn.icon-icons.com/icons2/2631/PNG/512/google_search_new_logo_icon_159150.png",
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        RoundedButton(
                          width: screenWidth * 0.1,
                          height: screenWidth * 0.1,
                          onTap: () {
                            context
                                .read<FirebaseAuthMethods>()
                                .loginWithFacebook(context);
                            //Navigator.pushNamed(context, "/home");
                          },
                          url:
                              "https://seeklogo.com/images/F/facebook-icon-circle-logo-09F32F61FF-seeklogo.com.png",
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        RoundedButton(
                          width: screenWidth * 0.1,
                          height: screenWidth * 0.1,
                          onTap: () {
                            Navigator.pushNamed(context, "/phone-signin");
                          },
                          url:
                              "https://banner2.cleanpng.com/20180602/pbz/kisspng-computer-icons-logo-advertising-5b13535ab57462.9984729015279931787433.jpg",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<FirebaseAuthMethods>()
                            .loginAnonymously(context);
                      },
                      child: CustomDivider(
                        content: "Sign in anonymously",
                        width: screenWidth * 0.105,
                        fontSize: screenWidth * 0.03,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: globalTextStyle.copyWith(
                              color: Colors.grey, fontSize: screenWidth * 0.03),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/sign-up");
                          },
                          child: Text(
                            "Sign up.",
                            style: globalTextStyle.copyWith(
                              color: Colors.black,
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
