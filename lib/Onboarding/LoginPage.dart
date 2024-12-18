import 'dart:ui';

import 'package:aspire/ProfileExtras/TermsOfService.dart';
import 'package:aspire/Utils/appNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aspire/Utils/appControl.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isLoggingIn = false;

  void setPreference(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('LoggedInUser', username);
  }

  void getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('LoggedInUser');
    if (value != null) {
      String stringValue = value.toString();

      setState(() {
        AppControl.loggedInUser = stringValue;
        isLoggingIn = false;
      });

      Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: widget,
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 200),
            child: AppNavigation(),
          ),
          (Route) => false);
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      await Firebase.initializeApp();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        setState(() {
          isLoggingIn = true;
        });
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final User? user = userCredential.user;
        if (user != null) {
          await saveUserDataToFirestore(user);
        }
        return user;
      } else {
        Fluttertoast.showToast(
            msg: "Sigining in Failed!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } catch (e) {
      // print('Error signing in with Google: $e');
      throw FirebaseAuthException(
          message: 'Failed to sign in with Google: $e',
          code: 'google_sign_in_error');
    }
  }

  Future<void> saveUserDataToFirestore(User user) async {
    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection('userData').doc(user.email).get();
      if (!userDoc.exists) {
        await _firestore.collection('userData').doc(user.email).set({
          'name': user.displayName,
          'email': user.email,
          'photo': user.photoURL,
          'hasBuilt': false,
          'savedDetails': [],
          'savedResume': [],
          'referralCode': '',
          'rewardPoints': 0.0,
          "countryCode": window.locale.countryCode ?? 'Unknown',
          "accountCreationDate": DateTime.now()
        });

        setPreference(user.email.toString());
        getPreference();

        // print('User data saved to Firestore');
      } else {
        // print('User data already exists in Firestore');
        setPreference(user.email.toString());
        getPreference();
      }
    } catch (e) {
      // print('Error saving user data to Firestore: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      // print('User signed out');
    } catch (e) {
      // print('Error signing out: $e');
    }
  }

  double leftTurn = 0.0;
  double rightTurn = 0.0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF00E784),
          Color(0xFFA6EDF2),
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120.h,
              ),
              Center(
                child: Image.asset(
                  "assets/logos/LOGOFullPNG.png",
                  height: 80.h,
                  width: 200.w,
                  color: Colors.black,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              Text(
                "Create Resumes That Get Noticed",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 22.sp),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  "Craft eye-catching resumes that grab the attention of employers and land your dream job with aspire.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              isLoggingIn
                  ? Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.black),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 18.h,
                                  width: 18.w,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.w,
                                      backgroundColor: Colors.white12,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text(
                                  "Signing you in",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                )
                              ],
                            )),
                      ),
                    )
                  : InkWell(
                      onTap: () => signInWithGoogle(),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.black),
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/google.png",
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        childCurrent: widget,
                        duration: const Duration(milliseconds: 120),
                        reverseDuration: const Duration(milliseconds: 120),
                        child: const TermOfService(),
                      ),
                    );
                  },
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'By tapping "Sign in", you agree to our ',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp),
                          children: [
                            TextSpan(
                                text: "Terms",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text:
                                    ". learn how we process your data in our ",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                )),
                            TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text: " and ",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                )),
                            TextSpan(
                                text: "Terms and Contidions",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text: ".",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                )),
                          ])),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
