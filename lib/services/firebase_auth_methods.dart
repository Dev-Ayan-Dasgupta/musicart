import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musicart/global_variables/global_variables.dart';

import '../models/customer_model.dart';
import '../utils/show_snackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  //STATE PERSISTANCE
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  //GET USER
  User? get user => _auth.currentUser;

  //SIGN UP EMAIL
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Customer customer = Customer(
        uid: cred.user!.uid,
        username: cred.user!.email!,
        cart: [],
        wish: [],
        orders: [],
        cards: [],
        banks: [],
        addresses: [],
      );

      await FirebaseFirestore.instance
          .collection('customers')
          .doc(cred.user!.uid)
          .set(customer.toJson());

      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent');
      print("Email verification sent");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      print(e.message);
    }
  }

  //LOGIN EMAIL
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //GOOGLE SIGN-IN
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          //create a new credential
          final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken);
          UserCredential cred = await _auth.signInWithCredential(credential);

          Customer customer = Customer(
            uid: cred.user!.uid,
            username: cred.user!.email!,
            cart: [],
            wish: [],
            orders: [],
            cards: [],
            banks: [],
            addresses: [],
          );

          await FirebaseFirestore.instance
              .collection('customers')
              .doc(cred.user!.uid)
              .set(customer.toJson());

          //if we want to SignUp with Google (not SignIn)
          // if (userCredential.user != null) {
          //   if (userCredential.additionalUserInfo!.isNewUser) {}
          // }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //FACEBOOK SIGN IN
  Future<void> loginWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //PHONE SIGNIN
  phoneLogin(BuildContext context, String? phoneNumber,
      String verificationCode) async {
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

  //ANONYMOUS SIGN IN
  Future<void> loginAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
