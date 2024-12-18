import 'package:aspire/BuildingBlocks/Certificate.dart';
import 'package:aspire/BuildingBlocks/DetailsPreview.dart';
import 'package:aspire/BuildingBlocks/Educations.dart';
import 'package:aspire/BuildingBlocks/Experience.dart';
import 'package:aspire/BuildingBlocks/NameAndDesignation.dart';
import 'package:aspire/BuildingBlocks/Projects.dart';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:aspire/Utils/methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class DetailSelection extends StatefulWidget {
  List savedDetails;
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

  DetailSelection({
    super.key,
    required this.savedDetails,
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
  State<DetailSelection> createState() => _DetailSelectionState();
}

class _DetailSelectionState extends State<DetailSelection> {
  //**************************************** F U N C T I O N **************************************/
  String formatDate(Timestamp date) {
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

    DateTime theDate = date.toDate();
    String day = theDate.day.toString().padLeft(2, '0');
    String month = months[theDate.month.toInt() - 1];
    String year = theDate.year.toString();

    return '$month $day, $year';
  }

  Color baseColor = const Color.fromARGB(31, 53, 53, 53);
  Color highlightColor = Colors.white10;

  Future<Map<String, dynamic>> getDetails(String itemId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('savedDetails')
        .doc(itemId)
        .get();

    if (snapshot.exists) {
      // Check if the document exists
      Map<String, dynamic> data = snapshot.data() ?? {};
      return data;
    } else {
      return {};
    }
  }

  String skillExpertise(double lev) {
    if (lev == 0.2) {
      return "Novice";
    } else if (lev == 0.4) {
      return "Begineer";
    } else if (lev == 0.6) {
      return "Skillfull";
    } else if (lev == 0.8) {
      return "Experienced";
    } else {
      return "Expert";
    }
  }

  List<EducationEntry> _convertToEducationEntries(List<dynamic> data) {
    return data.map((entry) {
      return EducationEntry(
        degree: entry['degree'] ?? '',
        schoolOrCollege: entry['schoolOrCollege'] ?? '',
        start: entry['start'] ?? '',
        end: entry['end'] ?? '',
        city: entry['city'] ?? '',
      );
    }).toList();
  }

  List<SkillEntry> _convertToSkillEntries(List<dynamic> data) {
    return data.map((entry) {
      return SkillEntry(
        skillName: entry['skillName'] ?? '',
        expertise: entry['expertise'] ?? '',
      );
    }).toList();
  }

  List<ExperienceEntry> _convertToExperienceEntries(List<dynamic> data) {
    return data.map((entry) {
      return ExperienceEntry(
        jobTitle: entry['jobTitle'] ?? '',
        employer: entry['employer'] ?? '',
        city: entry['city'] ?? '',
        description: entry['description'] ?? '',
        start: entry['start'] ?? '',
        end: entry['end'] ?? '',
      );
    }).toList();
  }

  List<ProjectEntry> _convertToProjectEntries(List<dynamic> data) {
    return data.map((entry) {
      return ProjectEntry(
        projectName: entry['projectName'] ?? '',
        projectDescription: entry['projectDescription'] ?? '',
        projectDate: entry['projectDate'] ?? '',
      );
    }).toList();
  }

  List<CertificateEntry> _convertToCertificateEntries(List<dynamic> data) {
    return data.map((entry) {
      return CertificateEntry(
        issuingBody: entry['issuingBody'] ?? '',
        issuedFor: entry['issuedFor'] ?? '',
        issuedOn: entry['issuedOn'] ?? '',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f6f8),
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
        backgroundColor: const Color(0xFFf6f6f8),
        centerTitle: true,
        title: Text(
          "Select Details",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: widget,
                        duration: const Duration(milliseconds: 200),
                        reverseDuration: const Duration(milliseconds: 200),
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
                          experiencePlusProjects: widget.experiencePlusProjects,
                          rewardPoints: widget.rewardPoints,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "+ Add new details",
                    style: TextStyle(
                        color: const Color(0xFF5cc43b),
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp),
                  )),
              SizedBox(
                height: 24.h,
              ),
              ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.savedDetails.length,
                itemBuilder: (context, index) {
                  String detail = widget.savedDetails[index];
                  return FutureBuilder<Map<String, dynamic>>(
                    future: getDetails(detail),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Shimmer.fromColors(
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                              child: Container(
                                width: double.infinity,
                                height: 100.h,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.r)),
                              )),
                        ); //**************************** ADD SHIMMER EFFECT ***************** */
                      } else {
                        Map<String, dynamic> data = snapshot.data ?? {};
                        bool hasImage = data['hasImage'] ?? false;
                        String firstName = data['firstName'] ?? '';
                        String lastName = data['lastName'] ?? '';
                        String jobTitle = data['jobTitle'] ?? '';
                        String imagePath = data['imagePath'] ?? '';
                        String address = data['address'] ?? '';
                        String phoneNo = data['phoneNo'] ?? '';
                        String emailAddress = data['emailAddress'] ?? '';
                        List<SkillEntry> skills =
                            _convertToSkillEntries(data['skills'] ?? []);
                        List<EducationEntry> education =
                            _convertToEducationEntries(data['education'] ?? []);
                        List<ExperienceEntry> experience =
                            _convertToExperienceEntries(
                                data['experience'] ?? []);
                        List<ProjectEntry> project =
                            _convertToProjectEntries(data['project'] ?? []);
                        List<CertificateEntry> certificate =
                            _convertToCertificateEntries(
                                data['certificate'] ?? []);
                        String profile = data['profile'] ?? '';
                        var savedOn = data['savedOn'];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 142, 142, 142)
                                            .withOpacity(0.1),
                                    spreadRadius: 4,
                                    blurRadius: 16,
                                    offset: const Offset(4, 2),
                                  ),
                                ],
                                color: widget.hasImage == hasImage &&
                                        skills.length <= widget.skillMax &&
                                        education.length <=
                                            widget.educationMax &&
                                        (experience.length +
                                                project.length +
                                                certificate.length) <=
                                            widget.experiencePlusProjects
                                    ? Colors.white
                                    : const Color(0xFFf8f8f8)),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(
                                    vertical: 6.h, horizontal: 12.w),
                                childrenPadding:
                                    EdgeInsets.symmetric(horizontal: 12.w),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$firstName $lastName",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19.sp),
                                    ),
                                    Text(
                                      jobTitle,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.sp),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  formatDate(savedOn),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    if (widget.hasImage == hasImage &&
                                        skills.length <= widget.skillMax &&
                                        education.length <=
                                            widget.educationMax &&
                                        (experience.length +
                                                project.length +
                                                certificate.length) <=
                                            widget.experiencePlusProjects) {
                                      Navigator.of(context).push(
                                        PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftJoined,
                                          childCurrent: widget,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          reverseDuration:
                                              const Duration(milliseconds: 200),
                                          child: DetailsPreview(
                                            isServerData: true,
                                            isBlackNWhite: widget.isBlackNWhite,
                                            hasBuilt: widget.hasBuilt,
                                            details: widget.details,
                                            option: widget.option,
                                            hasImage: hasImage,
                                            firstName: firstName,
                                            lastName: lastName,
                                            designation: jobTitle,
                                            imagePath: imagePath,
                                            address: address,
                                            phoneNo: phoneNo,
                                            emailAddress: emailAddress,
                                            skills: skills,
                                            education: education,
                                            experience: experience,
                                            project: project,
                                            certificate: certificate,
                                            profile: profile,
                                            rewardPoints: widget.rewardPoints,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: widget.hasImage == hasImage &&
                                          skills.length <= widget.skillMax &&
                                          education.length <=
                                              widget.educationMax &&
                                          (experience.length +
                                                  project.length +
                                                  certificate.length) <=
                                              widget.experiencePlusProjects
                                      ? Padding(
                                          padding: EdgeInsets.only(right: 6.w),
                                          child: Text(
                                            "Select",
                                            style: TextStyle(
                                                color: const Color(0xFF5cc43b),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                children: [
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  Text(
                                    "Professional Summary",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    profile,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  Text(
                                    "Contact Info",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icons/pinBlack.png",
                                        height: 20.h,
                                        width: 20.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text(
                                        capitalizeFirstLetterOfEachWord(
                                            address),
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icons/phoneCallBlack.png",
                                        height: 20.h,
                                        width: 20.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text(
                                        "+91 $phoneNo",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icons/emailBlack.png",
                                        height: 20.h,
                                        width: 20.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text(
                                        emailAddress,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  skills.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 32.h,
                                        ),
                                  skills.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          "Skills",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp),
                                        ),
                                  skills.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 6.h,
                                        ),
                                  skills.isEmpty
                                      ? const SizedBox.shrink()
                                      : Container(
                                          width: double.infinity,
                                          height: 1.h,
                                          color: Colors.black12,
                                        ),
                                  skills.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 16.h,
                                        ),
                                  skills.isEmpty
                                      ? const SizedBox.shrink()
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: skills.length,
                                          itemBuilder: (context, int index) {
                                            final skill = skills[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "• ${skill.skillName.toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    skillExpertise(
                                                        skill.expertise),
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                  education.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 32.h,
                                        ),
                                  education.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          "Education",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp),
                                        ),
                                  education.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 6.h,
                                        ),
                                  education.isEmpty
                                      ? const SizedBox.shrink()
                                      : Container(
                                          width: double.infinity,
                                          height: 1.h,
                                          color: Colors.black12,
                                        ),
                                  education.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 16.h,
                                        ),
                                  education.isEmpty
                                      ? const SizedBox.shrink()
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: education.length,
                                          itemBuilder: (context, int index) {
                                            final educations = education[index];
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "• ${educations.degree.toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "${educations.schoolOrCollege.toString()}, ${educations.city.toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    "${educations.start} -  ${educations.end}",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                  experience.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 20.h,
                                        ),
                                  experience.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          "Experience",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp),
                                        ),
                                  experience.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 6.h,
                                        ),
                                  experience.isEmpty
                                      ? const SizedBox.shrink()
                                      : Container(
                                          width: double.infinity,
                                          height: 1.h,
                                          color: Colors.black12,
                                        ),
                                  experience.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 16.h,
                                        ),
                                  experience.isEmpty
                                      ? const SizedBox.shrink()
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: experience.length,
                                          itemBuilder: (context, int index) {
                                            final experiences =
                                                experience[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "• ${experiences.jobTitle.toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "${experiences.employer.toString()}, ${experiences.city.toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    "${experiences.start}-  ${experiences.end}",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                  project.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 20.h,
                                        ),
                                  project.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          "Projects",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp),
                                        ),
                                  project.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 6.h,
                                        ),
                                  project.isEmpty
                                      ? const SizedBox.shrink()
                                      : Container(
                                          width: double.infinity,
                                          height: 1.h,
                                          color: Colors.black12,
                                        ),
                                  project.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 16.h,
                                        ),
                                  project.isEmpty
                                      ? const SizedBox.shrink()
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: project.length,
                                          itemBuilder: (context, int index) {
                                            final projects = project[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "• ${projects.projectName.toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    projects.projectDate,
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    projects.projectDescription
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                  certificate.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 20.h,
                                        ),
                                  certificate.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          "Certificate and Achievement",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp),
                                        ),
                                  certificate.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 6.h,
                                        ),
                                  certificate.isEmpty
                                      ? const SizedBox.shrink()
                                      : Container(
                                          width: double.infinity,
                                          height: 1.h,
                                          color: Colors.black12,
                                        ),
                                  certificate.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: 16.h,
                                        ),
                                  certificate.isEmpty
                                      ? const SizedBox.shrink()
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: certificate.length,
                                          itemBuilder: (context, int index) {
                                            final certificates =
                                                certificate[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "• ${certificates.issuedFor.toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    certificates.issuedOn,
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    certificates.issuingBody
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                  hasImage
                                      ? SizedBox(
                                          height: 32.h,
                                        )
                                      : const SizedBox.shrink(),
                                  hasImage
                                      ? Container(
                                          height: 340.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        imagePath),
                                                fit: BoxFit.cover),
                                          ))
                                      : const SizedBox.shrink(),
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
