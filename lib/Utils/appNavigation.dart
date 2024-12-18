import 'dart:async';
import 'package:aspire/HomePage.dart';
import 'package:aspire/profilePage.dart';
import 'package:aspire/savePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late StreamSubscription internetSubscription;

  var hasInternet = true;
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  List<Widget> body = [const HomePage(), const SavePage(), const ProfilePage()];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white, // Set the color here
    ));
    return hasInternet
        ? Scaffold(
            body: IndexedStack(
              index: selectIndex,
              children: body,
            ),
            bottomNavigationBar: BottomNavigationBar(
              iconSize: ScreenUtil().setSp(28),
              enableFeedback: false,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 32,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              selectedLabelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              unselectedLabelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              unselectedItemColor: Colors.black54,
              type: BottomNavigationBarType.fixed,
              onTap: changeTab,
              currentIndex: selectIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/icons/homeIcon.png",
                      width: 22.w,
                      height: 30.h,
                      color: selectIndex == 0 ? Colors.black : Colors.black54,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/icons/saveIcon.png",
                      width: 22.w,
                      height: 30.h,
                      color: selectIndex == 1 ? Colors.black : Colors.black54,
                    ),
                    label: "Saved"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/icons/profileIcon.png",
                      width: 22.w,
                      height: 30.h,
                      color: selectIndex == 2 ? Colors.black : Colors.black54,
                    ),
                    label: "Profile"),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Image.asset(
                  "assets/logos/LOGOFullPNG.png",
                  color: Colors.black,
                  height: 52.h,
                  width: 148.w,
                  fit: BoxFit.cover,
                )),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/offline.jpg",
                    height: 240.h,
                    width: 392.72.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Something went wrong",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Please check your internet connection and try again.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17.sp),
                    ),
                  )
                ],
              ),
            ));
  }

  void changeTab(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
