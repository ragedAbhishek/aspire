import 'package:aspire/BuildingBlocks/ContactDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class NameAndDesignation extends StatefulWidget {
  bool hasBuilt;
  List details;
  int option;
  bool hasImage;
  bool isBlackNWhite;
  int professionSummaryMaxWord;
  int skillMax;
  int educationMax;
  int experiencePlusProjects;
  double rewardPoints;

  NameAndDesignation({
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
    required this.rewardPoints,
  });

  @override
  State<NameAndDesignation> createState() => _NameAndDesignationState();
}

class _NameAndDesignationState extends State<NameAndDesignation> {
  //************************************** V A R I A B  L E ***********************************

  final GlobalKey<FormState> _nameAndDesignationKey = GlobalKey<FormState>();
  final TextEditingController _firstNameFieldController =
      TextEditingController();
  final TextEditingController _lastNameFieldController =
      TextEditingController();
  final TextEditingController _designationFieldController =
      TextEditingController();

  final FocusNode _firstNamefocusNode = FocusNode();
  final FocusNode _lastNamefocusNode = FocusNode();
  final FocusNode _designationfocusNode = FocusNode();

  bool isFilled = false;

  //************************************** F U N C T I O N S ***********************************

  @override
  void dispose() {
    _firstNameFieldController.dispose();
    _firstNamefocusNode.dispose();
    _lastNameFieldController.dispose();
    _lastNamefocusNode.dispose();
    _designationFieldController.dispose();
    _designationfocusNode.dispose();
    super.dispose();
  }

  void check() {
    if (_firstNameFieldController.text.isNotEmpty &&
        _lastNameFieldController.text.isNotEmpty &&
        _designationFieldController.text.isNotEmpty) {
      setState(() {
        isFilled = true;
      });
    } else {
      setState(() {
        isFilled = false;
      });
    }
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
              ? Tween<double>(begin: 0, end: 0.1111111111111)
              : Tween<double>(begin: 0, end: 0.125),
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
        //         ? Tween<double>(begin: 0, end: 0.1111111111111)
        //         : Tween<double>(begin: 0, end: 0.125),
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
          "Personal Info",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_nameAndDesignationKey.currentState!.validate()) {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.rightToLeftJoined,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                    child: ContactDetails(
                      hasBuilt: widget.hasBuilt,
                      details: widget.details,
                      option: widget.option,
                      hasImage: widget.hasImage,
                      isBlackNWhite: widget.isBlackNWhite,
                      professionSummaryMaxWord: widget.professionSummaryMaxWord,
                      skillMax: widget.skillMax,
                      educationMax: widget.educationMax,
                      experiencePlusProjects: widget.experiencePlusProjects,
                      firstName: _firstNameFieldController.text.trim(),
                      lastName: _lastNameFieldController.text.trim(),
                      designation: _designationFieldController.text.trim(),
                      rewardPoints: widget.rewardPoints,
                    ),
                  ),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text(
                "Next",
                style: TextStyle(
                    color: isFilled ? Colors.black : const Color(0xFF899CB4),
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _nameAndDesignationKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Fill in your personal details like your name and job title.",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 17.sp),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "First Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _firstNameFieldController,
                  focusNode: _firstNamefocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your first name ";
                    } else if (value.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Enter a valid first name";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    check();
                  },
                  onFieldSubmitted: (value) {
                    _firstNamefocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_lastNamefocusNode);
                  },
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "Your first name",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          color: Colors.black12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.6.w),
                      )),
                ),
                SizedBox(
                  height: 28.h,
                ),
                Text(
                  "Last Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _lastNameFieldController,
                  focusNode: _lastNamefocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your last name ";
                    } else if (value.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Enter a valid last name";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    check();
                  },
                  onFieldSubmitted: (value) {
                    _lastNamefocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_designationfocusNode);
                  },
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "Your last name",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          color: Colors.black12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.6.w),
                      )),
                ),
                SizedBox(
                  height: 28.h,
                ),
                Text(
                  "Job Title",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _designationFieldController,
                  focusNode: _designationfocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your job title";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    check();
                  },
                  onFieldSubmitted: (value) {
                    _designationfocusNode.unfocus();
                  },
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "eg. Android Developer",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          color: Colors.black12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.6.w),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
