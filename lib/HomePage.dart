import 'package:aspire/BuildExtras/ResumePreview.dart';
import 'package:aspire/ProfileExtras/AboutPage.dart';
import 'package:aspire/Utils/appControl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final googlePlayUrl =
      "https://play.google.com/store/apps/details?id=com.airesumebuilderapp.aspire";
  Color baseColor = const Color.fromARGB(31, 53, 53, 53);
  Color highlightColor = Colors.white10;
  @override
  void initState() {
    super.initState();
    versionCheck();
  }

  final resumeKey = GlobalKey();

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch URL";
    }
  }

  Future scrollToResume() async {
    final context = resumeKey.currentContext!;
    await Scrollable.ensureVisible(context,
        alignment: 0.4, duration: Duration(milliseconds: 800));
  }

  List sliderImages = [
    // T E M P L A T E   -   1

    {
      'assetName': "assets/resumePreview/resume1One.jpg",
      "option": 1,
      "hasImage": true,
      "isBlackNWhite": false,
      "detailsIND": [
        "assets/resumePreview/resume1One.jpg",
        "Classic Avantika Style Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume1One.jpg",
        "Classic Avantika Style Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 4,
      "educationMax": 3,
      "experiencePlusProjects": 5,
    },

    // T E M P L A T E   -   2

    {
      'assetName': "assets/resumePreview/resume2Two.jpg",
      "option": 2,
      "hasImage": true,
      "isBlackNWhite": true,
      "detailsIND": [
        "assets/resumePreview/resume2Two.jpg",
        "Big Deli Style Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume2Two.jpg",
        "Big Deli Style Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 7,
      "educationMax": 2,
      "experiencePlusProjects": 3,
    },

    // T E M P L A T E   -   3

    {
      'assetName': "assets/resumePreview/resume3Three.jpg",
      "option": 3,
      "hasImage": true,
      "isBlackNWhite": true,
      "detailsIND": [
        "assets/resumePreview/resume3Three.jpg",
        "Wallstreet Style Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume3Three.jpg",
        "Wallstreet Style Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 3,
      "educationMax": 3,
      "experiencePlusProjects": 5,
    },

    // T E M P L A T E   -   4

    {
      'assetName': "assets/resumePreview/resume4Four.jpg",
      "option": 4,
      "hasImage": false,
      "isBlackNWhite": false,
      "detailsIND": [
        "assets/resumePreview/resume4Four.jpg",
        "Bombay Cool Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume4Four.jpg",
        "Bombay Cool Resume",
        29.00,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 5,
      "educationMax": 2,
      "experiencePlusProjects": 5,
    },

    // T E M P L A T E   -   5

    {
      'assetName': "assets/resumePreview/resume5Five.jpg",
      "option": 5,
      "hasImage": false,
      "isBlackNWhite": false,
      "detailsIND": [
        "assets/resumePreview/resume5Five.jpg",
        "Uttar Noida Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume5Five.jpg",
        "Uttar Noida Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 4,
      "educationMax": 2,
      "experiencePlusProjects": 6,
    },

    // T E M P L A T E   -   6

    {
      'assetName': "assets/resumePreview/resume6Six.jpg",
      "option": 6,
      "hasImage": false,
      "isBlackNWhite": false,
      "detailsIND": [
        "assets/resumePreview/resume6Six.jpg",
        "Gurgoan Bold Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume6Six.jpg",
        "Gurgoan Bold Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 6,
      "educationMax": 3,
      "experiencePlusProjects": 3,
    },

    // T E M P L A T E   -   7

    {
      'assetName': "assets/resumePreview/resume7Seven.jpg",
      "option": 7,
      "hasImage": true,
      "isBlackNWhite": true,
      "detailsIND": [
        "assets/resumePreview/resume7Seven.jpg",
        "West Delhi Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume7Seven.jpg",
        "West Delhi Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 272,
      "skillMax": 5,
      "educationMax": 3,
      "experiencePlusProjects": 4,
    },

    // T E M P L A T E   -   8

    {
      'assetName': "assets/resumePreview/resume8Eight.jpg",
      "option": 8,
      "hasImage": false,
      "isBlackNWhite": false,
      "detailsIND": [
        "assets/resumePreview/resume8Eight.jpg",
        "Midtile Style Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume8Eight.jpg",
        "Midtile Style Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 5,
      "educationMax": 2,
      "experiencePlusProjects": 4,
    },

    // T E M P L A T E   -   9

    {
      'assetName': "assets/resumePreview/resume9Nine.jpg",
      "option": 9,
      "hasImage": false,
      "isBlackNWhite": false,
      "detailsIND": [
        "assets/resumePreview/resume9Nine.jpg",
        "White Field Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume9Nine.jpg",
        "White Field Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 7,
      "educationMax": 3,
      "experiencePlusProjects": 4,
    },

    // T E M P L A T E   -   10

    {
      'assetName': "assets/resumePreview/resume10Ten.jpg",
      "option": 10,
      "hasImage": false,
      "isBlackNWhite": false,
      "detailsIND": [
        "assets/resumePreview/resume10Ten.jpg",
        "South Bombay Resume",
        29.00,
      ],
      "detailsINTER": [
        "assets/resumePreview/resume10Ten.jpg",
        "South Bombay Resume",
        0.99,
      ],
      "professionSummaryMaxWord": 300,
      "skillMax": 5,
      "educationMax": 3,
      "experiencePlusProjects": 4,
    },
  ];

  void versionCheck() async {
    try {
      // Get the document snapshot
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('functionControl')
          .doc("appControlVar")
          .get();

      if (snapshot.exists) {
        if (AppControl.appBuildNo < snapshot.data()?['AppBuildNo']) {
          // ignore: use_build_context_synchronously
          showModalBottomSheet(
            backgroundColor: const Color(0xFF101010),
            context: context,
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28))),
                height: 300.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      const Divider(
                        color: Colors.black12,
                        thickness: 3,
                        endIndent: 120,
                        indent: 120,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "New designs are out !",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 28.sp),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        "New resume designs are available in new version of the app, please update app for best expereince",
                        style:
                            TextStyle(fontSize: 17.sp, color: Colors.black54),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          _launchUrl(googlePlayUrl);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF19AA33),
                              borderRadius: BorderRadius.circular(99.r)),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(),
                                  child: Icon(
                                    Ionicons.logo_google_playstore,
                                    color: Colors.white,
                                    size: 28.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text("Update Now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          )),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "I will update later",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp),
                            )),
                      ),
                      SizedBox(height: 12.h)
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          // print("Latest version");
        }
      }
    } catch (e) {
      // print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white, // Set the color here
    ));
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
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                child: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        SizedBox(
                          height: 352.h,
                          child: CarouselSlider.builder(
                            itemCount: 3,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                decoration: BoxDecoration(color: Colors.black),
                              );
                            },
                            options: CarouselOptions(
                              height: 352.h,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              viewportFraction: 0.7,
                              aspectRatio: 10 / 10,
                              autoPlay: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 52.h,
                        ),
                        Container(
                          height: 28.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6.r)),
                        ),
                        SizedBox(
                          height: 52.h,
                        ),
                        Container(
                          height: 440.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                          height: 28.h,
                          width: 252.w,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6.r)),
                        ),
                        SizedBox(
                          height: 72.h,
                        ),
                        Container(
                          height: 440.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                          height: 28.h,
                          width: 252.w,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6.r)),
                        ),
                        SizedBox(
                          height: 72.h,
                        ),
                        Container(
                          height: 440.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                          height: 28.h,
                          width: 252.w,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6.r)),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Container(
                          height: 700.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          var data = snapshot.data!.data()!;

          // String name = data['name'] ?? '';
          // List savedResume = data['savedResume'] ?? [];
          bool hasBuilt = data["hasBuilt"] ?? false;
          List savedDetails = data['savedDetails'] ?? [];
          double rewardPoints = data["rewardPoints"] ?? 0.00;
          String countryCode = data["countryCode"] ?? "";

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Image.asset(
                  "assets/logos/LOGOFullPNG.png",
                  color: Colors.black,
                  height: 52.h,
                  width: 118.w,
                  fit: BoxFit.cover,
                )),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          key: resumeKey,
                          height: 420.h,
                          child: CarouselSlider.builder(
                            itemCount: sliderImages.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type:
                                          PageTransitionType.rightToLeftJoined,
                                      childCurrent: widget,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      reverseDuration:
                                          const Duration(milliseconds: 200),
                                      child: ResumePreview(
                                        savedDetails: savedDetails,
                                        hasBuilt: hasBuilt,
                                        option: sliderImages[itemIndex]
                                            ['option']!,
                                        hasImage: sliderImages[itemIndex]
                                            ['hasImage']!,
                                        isBlackNWhite: sliderImages[itemIndex]
                                            ['isBlackNWhite']!,
                                        details: countryCode == "IN"
                                            ? sliderImages[itemIndex]
                                                ['detailsIND']!
                                            : sliderImages[itemIndex]
                                                ['detailsINTER']!,
                                        professionSummaryMaxWord:
                                            sliderImages[itemIndex]
                                                ['professionSummaryMaxWord']!,
                                        skillMax: sliderImages[itemIndex]
                                            ['skillMax']!,
                                        educationMax: sliderImages[itemIndex]
                                            ['educationMax']!,
                                        experiencePlusProjects:
                                            sliderImages[itemIndex]
                                                ['experiencePlusProjects']!,
                                        rewardPoints: rewardPoints,
                                        countryCode: countryCode,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 182, 182, 182)
                                          .withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 16,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]),
                                  child: Image.asset(
                                    sliderImages[itemIndex]['assetName']!,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 400,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              viewportFraction: 0.7,
                              aspectRatio: 10 / 10,
                              autoPlay: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          "Explore",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: sliderImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 24.h, horizontal: 20.w),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type:
                                          PageTransitionType.rightToLeftJoined,
                                      childCurrent: widget,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      reverseDuration:
                                          const Duration(milliseconds: 200),
                                      child: ResumePreview(
                                        savedDetails: savedDetails,
                                        hasBuilt: hasBuilt,
                                        option: sliderImages[index]['option']!,
                                        hasImage: sliderImages[index]
                                            ['hasImage']!,
                                        isBlackNWhite: sliderImages[index]
                                            ['isBlackNWhite']!,
                                        details: countryCode == "IN"
                                            ? sliderImages[index]['detailsIND']!
                                            : sliderImages[index]
                                                ['detailsINTER']!,
                                        professionSummaryMaxWord:
                                            sliderImages[index]
                                                ['professionSummaryMaxWord']!,
                                        skillMax: sliderImages[index]
                                            ['skillMax']!,
                                        educationMax: sliderImages[index]
                                            ['educationMax']!,
                                        experiencePlusProjects:
                                            sliderImages[index]
                                                ['experiencePlusProjects']!,
                                        rewardPoints: rewardPoints,
                                        countryCode: countryCode,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 8),
                                            ),
                                          ]),
                                      child: Image.asset(
                                          sliderImages[index]["assetName"]),
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Text(
                                      countryCode == "IN"
                                          ? sliderImages[index]['detailsIND'][1]
                                          : sliderImages[index]['detailsINTER']
                                              [1],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // SizedBox(
                        //   height: 72.h,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                        //   child: Text(
                        //     "From inspiration to creation.",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         height: 1.2.h,
                        //         color: Colors.black,
                        //         fontSize: 36.sp,
                        //         fontWeight: FontWeight.w800),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 52.h,
                        // ),
                        // Center(
                        //   child: InkWell(
                        //     onTap: () => scrollToResume(),
                        //     child: Container(
                        //       height: 356.h,
                        //       width: 356.w,
                        //       decoration: BoxDecoration(
                        //         color: Color(0xFFF5F5F5),
                        //         borderRadius: BorderRadius.circular(24.r),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 24.h,
                        // ),
                        // Center(
                        //     child: Text(
                        //   "Choose resume design",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 22.sp),
                        // )),
                        // SizedBox(
                        //   height: 12.h,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //   child: Text(
                        //     "Choose the resume you prefer, all our options achieve high ATS scores and are beautifully crafted.",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         color: Color(0xFF989898),
                        //         fontSize: 17.sp,
                        //         fontWeight: FontWeight.w400),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 52.h,
                        // ),
                        // Center(
                        //   child: Container(
                        //     height: 356.h,
                        //     width: 356.w,
                        //     decoration: BoxDecoration(
                        //         color: Color(0xFFF5F5F5),
                        //         borderRadius: BorderRadius.circular(24.r)),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 24.h,
                        // ),
                        // Center(
                        //     child: Text(
                        //   "Fill in you details",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 22.sp),
                        // )),
                        // SizedBox(
                        //   height: 12.h,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //   child: Text(
                        //     "Just fill in your details like you name, education, job title, experience, projects and certificate etc.",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         color: Color(0xFF989898),
                        //         fontSize: 17.sp,
                        //         fontWeight: FontWeight.w400),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 52.h,
                        // ),
                        // Center(
                        //   child: Container(
                        //     height: 356.h,
                        //     width: 356.w,
                        //     decoration: BoxDecoration(
                        //         color: Color(0xFFF5F5F5),
                        //         borderRadius: BorderRadius.circular(24.r)),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 24.h,
                        // ),
                        // Center(
                        //     child: Text(
                        //   "Download and Share",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 22.sp),
                        // )),
                        // SizedBox(
                        //   height: 12.h,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //   child: Text(
                        //     "Download your resume PDF and share it with your recruiter to land the dream job you aspire.",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         color: Color(0xFF989898),
                        //         fontSize: 17.sp,
                        //         fontWeight: FontWeight.w400),
                        //   ),
                        // ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Center(
                          child: Text(
                            '"Love what you do,\ndo what you love !"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Signatra',
                                height: 1.2.h,
                                color: Colors.black,
                                fontSize: 56.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            "Create high ATS resume from ASPIRE and get hired in your dream job.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF989898),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => scrollToResume(),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF111111),
                                    borderRadius: BorderRadius.circular(99.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.w, vertical: 14.h),
                                  child: Center(
                                    child: Text(
                                      "Build resume",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    childCurrent: widget,
                                    duration: const Duration(milliseconds: 120),
                                    reverseDuration:
                                        const Duration(milliseconds: 120),
                                    child: const AboutUs(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black12, width: 2.w),
                                    borderRadius: BorderRadius.circular(99.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.w, vertical: 12.h),
                                  child: Center(
                                      child: Text(
                                    "Why Aspire ?",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp),
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 72.h,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Color(0xFF111111)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 32.h,
                            ),
                            Image.asset(
                              "assets/logos/LOGO_WHITE.png",
                              color: Colors.white,
                              height: 70.h,
                              width: 70.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "Create awesome resumes that ",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: "aspire.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ])),
                            SizedBox(
                              height: 16.sp,
                            ),
                            Container(
                              height: 1.h,
                              width: 100.w,
                              color: Colors.white12,
                            ),
                            SizedBox(
                              height: 24.sp,
                            ),
                            Text(
                              "Connect with us\non social media",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => _launchUrl(
                                      "https://www.linkedin.com/in/abhishek-pandey-218105231/"),
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white24),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/icons/linkedin.png",
                                        height: 24.h,
                                        width: 24.w,
                                        color: Colors.white,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                GestureDetector(
                                  onTap: () => _launchUrl(
                                      "https://www.instagram.com/abhishek_pandey0912/?hl=en"),
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white24),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/icons/instagram.png",
                                        height: 20.h,
                                        width: 20.w,
                                        color: Colors.white,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                GestureDetector(
                                  onTap: () => _launchUrl(
                                      "https://play.google.com/store/apps/details?id=com.airesumebuilderapp.aspire"),
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white24),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/icons/googlePlay.png",
                                        height: 20.h,
                                        width: 20.w,
                                        color: Colors.white,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 52.h,
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                childrenPadding: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 0.h),
                                tilePadding: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 0.h),
                                title: Text(
                                  "ABOUT ASPIRE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                children: [
                                  Text(
                                    "Aspire is a resume builder app that uses AI to enhance your resume and improve your ATS score, helping you achieve your career aspirations.",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.h,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.white12,
                            ),
                            SizedBox(
                              height: 0.h,
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                childrenPadding: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 0.h),
                                tilePadding: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 0.h),
                                title: Text(
                                  "WHAT'S ATS?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                children: [
                                  Text(
                                    "ATS stands for Applicant Tracking System. It is software used by employers to manage the recruitment process. An ATS collects, sorts, scans, and ranks the job applications they receive.",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.h,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.white12,
                            ),
                            SizedBox(
                              height: 0.h,
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                childrenPadding: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 0.h),
                                tilePadding: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 0.h),
                                title: Text(
                                  "HOW ASPIRE HELPS YOU ?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                children: [
                                  Text(
                                    "ASPIRE uses AI to create high-scoring ATS resumes along with beautifully crafted designs",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 80.h,
                            ),
                            Center(
                              child: Text(
                                "P R O U D L Y   M A D E   I N   B H A R A T",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 140.h,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
