import "dart:io";
import "dart:math";
import "package:aspire/BuildingBlocks/Certificate.dart";
import "package:aspire/BuildingBlocks/Educations.dart";
import "package:aspire/BuildingBlocks/Experience.dart";
import "package:aspire/BuildingBlocks/Projects.dart";
import "package:aspire/BuildingBlocks/skills.dart";
import "package:aspire/Utils/appControl.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import "package:aspire/Utils/methods.dart";
import "package:aspire/buildingExtras/pdfPreview.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:page_transition/page_transition.dart";

// ignore: must_be_immutable
class DetailsPreview extends StatefulWidget {
  bool isServerData;
  bool hasBuilt;
  List details;
  int option;
  bool hasImage;
  bool isBlackNWhite;
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
  String profile;
  double rewardPoints;

  DetailsPreview({
    super.key,
    required this.isServerData,
    required this.hasBuilt,
    required this.details,
    required this.option,
    required this.hasImage,
    required this.isBlackNWhite,
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
    required this.profile,
    required this.rewardPoints,
  });

  @override
  State<DetailsPreview> createState() => _DetailsPreviewState();
}

class _DetailsPreviewState extends State<DetailsPreview> {
  bool isBuilding = false;
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

  void _build() {
    widget.isServerData ? null : savedDataToServer();

    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeftJoined,
        childCurrent: widget,
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200),
        child: PdfPreviewPage(
          hasBuilt: widget.hasBuilt,
          details: widget.details,
          isServerData: widget.isServerData,
          isBlackNWhite: widget.isBlackNWhite,
          hasSaved: false,
          option: widget.option,
          hasImage: widget.hasImage,
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
          profile: widget.profile,
          certificate: widget.certificate,
        ),
      ),
    );
  }

  Future<void> _processImage() async {
    setState(() {
      isBuilding = true;
    });
    widget.isServerData ? null : savedDataToServer();

    img.Image? image;

    if (widget.isServerData) {
      // Load image from network
      final response = await http.get(Uri.parse(widget.imagePath));
      if (response.statusCode == 200) {
        image = img.decodeImage(response.bodyBytes);
      }
    } else {
      // Load image from local path
      // ignore: unnecessary_null_comparison
      if (widget.imagePath != null) {
        image = img.decodeImage(await File(widget.imagePath!).readAsBytes());
      }
    }

    if (image != null) {
      // Convert image to black and white
      final blackAndWhiteImage = img.grayscale(image);

      // Save the black and white image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/bw_image.jpg')
        ..writeAsBytesSync(img.encodeJpg(blackAndWhiteImage));

      if (tempFile.existsSync()) {
        setState(() {
          isBuilding = false;
        });

        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: widget,
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 200),
            child: PdfPreviewPage(
              hasBuilt: widget.hasBuilt,
              isServerData: widget
                  .isServerData, // USED JUST FOR SAVING SERVER SAVED IMAGE LINK
              isBlackNWhite: widget.isBlackNWhite,

              details: widget.details,
              hasSaved: false,
              option: widget.option,
              hasImage: widget.hasImage,
              firstName: widget.firstName,
              lastName: widget.lastName,
              designation: widget.designation,
              imagePath: tempFile.path,
              address: widget.address,
              phoneNo: widget.phoneNo,
              emailAddress: widget.emailAddress,
              skills: widget.skills,
              education: widget.education,
              experience: widget.experience,
              project: widget.project,
              certificate: widget.certificate,
              profile: widget.profile,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Details Preview",
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
                    height: 16.h,
                  ),
                  widget.hasImage
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 112.h,
                              width: 112.w,
                              decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(24.r),
                                  image: widget.isServerData
                                      ? DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              widget.imagePath),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: FileImage(File(
                                            widget.imagePath,
                                          )),
                                          fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    "${capitalizeFirstLetterOfEachWord(widget.firstName)} ${capitalizeFirstLetterOfEachWord(widget.lastName)}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    widget.designation,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${capitalizeFirstLetterOfEachWord(widget.firstName)} ${capitalizeFirstLetterOfEachWord(widget.lastName)}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp),
                            ),
                            Text(
                              widget.designation,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    widget.profile,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        capitalizeFirstLetterOfEachWord(widget.address),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        "+91 ${widget.phoneNo}",
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        widget.emailAddress,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp),
                      ),
                    ],
                  ),
                  widget.skills.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 32.h,
                        ),
                  widget.skills.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          "Skills",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp),
                        ),
                  widget.skills.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 6.h,
                        ),
                  widget.skills.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          width: double.infinity,
                          height: 1.h,
                          color: Colors.black12,
                        ),
                  widget.skills.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 16.h,
                        ),
                  widget.skills.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.skills.length,
                          itemBuilder: (context, int index) {
                            final skill = widget.skills[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ${skill.skillName.toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    skillExpertise(skill.expertise),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  widget.education.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 32.h,
                        ),
                  widget.education.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          "Education",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp),
                        ),
                  widget.education.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 6.h,
                        ),
                  widget.education.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          width: double.infinity,
                          height: 1.h,
                          color: Colors.black12,
                        ),
                  widget.education.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 16.h,
                        ),
                  widget.education.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.education.length,
                          itemBuilder: (context, int index) {
                            final education = widget.education[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ${education.degree.toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${education.schoolOrCollege.toString()}, ${education.city.toString()}",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${education.start} -  ${education.end}",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  widget.experience.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 20.h,
                        ),
                  widget.experience.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          "Experience",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp),
                        ),
                  widget.experience.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 6.h,
                        ),
                  widget.experience.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          width: double.infinity,
                          height: 1.h,
                          color: Colors.black12,
                        ),
                  widget.experience.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 16.h,
                        ),
                  widget.experience.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.experience.length,
                          itemBuilder: (context, int index) {
                            final experience = widget.experience[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ${experience.jobTitle.toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${experience.employer.toString()}, ${experience.city.toString()}",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${experience.start}-  ${experience.end}",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  widget.project.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 20.h,
                        ),
                  widget.project.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          "Projects",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp),
                        ),
                  widget.project.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 6.h,
                        ),
                  widget.project.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          width: double.infinity,
                          height: 1.h,
                          color: Colors.black12,
                        ),
                  widget.project.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 16.h,
                        ),
                  widget.project.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.project.length,
                          itemBuilder: (context, int index) {
                            final project = widget.project[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ${project.projectName.toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    project.projectDate,
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    project.projectDescription.toString(),
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  widget.certificate.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 20.h,
                        ),
                  widget.certificate.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          "Certificate and Achievement",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp),
                        ),
                  widget.certificate.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 6.h,
                        ),
                  widget.certificate.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          width: double.infinity,
                          height: 1.h,
                          color: Colors.black12,
                        ),
                  widget.certificate.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 16.h,
                        ),
                  widget.certificate.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.certificate.length,
                          itemBuilder: (context, int index) {
                            final certificates = widget.certificate[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ${certificates.issuedFor.toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    certificates.issuedOn,
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    certificates.issuingBody.toString(),
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  SizedBox(
                    height: 140.h,
                  )
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 82.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: isBuilding
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 17.h,
                                    width: 17.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.w,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  "Building resume, Please wait...",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 12.h),
                          child: GestureDetector(
                            onTap: () {
                              widget.isServerData
                                  ? widget.hasImage
                                      ? widget.isBlackNWhite
                                          ? _processImage()
                                          : _build()
                                      : _build()
                                  : widget.isBlackNWhite
                                      ? _processImage()
                                      : _build();
                            },
                            child: Container(
                              height: 62,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF899CB4)
                                          .withOpacity(0.1),
                                      width: 1.2.w),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: Center(
                                  child: Text(
                                "Build resume",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.sp),
                              )),
                            ),
                          ),
                        )))
        ],
      ),
    );
  }

  String generateRandomCode() {
    final Random random = Random();
    const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';

    String code = '';
    code += alphabet[random.nextInt(alphabet.length)];
    code += alphabet[random.nextInt(alphabet.length)];

    for (int i = 0; i < 14; i++) {
      code += numbers[random.nextInt(numbers.length)];
    }

    return code;
  }

  void savedDataToServer() {
    String detail_code = generateRandomCode();

    if (widget.hasImage) {
      uploadImage(File(widget.imagePath), detail_code);
    } else {
      saveData("", detail_code);
    }
  }

  UploadTask? uploadTask;

  Future<void> uploadImage(File file, String detail_code) async {
    final ref = FirebaseStorage.instance.ref().child(
        "savedDetailsImage/${AppControl.loggedInUser}_${detail_code}.jpg");
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!;
    final urlDownload = await snapshot.ref.getDownloadURL();
    if (urlDownload.isNotEmpty) {
      saveData(urlDownload, detail_code);
    }
  }

  Future<void> saveData(imageUrl, detail_code) async {
    List<Map<String, dynamic>> skillData = widget.skills
        .map((skillEntry) => {
              'skillName': skillEntry.skillName,
              'expertise': skillEntry.expertise,
            })
        .toList();
    List<Map<String, dynamic>> educationData = widget.education
        .map((educationEntry) => {
              'degree': educationEntry.degree,
              'schoolOrCollege': educationEntry.schoolOrCollege,
              'start': educationEntry.start,
              'end': educationEntry.end,
              'city': educationEntry.city,
            })
        .toList();
    List<Map<String, dynamic>> experienceData = widget.experience
        .map((experienceEntry) => {
              'jobTitle': experienceEntry.jobTitle,
              'employer': experienceEntry.employer,
              'city': experienceEntry.city,
              'description': experienceEntry.description,
              'start': experienceEntry.start,
              'end': experienceEntry.end,
            })
        .toList();
    List<Map<String, dynamic>> projectData = widget.project
        .map((projectEntry) => {
              'projectName': projectEntry.projectName,
              'projectDescription': projectEntry.projectDescription,
              'projectDate': projectEntry.projectDate,
            })
        .toList();
    List<Map<String, dynamic>> certificateData = widget.certificate
        .map((CertificateEntry) => {
              'issuingBody': CertificateEntry.issuingBody,
              'issuedFor': CertificateEntry.issuedFor,
              'issuedOn': CertificateEntry.issuedOn,
            })
        .toList();

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference listedItemsCollection =
          firestore.collection('savedDetails');

      Map<String, dynamic> data = {
        'hasImage': widget.hasImage,
        'firstName': widget.firstName,
        'lastName': widget.lastName,
        'jobTitle': widget.designation,
        'imagePath': imageUrl,
        'address': widget.address,
        'phoneNo': widget.phoneNo,
        'emailAddress': widget.emailAddress,
        'skills': skillData,
        'education': educationData,
        'experience': experienceData,
        'project': projectData,
        'certificate': certificateData,
        'profile': widget.profile,
        'savedOn': DateTime.now()
      };

      await listedItemsCollection.doc(detail_code).set(data);

      print('Data saved to Firebase');
    } catch (error) {
      print('Error saving data: $error');
    }

    final DocumentReference reference = FirebaseFirestore.instance
        .collection('userData')
        .doc(AppControl.loggedInUser);
    reference.update({
      'savedDetails': FieldValue.arrayUnion([detail_code]),
    });
    setState(() {});
  }
}
