import 'package:aspire/BuildingBlocks/Educations.dart';
import 'package:aspire/BuildingBlocks/Experience.dart';
import 'package:aspire/BuildingBlocks/Profile.dart';
import 'package:aspire/BuildingBlocks/Projects.dart';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class Certificate extends StatefulWidget {
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
  double rewardPoints;

  Certificate({
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
    required this.project,
    required this.rewardPoints,
  }) : super(key: key);
  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  final List<CertificateEntry> _certificate = [];

  final List<GlobalKey<FormState>> _certificateFormKey = [];

  void _addNewCertificate() {
    bool allValid = true;

    for (var key in _certificateFormKey) {
      if (key.currentState != null && !key.currentState!.validate()) {
        allValid = false;
      }
    }

    if (allValid &&
        _certificate.length <
            widget.experiencePlusProjects -
                (widget.experience.length + widget.project.length)) {
      setState(() {
        _certificate.add(CertificateEntry());
        _certificateFormKey.add(GlobalKey<FormState>());
      });
    }
  }

  void _deleteCertificate(int index) {
    setState(() {
      _certificate.removeAt(index);
      _certificateFormKey.removeAt(index);
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
              ? Tween<double>(begin: 0.7777777777777, end: 0.8888888888888)
              : Tween<double>(begin: 0.75, end: 0.875),
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
        //         ? Tween<double>(begin: 0.7777777777777, end: 0.8888888888888)
        //         : Tween<double>(begin: 0.75, end: 0.875),
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
          "Certificates",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              bool allValid = true;
              for (var formKey in _certificateFormKey) {
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
                    child: Profile(
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
                      project: widget.project,
                      certificate: _certificate,
                      rewardPoints: widget.rewardPoints,
                    ),
                  ),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.all(8.0.w),
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
              "Add all the certificates you have show your achievement and skills. If you don't have any just click on 'SKIP'.",
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
                itemCount: _certificate.length + 1,
                itemBuilder: (context, index) {
                  if (index == _certificate.length) {
                    return _certificate.length <
                            widget.experiencePlusProjects -
                                (widget.experience.length +
                                    widget.project.length)
                        ? InkWell(
                            onTap: _addNewCertificate,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text("+ Add certificate",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: const Color(0xFF5cc43b),
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                  return CertificateTile(
                    key: ObjectKey(_certificate[index]),
                    certificateEntry: _certificate[index],
                    formKey: _certificateFormKey[index],
                    onDelete: () => _deleteCertificate(index),
                  );
                },
              ),
            ),
            Visibility(
              visible: _certificate.isEmpty ? true : false,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: widget,
                        duration: const Duration(milliseconds: 200),
                        reverseDuration: const Duration(milliseconds: 200),
                        child: Profile(
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
                          project: widget.project,
                          certificate: [],
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

class CertificateEntry {
  String issuingBody;
  String issuedFor;
  String issuedOn;

  CertificateEntry({
    this.issuingBody = '',
    this.issuedFor = '',
    this.issuedOn = '',
  });
}

class CertificateTile extends StatefulWidget {
  final CertificateEntry certificateEntry;
  final VoidCallback onDelete;
  final GlobalKey<FormState> formKey;

  CertificateTile({
    Key? key,
    required this.certificateEntry,
    required this.onDelete,
    required this.formKey,
  }) : super(key: key);

  @override
  State<CertificateTile> createState() => _CertificateTileState();
}

class _CertificateTileState extends State<CertificateTile> {
  String IssuedBy = "";
  String IssuedFor = "";
  String IssuedOn = "";

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
            collapsedBackgroundColor: Colors.black12.withOpacity(0.04),
            backgroundColor: Colors.black12.withOpacity(0.04),
            trailing: IconButton(
                onPressed: widget.onDelete,
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.black,
                  size: ScreenUtil().setSp(26),
                )),
            initiallyExpanded: true,
            title: Text(
              IssuedFor == "" ? "Certificate" : IssuedFor,
              style: TextStyle(
                  height: 1.3,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp),
            ),
            subtitle: Text(
              IssuedOn,
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
                        "Issued By",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        textCapitalization: TextCapitalization.words,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Certificate issuer name is required";
                          }
                          return null;
                        },
                        initialValue: widget.certificateEntry.issuingBody,
                        onChanged: (val) {
                          widget.certificateEntry.issuingBody = val;
                          setState(() {
                            IssuedBy = val;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "eg. NPTEL",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                                color: Colors.black12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.6.w),
                            )),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Issued For",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        textCapitalization: TextCapitalization.words,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        initialValue: widget.certificateEntry.issuedFor,
                        onChanged: (val) {
                          widget.certificateEntry.issuedFor = val;
                          setState(() {
                            IssuedFor = val;
                          });
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "eg. State level Hackathon",
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
                        height: 24.h,
                      ),
                      Text(
                        "Issued On",
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
                              widget.certificateEntry.issuedOn =
                                  formatDate(date);
                              setState(() {
                                IssuedOn = formatDate(date);
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
                                IssuedOn == "" ? "MM/YYYY" : IssuedOn,
                                style: TextStyle(
                                    color: IssuedOn == ""
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
