import 'package:aspire/BuildingBlocks/Experience.dart';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class Educations extends StatefulWidget {
  bool hasBuilt;
  List details;
  final int option;
  final bool hasImage;
  final bool isBlackNWhite;
  final int professionSummaryMaxWord;
  final int skillMax;
  final int educationMax;
  final int experiencePlusProjects;
  final String firstName;
  final String lastName;
  final String designation;
  final String imagePath;
  final String address;
  final String phoneNo;
  final String emailAddress;
  final List<SkillEntry> skills;
  double rewardPoints;

  Educations({
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
    required this.rewardPoints,
  });

  @override
  _EducationsState createState() => _EducationsState();
}

class _EducationsState extends State<Educations> {
  final List<EducationEntry> _educations = [];
  final List<GlobalKey<FormState>> _formKeys = [];

  void _addNewEducation() {
    bool allValid = true;

    for (var key in _formKeys) {
      if (key.currentState != null && !key.currentState!.validate()) {
        allValid = false;
      }
    }

    if (allValid && _educations.length < widget.educationMax) {
      setState(() {
        _educations.add(EducationEntry());
        _formKeys.add(GlobalKey<FormState>());
      });
    }
  }

  void _deleteEducation(int index) {
    setState(() {
      _educations.removeAt(index);
      _formKeys.removeAt(index);
    });
  }

  String formatDate(DateTime date) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    String month = months[date.month.toInt() - 1];
    String year = date.year.toString();

