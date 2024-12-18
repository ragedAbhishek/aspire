import 'package:aspire/ResumeCodes/resume10Ten.dart';
import 'package:aspire/ResumeCodes/resume4Four.dart';
import 'package:aspire/ResumeCodes/resume5Five.dart';
import 'package:aspire/ResumeCodes/resume6Six.dart';
import 'package:aspire/ResumeCodes/resume7Seven.dart';
import 'package:aspire/ResumeCodes/resume8Eight.dart';
import 'package:aspire/ResumeCodes/resume9Nine.dart';
import 'package:aspire/BuildingBlocks/Certificate.dart';
import 'package:aspire/BuildingBlocks/Educations.dart';
import 'package:aspire/BuildingBlocks/Experience.dart';
import 'package:aspire/BuildingBlocks/Projects.dart';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:aspire/ResumeCodes/resume2Two.dart';
import 'package:aspire/ResumeCodes/resume3Three.dart';
import 'package:aspire/ResumeCodes/resume1One.dart';
import 'package:aspire/Utils/appControl.dart';
import 'package:aspire/buildingExtras/pdfPreview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:printing/printing.dart';
import 'package:shimmer/shimmer.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  Color baseColor = const Color.fromARGB(31, 53, 53, 53);
  Color highlightColor = Colors.white10;
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

  Future<Map<String, dynamic>> getDetails(String itemId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('savedResume')
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
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('userData')
            .doc(AppControl.loggedInUser.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            //***************************************** SAVEPAGE LOADING SCREEN ***********************************************/
            return Scaffold(
                backgroundColor: const Color(0xFFf2f2f2),
                appBar: AppBar(
                  backgroundColor: const Color(0xFFf2f2f2),
                  scrolledUnderElevation: 0,
                  title: Text(
                    "Saved",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: 550.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.r))),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                            height: 550.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.r))),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                            height: 550.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.r))),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ));
          }

          var data = snapshot.data!.data()!;

          List savedResume = data['savedResume'] ?? [];
          bool hasBuilt = data['hasBuilt'] ?? false;

          return Scaffold(
            backgroundColor:
                savedResume.isEmpty ? Colors.white : const Color(0xFFf2f2f2),
            appBar: AppBar(
              backgroundColor:
                  savedResume.isEmpty ? Colors.white : const Color(0xFFf2f2f2),
              scrolledUnderElevation: 0,
              title: Text(
                "Saved resumes",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    savedResume.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Lottie.asset("assets/animations/none.json",
                                    repeat: false,
                                    height: 300.h,
                                    fit: BoxFit.cover),
                                Text(
                                  "You havn't saved any resume yet!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: savedResume.length,
                            itemBuilder: (context, index) {
                              String saved = savedResume[index];
                              return FutureBuilder<Map<String, dynamic>>(
                                future: getDetails(saved),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                        baseColor: baseColor,
                                        highlightColor: highlightColor,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 20.h),
                                          child: Container(
                                              height: 550.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r))),
                                        ));
                                  } else {
                                    Map<String, dynamic> data =
                                        snapshot.data ?? {};
                                    int option = data['option'] ?? 1;
                                    List details = data['details'] ?? [];
                                    bool hasImage = data['hasImage'] ?? false;
                                    String firstName = data['firstName'] ?? '';
                                    String lastName = data['lastName'] ?? '';
                                    String jobTitle = data['jobTitle'] ?? '';
                                    String imagePath = data['imagePath'] ?? '';
                                    String address = data['address'] ?? '';
                                    String phoneNo = data['phoneNo'] ?? '';
                                    // var savedOn = data['savedOn'];
                                    String emailAddress =
                                        data['emailAddress'] ?? '';
                                    List<SkillEntry> skills =
                                        _convertToSkillEntries(
                                            data['skills'] ?? []);
                                    List<EducationEntry> education =
                                        _convertToEducationEntries(
                                            data['education'] ?? []);
                                    List<ExperienceEntry> experience =
                                        _convertToExperienceEntries(
                                            data['experience'] ?? []);
                                    List<ProjectEntry> project =
                                        _convertToProjectEntries(
                                            data['project'] ?? []);
                                    List<CertificateEntry> certificate =
                                        _convertToCertificateEntries(
                                            data['certificate'] ?? []);
                                    String profile = data['profile'] ?? '';

                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeftJoined,
                                              childCurrent: widget,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              reverseDuration: const Duration(
                                                  milliseconds: 200),
                                              child: PdfPreviewPage(
                                                hasBuilt: hasBuilt,
                                                details: details,
                                                isServerData:
                                                    false, // USED JUST FOR SAVED DATA IMAGE - DONT BOTHER
                                                isBlackNWhite:
                                                    false, // USED JUST FOR SAVED DATA IMAGE - DONT BOTHER
                                                hasSaved: true,
                                                option: option,
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
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12.h),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  182,
                                                                  182,
                                                                  182)
                                                              .withOpacity(0.1),
                                                      spreadRadius: 0,
                                                      blurRadius: 16,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                  color:
                                                      const Color(0xFFF8F8F8),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  12.r))),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.r),
                                                          color: Colors.white),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    14.h,
                                                                vertical: 25.w),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 40.h,
                                                              width: 40.w,
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .black12,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: Center(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/icons/document.png",
                                                                  height: 24.h,
                                                                  width: 24.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 12.w,
                                                            ),
                                                            Text(
                                                              "Download resume",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              width: 92.h,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              color: Colors
                                                                  .black54,
                                                              size: ScreenUtil()
                                                                  .setSp(16),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(
                                                    color:
                                                        const Color(0xFFF8F8F8),
                                                    height: 484.h,
                                                    child: PdfPreview(
                                                        pages: const [0],
                                                        pdfPreviewPageDecoration:
                                                            const BoxDecoration(
                                                                color: Colors
                                                                    .white),
                                                        useActions: false,
                                                        build: (context) {
                                                          if (option == 1) {
                                                            return resumeOne(
                                                                hasSaved: true,
                                                                isServerData:
                                                                    true,
                                                                isBlackNWhite:
                                                                    false,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                imagePath:
                                                                    imagePath,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else if (option ==
                                                              2) {
                                                            return resumeTwo(
                                                                hasSaved: true,
                                                                isServerData:
                                                                    false,
                                                                isBlackNWhite:
                                                                    false,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                emailAddress:
                                                                    emailAddress,
                                                                imagePath:
                                                                    imagePath,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else if (option ==
                                                              3) {
                                                            return resumeThree(
                                                                hasSaved: true,
                                                                isServerData:
                                                                    false,
                                                                isBlackNWhite:
                                                                    false,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                imagePath:
                                                                    imagePath,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else if (option ==
                                                              4) {
                                                            return resumeFour(
                                                                hasSaved: true,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else if (option ==
                                                              5) {
                                                            return resumeFive(
                                                                hasSaved: true,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else if (option ==
                                                              6) {
                                                            return resumeSix(
                                                                hasSaved: true,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else if (option ==
                                                              7) {
                                                            return resumeSeven(
                                                                hasSaved: true,
                                                                isServerData:
                                                                    false,
                                                                isBlackNWhite:
                                                                    false,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                imagePath:
                                                                    imagePath,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else if (option ==
                                                              8) {
                                                            return resumeEight(
                                                                hasSaved: true,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else if (option ==
                                                              9) {
                                                            return resumeNine(
                                                                hasSaved: true,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          } else {
                                                            return resumeTen(
                                                                hasSaved: true,
                                                                firstName:
                                                                    firstName,
                                                                lastName:
                                                                    lastName,
                                                                designation:
                                                                    jobTitle,
                                                                address:
                                                                    address,
                                                                phoneNo:
                                                                    phoneNo,
                                                                emailAddress:
                                                                    emailAddress,
                                                                skill: skills,
                                                                education:
                                                                    education,
                                                                experience:
                                                                    experience,
                                                                project:
                                                                    project,
                                                                certificate:
                                                                    certificate,
                                                                profile:
                                                                    profile);
                                                          }
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            )));
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
        });
  }
}
