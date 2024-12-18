import 'package:aspire/BuildingBlocks/NameAndDesignation.dart';
import 'package:aspire/BuildingBlocks/detailSelection.dart';
import 'package:aspire/Utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class ResumePreview extends StatefulWidget {
  List savedDetails;
  bool hasBuilt;
  int option;
  bool hasImage;
  bool isBlackNWhite;
  List details;
  int professionSummaryMaxWord;
  int skillMax;
  int educationMax;
  int experiencePlusProjects;
  double rewardPoints;
  String countryCode;

  ResumePreview({
    super.key,
    required this.savedDetails,
    required this.hasBuilt,
    required this.option,
    required this.hasImage,
    required this.isBlackNWhite,
    required this.details,
    required this.professionSummaryMaxWord,
    required this.skillMax,
    required this.educationMax,
    required this.experiencePlusProjects,
    required this.rewardPoints,
    required this.countryCode,
  });
  @override
  State<ResumePreview> createState() => _ResumePreviewState();
}

class _ResumePreviewState extends State<ResumePreview> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white, // Set the color here
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        centerTitle: true,
        title: Text(
          "Preview",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    child: Image.asset(
                      widget.details[0],
                      // height: 500.h,
                    ),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 8),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  SizedBox(
                    width: 220.w,
                    child: Text(
                      widget.details[1],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100.h,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Price\n",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text:
                                "${countryCodeToCurrencySymbol(widget.countryCode)}${widget.details[2].toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800))
                      ])),
                    ),
                    InkWell(
                      onTap: () {
                        widget.savedDetails.isEmpty
                            ? Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.rightToLeftJoined,
                                  childCurrent: widget,
                                  duration: const Duration(milliseconds: 200),
                                  reverseDuration:
                                      const Duration(milliseconds: 200),
                                  child: NameAndDesignation(
                                    details: widget.details,
                                    hasBuilt: widget.hasBuilt,
                                    option: widget.option,
                                    hasImage: widget.hasImage,
                                    isBlackNWhite: widget.isBlackNWhite,
                                    professionSummaryMaxWord:
                                        widget.professionSummaryMaxWord,
                                    skillMax: widget.skillMax,
                                    educationMax: widget.educationMax,
                                    experiencePlusProjects:
                                        widget.experiencePlusProjects,
                                    rewardPoints: widget.rewardPoints,
                                  ),
                                ),
                              )
                            : Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.rightToLeftJoined,
                                  childCurrent: widget,
                                  duration: const Duration(milliseconds: 200),
                                  reverseDuration:
                                      const Duration(milliseconds: 200),
                                  child: DetailSelection(
                                    savedDetails: widget.savedDetails,
                                    details: widget.details,
                                    hasBuilt: widget.hasBuilt,
                                    option: widget.option,
                                    hasImage: widget.hasImage,
                                    isBlackNWhite: widget.isBlackNWhite,
                                    professionSummaryMaxWord:
                                        widget.professionSummaryMaxWord,
                                    skillMax: widget.skillMax,
                                    educationMax: widget.educationMax,
                                    experiencePlusProjects:
                                        widget.experiencePlusProjects,
                                    rewardPoints: widget.rewardPoints,
                                  ),
                                ),
                              );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32.w, vertical: 16.h),
                          child: Text(
                            "Build Resume",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
