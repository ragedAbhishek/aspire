import 'package:aspire/BuildingBlocks/Certificate.dart';
import 'package:aspire/BuildingBlocks/Educations.dart';
import 'package:aspire/BuildingBlocks/Experience.dart';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class Projects extends StatefulWidget {
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
  double rewardPoints;

  Projects({
    Key? key,
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
    required this.rewardPoints,
  }) : super(key: key);
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final List<ProjectEntry> _projects = [];

  final List<GlobalKey<FormState>> _projectFormKey = [];

  void _addNewProject() {
    bool allValid = true;

    for (var key in _projectFormKey) {
      if (key.currentState != null && !key.currentState!.validate()) {
        allValid = false;
      }
    }

    if (allValid &&
        _projects.length <
            widget.experiencePlusProjects - widget.experience.length) {
      setState(() {
        _projects.add(ProjectEntry());
        _projectFormKey.add(GlobalKey<FormState>());
      });
    }
  }

  void _deleteProject(int index) {
    setState(() {
      _projects.removeAt(index);
      _projectFormKey.removeAt(index);
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
              ? Tween<double>(begin: 0.6666666666666, end: 0.7777777777777)
              : Tween<double>(begin: 0.625, end: 0.75),
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
        scrolledUnderElevation: 0,
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(0.0),
        //   child: TweenAnimationBuilder<double>(
        //     tween: widget.hasImage
        //         ? Tween<double>(begin: 0.6666666666666, end: 0.7777777777777)
        //         : Tween<double>(begin: 0.625, end: 0.75),
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
          "Projects",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              bool allValid = true;
              for (var formKey in _projectFormKey) {
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
                    child: Certificate(
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
                      experience: widget.experience,
                      project: _projects,
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add the all the projects you have worked on, wheather its practice project or your college project. If you don't have any just click on 'SKIP'.",
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
                itemCount: _projects.length + 1,
                itemBuilder: (context, index) {
                  if (index == _projects.length) {
                    return _projects.length <
                            widget.experiencePlusProjects -
                                widget.experience.length
                        ? InkWell(
                            onTap: _addNewProject,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text("+ Add project",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: const Color(0xFF5cc43b),
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                  return ProjectsTile(
                    key: ObjectKey(_projects[index]),
                    projectsEntry: _projects[index],
                    formKey: _projectFormKey[index],
                    onDelete: () => _deleteProject(index),
                  );
                },
              ),
            ),
            Visibility(
              visible: _projects.isEmpty ? true : false,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: widget,
                        duration: const Duration(milliseconds: 200),
                        reverseDuration: const Duration(milliseconds: 200),
                        child: Certificate(
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
                          education: widget.education,
                          experience: widget.experience,
                          project: [],
                          rewardPoints: widget.rewardPoints,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "SKIP for now.",
                    style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectEntry {
  String projectName;
  String projectDescription;
  String projectDate;

  ProjectEntry({
    this.projectName = '',
    this.projectDescription = '',
    this.projectDate = '',
  });
}

class ProjectsTile extends StatefulWidget {
  final ProjectEntry projectsEntry;
  final VoidCallback onDelete;
  final GlobalKey<FormState> formKey;

  ProjectsTile({
    Key? key,
    required this.projectsEntry,
    required this.onDelete,
    required this.formKey,
  }) : super(key: key);

  @override
  State<ProjectsTile> createState() => _ProjectsTileState();
}

class _ProjectsTileState extends State<ProjectsTile> {
  String projectName = "";
  String projectDescription = "";
  String projectDate = "";

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
            trailing: IconButton(
                onPressed: widget.onDelete,
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.black,
                  size: ScreenUtil().setSp(26),
                )),
            initiallyExpanded: true,
            maintainState: true,
            collapsedBackgroundColor: Colors.black12.withOpacity(0.04),
            backgroundColor: Colors.black12.withOpacity(0.04),
            title: Text(
              projectName == "" ? "Your project name" : projectName,
              style: TextStyle(
                  height: 1.3,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp),
            ),
            subtitle: Text(
              projectDate,
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
                        "Project Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Project name is required";
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        initialValue: widget.projectsEntry.projectName,
                        onChanged: (val) {
                          widget.projectsEntry.projectName = val;
                          setState(() {
                            projectName = val;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Enter title of your project",
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
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Project Description is required";
                          }
                          return null;
                        },
                        initialValue: widget.projectsEntry.projectDescription,
                        onChanged: (val) {
                          widget.projectsEntry.projectDescription = val;
                          setState(() {
                            projectDescription = val;
                          });
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        maxLength: 140,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
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
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Project Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
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
                              widget.projectsEntry.projectDate =
                                  formatDate(date);
                              setState(() {
                                projectDate = formatDate(date);
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
                                projectDate == "" ? "MM/YYYY" : projectDate,
                                style: TextStyle(
                                    color: projectDate == ""
                                        ? Colors.black38
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
                              )),
                        ),
                      ),
                      SizedBox(height: 12.h),
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
