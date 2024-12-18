import 'package:aspire/BuildingBlocks/Educations.dart';
import 'package:aspire/BuildingBlocks/Projects.dart';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:aspire/Extras/conts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class Experience extends StatefulWidget {
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
  double rewardPoints;

  Experience({
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
    required this.rewardPoints,
  });
  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  final List<ExperienceEntry> _experience = [];
  final List<GlobalKey<FormState>> _experienceFormKey = [];

  void _addNewExperience() {
    bool allValid = true;

    for (var key in _experienceFormKey) {
      if (key.currentState != null && !key.currentState!.validate()) {
        allValid = false;
      }
    }

    if (allValid && _experience.length < 3) {
      setState(() {
        _experience.add(ExperienceEntry());
        _experienceFormKey.add(GlobalKey<FormState>());
      });
    }
  }

  void _deleteExperience(int index) {
    setState(() {
      _experience.removeAt(index);
      _experienceFormKey.removeAt(index);
    });
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
              ? Tween<double>(begin: 0.5555555555555, end: 0.6666666666666)
              : Tween<double>(begin: 0.5, end: 0.625),
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
        //         ? Tween<double>(begin: 0.5555555555555, end: 0.6666666666666)
        //         : Tween<double>(begin: 0.5, end: 0.625),
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
          "Experience",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              bool allValid = true;
              for (var formKey in _experienceFormKey) {
                if (formKey.currentState != null &&
                    !formKey.currentState!.validate()) {
                  allValid = false;
                }
              }
              if (allValid) {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.rightToLeftJoined,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                    child: Projects(
                      hasBuilt: widget.hasBuilt,
                      details: widget.details,
                      option: widget.option,
                      hasImage: widget.hasImage,
                      isBlackNWhite: widget.isBlackNWhite,
                      professionSummaryMaxWord: widget.professionSummaryMaxWord,
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
                      education: widget.education,
                      experience: _experience,
                      rewardPoints: widget.rewardPoints,
                    ),
                  ),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Text(
                "Next",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp),
              ),
            ),
          )
        ],
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Add all the work experience you had wheather it's job or internship. If you are fresher or you don't have any experience, click on 'Skip'.",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp),
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _experience.length + 1,
                itemBuilder: (context, index) {
                  if (index == _experience.length) {
                    return _experience.length < 3
                        ? InkWell(
                            onTap: _addNewExperience,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                "+ Add expereince",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: const Color(0xFF5cc43b),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : SizedBox.shrink();
                  }
                  return ExperienceTile(
                    key: ObjectKey(_experience[index]),
                    formKey: _experienceFormKey[index],
                    experienceEntry: _experience[index],
                    onDelete: () => _deleteExperience(index),
                  );
                },
              ),
            ),
            Visibility(
                visible: _experience.length == 0 ? true : false,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.rightToLeftJoined,
                          childCurrent: widget,
                          duration: const Duration(milliseconds: 200),
                          reverseDuration: const Duration(milliseconds: 200),
                          child: Projects(
                            hasBuilt: widget.hasBuilt,
                            details: widget.details,
                            option: widget.option,
                            hasImage: widget.hasImage,
                            isBlackNWhite: widget.isBlackNWhite,
                            professionSummaryMaxWord:
                                widget.professionSummaryMaxWord,
                            skillMax: widget.skillMax,
                            educationMax: widget.educationMax,
                            experiencePlusProjects:
                                widget.experiencePlusProjects,
                            firstName: widget.firstName,
                            lastName: widget.lastName,
                            designation: widget.designation,
                            imagePath: widget.imagePath,
                            address: widget.address,
                            phoneNo: widget.phoneNo,
                            emailAddress: widget.emailAddress,
                            skills: widget.skills,
                            education: widget.education,
                            experience: [],
                            rewardPoints: widget.rewardPoints,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "I don't have experience, SKIP.",
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )),
            SizedBox(
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceEntry {
  String jobTitle;
  String employer;
  String city;
  String description;
  String start;
  String end;

  ExperienceEntry({
    this.jobTitle = '',
    this.employer = '',
    this.city = '',
    this.description = '',
    this.start = '',
    this.end = '',
  });
}

class ExperienceTile extends StatefulWidget {
  final ExperienceEntry experienceEntry;
  final VoidCallback onDelete;
  final GlobalKey<FormState> formKey;

  ExperienceTile({
    Key? key,
    required this.experienceEntry,
    required this.onDelete,
    required this.formKey,
  }) : super(key: key);

  @override
  State<ExperienceTile> createState() => _ExperienceTileState();
}

class _ExperienceTileState extends State<ExperienceTile> {
  String jobTitleName = "";
  String employerName = "";
  String cityName = "";
  String startDate = "";
  String endDate = "";
  String aiGenerated = "";
  bool isGenerating = false;

  void generate(String QUERY_INPUT) async {
    setState(() {
      isGenerating = true;
    });

    final model = GenerativeModel(
        model: 'gemini-pro', apiKey: dotenv.env['GEMINI_AI_API_KEY']!);

    final prompt = QUERY_INPUT;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    setState(() {
      widget.experienceEntry.description = response.text.toString();
      aiGenerated = response.text.toString();
      // generated = response.text.toString();
      isGenerating = false;
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            maintainState: true,
            collapsedBackgroundColor: Colors.black12.withOpacity(0.03),
            backgroundColor: Colors.black12.withOpacity(0.03),
            trailing: IconButton(
                onPressed: widget.onDelete,
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.black,
                  size: ScreenUtil().setSp(26),
                )),
            initiallyExpanded: true,
            title: Text(
              employerName == "" && jobTitleName == ""
                  ? "Not Specified"
                  : jobTitleName == ""
                      ? employerName
                      : "${jobTitleName} at ${employerName}",
              style: TextStyle(
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
                        "Job Title",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Job title  is required";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                        initialValue: widget.experienceEntry.jobTitle,
                        onChanged: (val) {
                          widget.experienceEntry.jobTitle = val;
                          setState(() {
                            jobTitleName = val;
                          });
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            hintText: "eg. Junior Android Developer",
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
                        "Employer",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Employer name is required";
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        textCapitalization: TextCapitalization.words,
                        initialValue: widget.experienceEntry.employer,
                        onChanged: (val) {
                          widget.experienceEntry.employer = val;
                          setState(() {
                            employerName = val;
                          });
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "Name of the employer",
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
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "City is required";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                        initialValue: widget.experienceEntry.city,
                        onChanged: (val) {
                          widget.experienceEntry.city = val;
                          setState(() {
                            cityName = val;
                          });
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            hintText: "The city you worked in",
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
                        "Description",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        initialValue: widget.experienceEntry.description,
                        onChanged: (val) {
                          widget.experienceEntry.description = val;
                          setState(() {});
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        maxLength: 140,
                        decoration: InputDecoration(
                            hintText: "Write a brief description",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.black12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.6.w),
                            )),
                      ),
                      aiGenerated.isEmpty
                          ? const SizedBox.shrink()
                          : Text(
                              aiGenerated,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17.sp),
                            ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              generate(
                                  "Write high ATS score employment summary strictly under 140 characters where user jobTitle is ${widget.experienceEntry.jobTitle} and employer is ${widget.experienceEntry.employer}, also write in active voice.");
                            },
                            child: isGenerating
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 20.h,
                                        width: 20.w,
                                        child: CircularProgressIndicator(
                                          color: const Color(0xFF5cc43b),
                                          strokeWidth: 2.w,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Text("Generating...",
                                          style: TextStyle(
                                              color: const Color(0xFF5cc43b),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp))
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      Text(
                                          aiGenerated.isEmpty
                                              ? "Generate using AI"
                                              : "Regenerate",
                                          style: TextStyle(
                                              color: const Color(0xFF5cc43b),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp))
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Start & End Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
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
                                headerColor: Colors.black,
                                unselectedMonthTextColor: Colors.black,
                                selectedMonthBackgroundColor: Colors.black,
                                context: context,
                                initialDate: DateTime.now(),
                              ).then((date) {
                                if (date != null) {
                                  widget.experienceEntry.start =
                                      formatDate(date);
                                  setState(() {
                                    startDate = formatDate(date);
                                  });
                                  // setState(() {
                                  // // selectedDate = date;
                                  // });
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
                                headerColor: Colors.black,
                                unselectedMonthTextColor: Colors.black,
                                selectedMonthBackgroundColor: Colors.black,
                                context: context,
                                cancelWidget: GestureDetector(
                                    onTap: () {
                                      widget.experienceEntry.end = "Present";
                                      setState(() {
                                        endDate = "Present";
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Present",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.sp),
                                    )),
                                initialDate: DateTime.now(),
                              ).then((date) {
                                if (date != null) {
                                  widget.experienceEntry.end = formatDate(date);
                                  setState(() {
                                    endDate = formatDate(date);
                                  });
                                  // setState(() {
                                  // // selectedDate = date;
                                  // });
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
                      SizedBox(height: 24.h),
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
