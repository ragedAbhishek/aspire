import 'package:aspire/ProfileExtras/AboutPage.dart';
import 'package:aspire/ProfileExtras/Feedback.dart';
import 'package:aspire/ProfileExtras/TermsOfService.dart';
import 'package:aspire/Utils/appControl.dart';
import 'package:aspire/Utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color baseColor = const Color.fromARGB(31, 53, 53, 53);
  Color highlightColor = Colors.white10;
  final googlePlayUrl =
      "https://play.google.com/store/apps/details?id=com.airesumebuilderapp.aspire";

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch URL";
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('userData')
            .doc(AppControl.loggedInUser.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            //***************************************** HOMEPAGE LOADING SCREEN ***********************************************/
            return Scaffold(
                backgroundColor: Colors.white,
                body: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Center(
                            child: Container(
                              height: 32,
                              width: 152,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Center(
                            child: Container(
                              height: 32,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Center(
                            child: Container(
                              height: 14,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Center(
                            child: Container(
                              height: 14,
                              width: 310,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4.r)),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Center(
                            child: Container(
                              height: 14,
                              width: 310,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4.r)),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Center(
                            child: Container(
                              height: 14,
                              width: 240,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4.r)),
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                          Container(
                            height: 32,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20.h),
                            leading: Container(
                              height: 52.h,
                              width: 52.w,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Container(
                                    height: 24,
                                    width: 240,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(4.r)),
                                  ),
                                ),
                                Container(
                                  height: 24,
                                  width: 132,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4.r)),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20.h),
                            leading: Container(
                              height: 52.h,
                              width: 52.w,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Container(
                                    height: 24,
                                    width: 240,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(4.r)),
                                  ),
                                ),
                                Container(
                                  height: 24,
                                  width: 132,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4.r)),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20.h),
                            leading: Container(
                              height: 52.h,
                              width: 52.w,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Container(
                                    height: 24,
                                    width: 240,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(4.r)),
                                  ),
                                ),
                                Container(
                                  height: 24,
                                  width: 132,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4.r)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          }

          var data = snapshot.data!.data()!;

          // String name = data['name'] ?? '';
          double rewardPoints = data['rewardPoints'] ?? 0.00;
          String referralCode = data['referralCode'] ?? '';
          bool hasBuilt = data['hasBuilt'] ?? false;
          String countryCode = data["countryCode"] ?? "";
          // List savedDetails = data["savedDetails"] ?? [];
          // List savedResume = data["savedResume"] ?? [];

          return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      hasBuilt
                          ? shareTextAndImage(
                              context,
                              "*What's holding you back from landing your dream job?*\n\nIt's the ATS, or Application Tracking System. But why? Because in today's job market, a staggering 90% of resumes are checked by ATS software before they even reach the eye of hiring team.\n\nDownload Aspire to build awesome high ATS resume now: https://play.google.com/store/apps/details?id=com.airesumebuilderapp.aspire\n\nUse my refferal code *$referralCode* to get 50% off on your first resume.",
                              "assets/logos/appIconBLACKBG.png")
                          : shareTextAndImage(
                              context,
                              "*What's holding you back from landing your dream job?*\n\nIt's the ATS, or Application Tracking System. But why? Because in today's job market, a staggering 90% of resumes are checked by ATS software before they even reach the eye of hiring tech team.\n\nDownload Aspire to build awesome high ATS resume now: https://play.google.com/store/apps/details?id=com.airesumebuilderapp.aspire .",
                              "assets/logos/appIconBLACKBG.png");
                    },
                    child: Container(
                      height: 212,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/profileCards.png"),
                              fit: BoxFit.cover),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFd4efd9), Colors.white])),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Reward Points",
                                style: TextStyle(
                                    color: const Color(0xFF00493E),
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text:
                                    "\n${countryCodeToCurrency(countryCode)} ${rewardPoints.toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Colors.black,
                                    height: 1.4,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28.sp))
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        hasBuilt
                            ? Center(
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Your Referral code is ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 63, 74, 84),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.sp)),
                                  TextSpan(
                                      text: referralCode,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 63, 74, 84),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp)),
                                ])),
                              )
                            : Center(
                                child: Text("Create resume to earn points.",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 63, 74, 84),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.sp))),
                        SizedBox(
                          height: 12.h,
                        ),
                        Center(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "Share Aspire with your friends! Ask them to use your referral code, they will get ",
                                    style: TextStyle(
                                        color: const Color(0xFF637484),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp)),
                                TextSpan(
                                    text: "50% off",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 63, 74, 84),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.sp)),
                                TextSpan(
                                    text: ", and you will get ",
                                    style: TextStyle(
                                        color: const Color(0xFF637484),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp)),
                                TextSpan(
                                    text: " equal reward points.",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 63, 74, 84),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.sp)),
                              ])),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Text(
                          "More",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.h),
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeftJoined,
                                childCurrent: widget,
                                duration: const Duration(milliseconds: 120),
                                reverseDuration:
                                    const Duration(milliseconds: 120),
                                child: const FeedBack(),
                              ),
                            );
                          },
                          leading: Icon(
                            Icons.feedback_outlined,
                            color: Colors.black,
                            size: ScreenUtil().setSp(32),
                          ),
                          title: Text(
                            "Feedback",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp),
                          ),
                          subtitle: Text("Send your valuable feedback to us.",
                              style: TextStyle(
                                  color: const Color(0xFF637484),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp)),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black54,
                            size: ScreenUtil().setSp(16),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeftJoined,
                                childCurrent: widget,
                                duration: const Duration(milliseconds: 120),
                                reverseDuration:
                                    const Duration(milliseconds: 120),
                                child: const AboutUs(),
                              ),
                            );
                          },
                          leading: Icon(
                            CupertinoIcons.exclamationmark_circle,
                            color: Colors.black,
                            size: ScreenUtil().setSp(32),
                          ),
                          title: Text(
                            "About us",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp),
                          ),
                          subtitle: Text("Know more about Aspire and our team.",
                              style: TextStyle(
                                  color: const Color(0xFF637484),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp)),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black54,
                            size: ScreenUtil().setSp(16),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeftJoined,
                                childCurrent: widget,
                                duration: const Duration(milliseconds: 120),
                                reverseDuration:
                                    const Duration(milliseconds: 120),
                                child: const TermOfService(),
                              ),
                            );
                          },
                          leading: Image.asset(
                            "assets/icons/document.png",
                            height: 28.h,
                            width: 28.w,
                            color: Colors.black,
                          ),
                          title: Text(
                            "Terms",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 19.sp),
                          ),
                          subtitle: Text("Terms of service and much more.",
                              style: TextStyle(
                                  color: const Color(0xFF637484),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp)),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black54,
                            size: ScreenUtil().setSp(16),
                          ),
                        ),
                        // ListTile(
                        //   contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //       PageTransition(
                        //         type: PageTransitionType.rightToLeftJoined,
                        //         childCurrent: widget,
                        //         duration: const Duration(milliseconds: 120),
                        //         reverseDuration:
                        //             const Duration(milliseconds: 120),
                        //         child: const FAQS(),
                        //       ),
                        //     );
                        //   },
                        //   leading: Image.asset(
                        //     "assets/icons/faq.png",
                        //     height: 28.h,
                        //     width: 28.w,
                        //     color: Colors.black54,
                        //   ),
                        //   title: Text(
                        //     "FAQ's",
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 19.sp),
                        //   ),
                        //   trailing: Icon(
                        //     Icons.arrow_forward_ios,
                        //     color: Colors.black54,
                        //     size: ScreenUtil().setSp(16),
                        //   ),
                        // ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                          onTap: () {
                            _launchUrl(googlePlayUrl);
                          },
                          leading: Image.asset(
                            "assets/icons/googlePlay.png",
                            height: 26.h,
                            width: 26.w,
                            color: Colors.black,
                          ),
                          title: Text(
                            "Rate us",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp),
                          ),
                          subtitle: Text("Rate Aspire on google Playstore.",
                              style: TextStyle(
                                  color: const Color(0xFF637484),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp)),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black54,
                            size: ScreenUtil().setSp(16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
