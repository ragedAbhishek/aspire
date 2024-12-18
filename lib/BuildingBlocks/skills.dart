import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:aspire/BuildingBlocks/Educations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class Skills extends StatefulWidget {
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
  double rewardPoints;

  Skills({
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
    required this.rewardPoints,
  });
  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  final List<SkillEntry> _skills = [];
  final List<GlobalKey<FormState>> _formKeys = [];

  void _addNewSkill() {
    for (var formKey in _formKeys) {
      if (formKey.currentState != null && !formKey.currentState!.validate()) {
        return; // If any form is invalid, return without adding a new skill
      }
    }

    if (_skills.length < widget.skillMax) {
      setState(() {
        _skills.add(SkillEntry());
        _formKeys.add(GlobalKey<FormState>());
      });
    }
  }

  void _deleteSkill(int index) {
    setState(() {
      _skills.removeAt(index);
      _formKeys.removeAt(index);
    });
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
              ? Tween<double>(begin: 0.3333333333333, end: 0.4444444444444)
              : Tween<double>(begin: 0.25, end: 0.375),
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
        //         ? Tween<double>(begin: 0.3333333333333, end: 0.4444444444444)
        //         : Tween<double>(begin: 0.25, end: 0.375),
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
          "Skills",
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
                if (_skills.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Atleast add one skill to continue!',
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
                      child: Educations(
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
                        skills: _skills,
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
                    color: _skills.isEmpty ? Color(0xFF899CB4) : Colors.black,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Add important skills that show you fit for the position. Make sure they match the key skills mentioned in the job listing.",
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
                itemCount: _skills.length + 1,
                itemBuilder: (context, index) {
                  if (index == _skills.length) {
                    return _skills.length < widget.skillMax
                        ? InkWell(
                            onTap: _addNewSkill,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                "+ Add skill",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: const Color(0xFF5cc43b),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                  return Form(
                    key: _formKeys[index],
                    child: SkillTile(
                      key: ObjectKey(_skills[index]),
                      skillEntry: _skills[index],
                      onDelete: () => _deleteSkill(index),
                    ),
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

class SkillEntry {
  String skillName;
  double expertise;

  SkillEntry({this.skillName = '', this.expertise = 0.2});
}

class SkillTile extends StatefulWidget {
  final SkillEntry skillEntry;
  final VoidCallback onDelete;

  SkillTile({Key? key, required this.skillEntry, required this.onDelete})
      : super(key: key);

  @override
  State<SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile> {
  String skill = "";
  double experience = 0;
  Color b_color = const Color(0xFFe7f4ed);
  Color buttonColor = const Color(0xFF48ba75);
  String expertise = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            // tilePadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 0.w),
            collapsedBackgroundColor: Colors.black12.withOpacity(0.03),
            backgroundColor: Colors.black12.withOpacity(0.03),
            trailing: IconButton(
                onPressed: widget.onDelete,
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.black,
                  size: ScreenUtil().setSp(26),
                )),
            tilePadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),

            initiallyExpanded: true,
            maintainState: true,
            title: Text(skill == "" ? "Your skill" : skill,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp)),
            subtitle: Text(expertise == "" ? "Expertise" : expertise,
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp)),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Skill",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      initialValue: widget.skillEntry.skillName,
                      onChanged: (val) {
                        widget.skillEntry.skillName = val.trim();
                        setState(() {
                          skill = val;
                        });
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          hintText: "Enter your skill",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: Colors.black12),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.6.w),
                          )),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a skill name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Level ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                          text: expertise,
                          style: TextStyle(color: buttonColor, fontSize: 16.sp))
                    ])),
                    SizedBox(height: 12.h),

                    AnimatedButtonBar(
                        backgroundColor: b_color,
                        foregroundColor: buttonColor,
                        radius: 8.0,
                        // padding: const EdgeInsets.all(16.0),
                        invertedSelection: true,
                        innerVerticalPadding: 15,
                        children: [
                          ButtonBarEntry(
                              onTap: () {
                                widget.skillEntry.expertise = 0.2;
                                setState(() {
                                  buttonColor = const Color(0xFF48ba75);
                                  experience = 1;
                                  b_color = const Color(0xFFe7f4ed);
                                  expertise = "Novice";
                                });
                              },
                              child: const Text('1')),
                          ButtonBarEntry(
                              onTap: () {
                                widget.skillEntry.expertise = 0.4;
                                setState(() {
                                  experience = 2;
                                  b_color = const Color(0xFFfeebe3);
                                  expertise = "Beginner";
                                  buttonColor = const Color(0xFFf68559);
                                });
                              },
                              child: const Text('2')),
                          ButtonBarEntry(
                              onTap: () {
                                widget.skillEntry.expertise = 0.6;
                                setState(() {
                                  experience = 3;
                                  b_color = const Color(0xFFfff2cc);
                                  expertise = "Skillful";
                                  buttonColor = const Color(0xFFec930c);
                                });
                              },
                              child: const Text('3')),
                          ButtonBarEntry(
                              onTap: () {
                                widget.skillEntry.expertise = 0.8;
                                setState(() {
                                  experience = 4;
                                  b_color = const Color(0xFFffeaec);
                                  expertise = "Experienced";

                                  buttonColor = const Color(0xFFfe7d8b);
                                });
                              },
                              child: const Text('4')),
                          ButtonBarEntry(
                              onTap: () {
                                widget.skillEntry.expertise = 1.0;
                                setState(() {
                                  buttonColor = const Color(0xFF9ba1fb);
                                  experience = 5;
                                  b_color = const Color(0xFFf1f2ff);
                                  expertise = "Expert";
                                });
                              },
                              child: const Text('5')),
                        ]),
                    SizedBox(height: 24.h),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: IconButton(
                    //     icon: Icon(Icons.delete, color: Colors.red),
                    //     onPressed: widget.onDelete,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
