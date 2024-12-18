import 'package:aspire/BuildingBlocks/Certificate.dart';
import 'package:aspire/BuildingBlocks/DetailsPreview.dart';
import 'package:aspire/BuildingBlocks/Educations.dart';
import 'package:aspire/BuildingBlocks/Experience.dart';
import 'package:aspire/BuildingBlocks/Projects.dart';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:aspire/Extras/conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  bool hasBuilt;
  List details;
  int option;
  bool hasImage;
  bool isBlackNWhite;
  int professionSummaryMaxWord;
  int skillMax;
  int educationMax;
  int experiencePlusProjects;
  String firstName;
  String lastName;
  String designation;
  String imagePath;
  String address;
  String phoneNo;
  String emailAddress;
  List<SkillEntry> skills;
  List<EducationEntry> education;
  List<ExperienceEntry> experience;
  List<ProjectEntry> project;
  List<CertificateEntry> certificate;
  double rewardPoints;

  Profile({
    super.key,
    required this.hasBuilt,
    required this.details,
    required this.option,
    required this.hasImage,
    required this.isBlackNWhite,
    required this.professionSummaryMaxWord,
    required this.skillMax,
    required this.educationMax,
    required this.experiencePlusProjects,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.imagePath,
    required this.address,
    required this.phoneNo,
    required this.emailAddress,
    required this.skills,
    required this.education,
    required this.experience,
    required this.project,
    required this.certificate,
    required this.rewardPoints,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color baseColor = const Color.fromARGB(31, 53, 53, 53);
  Color highlightColor = Colors.white10;
  @override
  void initState() {
    generate(
        "Write a high ATS score profession summary strictly  under ${widget.professionSummaryMaxWord} characters for a person who wish to apply for '${widget.designation}', having skills like ${widget.skills.map((e) => e.skillName).join(', ')}, and his education qualifications are ${widget.education.map((e) {
      String startYear = e.start != null ? e.start! : 'Unknown';
      String endYear = e.end != null ? e.end! : 'Unknown';
      return '${e.degree} from $startYear to $endYear';
    }).join(', ')}, use education duration just to analyse whether person is still studying or not, don't mention date, year or month.");
    super.initState();
  }

  String generated = "";
  bool isGenerating = false;

  void generate(String QUERY_INPUT) async {
    setState(() {
      isGenerating = true;
    });
    final model =
        GenerativeModel(model: 'gemini-pro', apiKey: GEMINI_AI_API_KEY);

    final prompt = QUERY_INPUT;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    if (!mounted) return;

    setState(() {
      generated = response.text.toString();
      isGenerating = false;
    });

    print(response.text);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white, // Set the color here
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: TweenAnimationBuilder<double>(
          tween: widget.hasImage
              ? Tween<double>(begin: 0.8888888888888, end: 1)
              : Tween<double>(begin: 0.875, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return LinearProgressIndicator(
              minHeight: 6,
              value: value,
              backgroundColor: Colors.black12,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF5cc43b)),
            );
          },
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(0.0),
        //   child: TweenAnimationBuilder<double>(
        //     tween: widget.hasImage
        //         ? Tween<double>(begin: 0.8888888888888, end: 1)
        //         : Tween<double>(begin: 0.875, end: 1),
        //     duration: const Duration(milliseconds: 500),
        //     builder: (context, value, child) {
        //       return LinearProgressIndicator(
        //         minHeight: 2.6,
        //         value: value,
        //         backgroundColor: Colors.black12,
        //         valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
        //       );
        //     },
        //   ),
        // ),
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Professional Summary",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () {},
        //     child: Padding(
        //       padding: EdgeInsets.all(8.0.w),
        //       child: Text(
        //         "Next",
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontWeight: FontWeight.w600,
        //             fontSize: 16.sp),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.h,
            ),
            isGenerating
                ? Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/gemini.png",
                          height: 42.h,
                          width: 42.w,
                          color: Colors.grey,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 300.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6.r)),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Container(
                              width: 300.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6.r)),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Container(
                              width: 300.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6.r)),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Container(
                              width: 300.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6.r)),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Container(
                              width: 150.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6.r)),
                            )
                          ],
                        )
                      ],
                    ))
                : Text(
                    generated,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
            generated.isEmpty
                ? const SizedBox.shrink()
                : SizedBox(height: 32.h),
            generated.isEmpty
                ? const SizedBox.shrink()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            generate(
                                "Write a high ATS score profession summary strictly  under ${widget.professionSummaryMaxWord} characters for a person who wish to apply for '${widget.designation}', having skills like ${widget.skills.map((e) => e.skillName).join(', ')}, and his education qualifications are ${widget.education.map((e) {
                              String startYear =
                                  e.start != null ? e.start! : 'Unknown';
                              String endYear =
                                  e.end != null ? e.end! : 'Unknown';
                              return '${e.degree} from $startYear to $endYear';
                            }).join(', ')}, use education duration just to analyse whether person is still studying or not, don't mention date, year or month.");
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/icons/gemini.png",
                                height: 22.h,
                                width: 22.w,
                                fit: BoxFit.cover,
                                color: const Color(0xFF5cc43b),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Text("Regenerate",
                                  style: TextStyle(
                                      color: const Color(0xFF5cc43b),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp))
                            ],
                          )),
                    ],
                  ),
            const Spacer(),
            generated.isEmpty
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: widget,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: DetailsPreview(
                              isServerData: false,
                              hasBuilt: widget.hasBuilt,
                              details: widget.details,
                              option: widget.option,
                              hasImage: widget.hasImage,
                              isBlackNWhite: widget.isBlackNWhite,
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              designation: widget.designation,
                              imagePath: widget.imagePath,
                              address: widget.address,
                              phoneNo: widget.phoneNo,
                              emailAddress: widget.emailAddress,
                              skills: widget.skills,
                              education: widget.education,
                              experience: widget.experience,
                              project: widget.project,
                              certificate: widget.certificate,
                              profile: generated,
                              rewardPoints: widget.rewardPoints,
                            )),
                      );
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF899CB4).withOpacity(0.1),
                              width: 1.2.w),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16.r)),
                      child: Center(
                          child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp),
                      )),
                    )),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      ),
    );
  }
}
