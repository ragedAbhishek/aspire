import 'package:aspire/Utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final gmail = "nxtinteractiveprojects@gmail.com";

  final linkedinUrl = "https://www.linkedin.com/in/abhishek-pandey-218105231/";
  final instaUrl = "https://www.instagram.com/abhishek_pandey0912/?hl=en";
  final googlePlayUrl =
      "https://play.google.com/store/apps/details?id=com.airesumebuilderapp.aspire";

  Future<void> _launchUrl(String url) async {
    final Uri linkedinUri = Uri.parse(url);
    if (!await launchUrl(linkedinUri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch URL";
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // Set the color here
    ));
    final gmailUrl =
        "mailto:$gmail?subject=${Uri.encodeComponent("My feedback.")}&body=${Uri.encodeComponent("Write your message here.")}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: Builder(
            builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "assets/icons/back_button.png",
                    height: 42.h,
                    width: 42.w,
                  ),
                )),
        title: Text(
          "About",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aspire is a resume builder app created by students, for students. It harnesses advanced AI technology to generate high-ATS (Applicant Tracking System), professional resumes that elevate your visibility in the competitive job market. Our goal is to equip you with the tools and insights needed to craft resumes that not only meet but exceed industry standards, ensuring you stand out to potential employers.\n",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp),
                ),
                Text(
                  "If you find our app helpful, we would greatly appreciate it if you could take a moment to leave a review on the Google Play Store. Your feedback is invaluable to us in improving our service and helping others discover Aspire. If you encounter any issues or have suggestions for how we can enhance your experience, please don't hesitate to reach out to us via email. We are eager to hear your thoughts and are committed to continuously improving to better serve our users. Thank you for your support!\n",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Connect to us on:",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _launchUrl(googlePlayUrl);
                      },
                      child: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/icons/googlePlay.png"),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl(instaUrl);
                      },
                      child: Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icons/instagram.png"),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl(linkedinUrl);
                      },
                      child: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icons/linkedin.png"),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl(gmailUrl);
                      },
                      child: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/icons/attherate_icon.png"),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        shareTextAndImage(
                            context,
                            "*What's holding you back from landing your dream job?*\n\nIt's the ATS, or Application Tracking System. But why? Because in today's job market, a staggering 90% of resumes are checked by ATS software before they even reach the eye of hiring tech team.\n\nDownload Aspire to build awesome high ATS resume now: https://play.google.com/store/apps/details?id=com.airesumebuilderapp.aspire .",
                            "assets/logos/appIconBLACKBG.png");
                      },
                      child: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/icons/share_icon.png"),
                                fit: BoxFit.contain)),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
