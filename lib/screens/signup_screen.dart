import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';
import 'package:musicart/services/firebase_auth_methods.dart';
import 'package:musicart/widgets/custom_passwordfield.dart';
import 'package:musicart/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String passwordStatus = "";
  int passwordStrength = 1;
  bool passwordsMatch = false;
  String passwordsMatchStatus = "";

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;

    //String password = "";
    //String confirmPassword = "";

    void getPasswordStatus(String pw) {
      if (pw.length >= 8) {
        setState(() {
          passwordStatus = "Strong Password";
          passwordStrength = 2;
        });
      } else if (pw.length >= 6 && pw.length <= 8) {
        setState(() {
          passwordStatus = "Weak Password";
          passwordStrength = 1;
        });
      }
    }

    bool doPasswordsMatch(String pw, String cpw) {
      if (pw == cpw) {
        return true;
      }
      return false;
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "./assets/images/sign_up.png",
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
              ),
              // SizedBox(
              //   height: screenHeight * 0.02,
              // ),
              CustomTextField(
                width: screenWidth * 0.8,
                height: screenWidth * 0.8 / 6.8,
                textEditingController: _emailController,
                hintText: "Enter your email",
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
                onChanged: (p0) {
                  setState(() {
                    //password = p0;
                    getPasswordStatus(p0);
                    passwordStatus = passwordStatus;
                    passwordStrength = passwordStrength;
                    print(
                        "$passwordStatus, $passwordStrength, ${_passwordController.text}, $p0");
                  });
                },
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      passwordStatus,
                      style: globalTextStyle.copyWith(
                          fontSize: screenWidth * 0.02,
                          color: (passwordStrength == 2)
                              ? Colors.green
                              : Colors.orange),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              CustomPasswordField(
                width: screenWidth * 0.8,
                height: screenWidth * 0.8 / 6.8,
                textEditingController: _confirmPasswordController,
                hintText: "Confirm password",
                isObscured: true,
                onChanged: (p0) {
                  setState(() {
                    //confirmPassword = p0;
                    passwordsMatch =
                        doPasswordsMatch(p0, _passwordController.text);
                    passwordsMatchStatus = (passwordsMatch)
                        ? "Passwords match"
                        : "Passwords do not match";
                    print(
                        "$p0, ${_passwordController.text}, $passwordsMatchStatus, $passwordsMatch");
                  });
                },
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      passwordsMatchStatus,
                      style: globalTextStyle.copyWith(
                        fontSize: screenWidth * 0.02,
                        color: (passwordsMatch) ? Colors.green : Colors.red,
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
                    signUpUser();
                  },
                  child: Text(
                    "Sign up",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: globalTextStyle.copyWith(
                        color: Colors.grey, fontSize: screenWidth * 0.03),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/sign-in");
                    },
                    child: Text(
                      "Sign in.",
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
        ),
      ),
    );
  }
}
