import 'dart:async';
import 'package:aspire/Onboarding/LoginPage.dart';
import 'package:aspire/Utils/appControl.dart';
import 'package:aspire/Utils/appNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    toHomePage();
  }

  void toHomePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? LoggedInUser = prefs.getString('LoggedInUser');
    if (LoggedInUser == null || LoggedInUser == "") {
      Timer(const Duration(milliseconds: 3232), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      });
    } else {
      Timer(const Duration(milliseconds: 3232), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AppNavigation()));
      });
      String? value = prefs.getString('LoggedInUser');
      if (value != null) {
        String stringValue = value.toString();
        print(stringValue);
        setState(() {
          AppControl.loggedInUser = stringValue;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFFE8E8E8),
    ));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Lottie.asset("assets/animations/splashScreen.json",
              fit: BoxFit.cover,
              height: 825.4.h,
              width: 392.7.w,
              repeat: false)),
    );
  }
}