    return '$month, $year';
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        flexibleSpace: TweenAnimationBuilder<double>(
          tween: widget.hasImage
              ? Tween<double>(begin: 0.4444444444444, end: 0.5555555555555)
              : Tween<double>(begin: 0.375, end: 0.5),
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
        //         ? Tween<double>(begin: 0.4444444444444, end: 0.5555555555555)
        //         : Tween<double>(begin: 0.375, end: 0.5),
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
          "Education",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              bool allValid = true;
              for (var formKey in _formKeys) {
                if (formKey.currentState != null &&
                    !formKey.currentState!.validate()) {
                  allValid = false;
                }
              }
              if (allValid) {
                if (_educations.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Add atleast one education!',
                          style: TextStyle(fontSize: 14.sp)),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: widget,
                      duration: const Duration(milliseconds: 200),
                      reverseDuration: const Duration(milliseconds: 200),
                      child: Experience(
                        hasBuilt: widget.hasBuilt,
                        details: widget.details,
                        option: widget.option,
                        hasImage: widget.hasImage,
                        isBlackNWhite: widget.isBlackNWhite,
                        professionSummaryMaxWord:
                            widget.professionSummaryMaxWord,
                        skillMax: widget.skillMax,
                        educationMax: widget.educationMax,
                        experiencePlusProjects: widget.experiencePlusProjects,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        imagePath: widget.imagePath,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        emailAddress: widget.emailAddress,
                        skills: widget.skills,
                        education: _educations,
                        rewardPoints: widget.rewardPoints,
                      ),
                    ),
                  );
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text(
                "Next",
                style: TextStyle(
                    color: _educations.isEmpty
                        ? const Color(0xFF899CB4)
                        : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Varied education on resume is equals to valuable skills for job. Make to mention all your education qualifications.",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _educations.length + 1,
                itemBuilder: (context, index) {
                  if (index == _educations.length) {
                    return _educations.length < widget.educationMax
                        ? InkWell(
                            onTap: _addNewEducation,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                "+ Add education",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: const Color(0xFF5cc43b),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                  return EducationTile(
                    key: ObjectKey(_educations[index]),
                    formKey: _formKeys[index],
                    educationEntry: _educations[index],
                    onDelete: () => _deleteEducation(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EducationEntry {
  String degree;
  String schoolOrCollege;
  String start;
  String end;
  String city;

  EducationEntry({
    this.degree = '',
    this.schoolOrCollege = '',
    this.start = '',
    this.end = '',
    this.city = '',
  });
}

class EducationTile extends StatefulWidget {
  final EducationEntry educationEntry;
  final GlobalKey<FormState> formKey;
  final VoidCallback onDelete;

  EducationTile({
    Key? key,
    required this.educationEntry,
    required this.formKey,
    required this.onDelete,
  }) : super(key: key);

  @override
  _EducationTileState createState() => _EducationTileState();
}

class _EducationTileState extends State<EducationTile> {
  String formatDate(DateTime date) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    String month = months[date.month.toInt() - 1];
    String year = date.year.toString();

    return '$month, $year';
  }

  String degreeName = "";
  String collegeName = "";
  String cityName = "";
  String startDate = "";
  String endDate = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            maintainState: true,
            backgroundColor: Colors.black12.withOpacity(0.03),
            collapsedBackgroundColor: Colors.black12.withOpacity(0.03),
            trailing: IconButton(
                onPressed: widget.onDelete,
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.black,
                  size: ScreenUtil().setSp(26),
                )),
            initiallyExpanded: true,
            title: Text(
              collegeName == "" && degreeName == ""
                  ? "Not Specified"
                  : degreeName == ""
                      ? collegeName
                      : "$degreeName at $collegeName",
              style: TextStyle(
                  height: 1.3,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp),
            ),
            subtitle: Text(
              "$startDate - $endDate",
              style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Form(
                  key: widget.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Institute",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        initialValue: widget.educationEntry.schoolOrCollege,
                        onChanged: (val) {
                          widget.educationEntry.schoolOrCollege = val;
                          setState(() {
                            collegeName = val;
                          });
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            setState(() {});
                            return "Institute is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            hintText: "Enter name of the institute",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.black12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.6.w),
                            )),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Degree",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        initialValue: widget.educationEntry.degree,
                        onChanged: (val) {
                          widget.educationEntry.degree = val;
                          setState(() {
                            degreeName = val;
                          });
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Degree is required";
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            hintText: "eg. B.Tech CSE",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.black12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.6.w),
                            )),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "City",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        initialValue: widget.educationEntry.city,
                        onChanged: (val) {
                          widget.educationEntry.city = val;
                          setState(() {
                            cityName = val;
                          });
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "City is required";
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            hintText: "eg. Bhopal",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.black12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.6.w),
                            )),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Start & End Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              showMonthPicker(
                                context: context,
                                headerColor: Colors.black,
                                unselectedMonthTextColor: Colors.black,
                                selectedMonthBackgroundColor: Colors.black,
                                initialDate: DateTime.now(),
                              ).then((date) {
                                if (date != null) {
                                  widget.educationEntry.start =
                                      formatDate(date);
                                  setState(() {
                                    startDate = formatDate(date);
                                  });
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.black12,
                                  border: Border.all(
                                      color: Colors.black12, width: 1.4.w),
                                  borderRadius: BorderRadius.circular(99.r)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 12.h),
                                  child: Text(
                                    startDate == "" ? "MM/YYYY" : startDate,
                                    style: TextStyle(
                                        color: startDate == ""
                                            ? Colors.black38
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          InkWell(
                            onTap: () {
                              showMonthPicker(
                                context: context,
                                headerColor: Colors.black,
                                unselectedMonthTextColor: Colors.black,
                                selectedMonthBackgroundColor: Colors.black,
                                initialDate: DateTime.now(),
                              ).then((date) {
                                if (date != null) {
                                  widget.educationEntry.end = formatDate(date);
                                  setState(() {
                                    endDate = formatDate(date);
                                  });
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.black12,
                                  border: Border.all(
                                      color: Colors.black12, width: 1.4.w),
                                  borderRadius: BorderRadius.circular(99.r)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 12.h),
                                  child: Text(
                                    endDate == "" ? "MM/YYYY" : endDate,
                                    style: TextStyle(
                                        color: endDate == ""
                                            ? Colors.black38
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
