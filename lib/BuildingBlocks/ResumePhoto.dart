import 'dart:io';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class ResumePhoto extends StatefulWidget {
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
  String address;
  String phoneNo;
  String emailAddress;
  double rewardPoints;

  ResumePhoto({
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
    required this.address,
    required this.phoneNo,
    required this.emailAddress,
    required this.rewardPoints,
  });

  @override
  State<ResumePhoto> createState() => _ResumePhotoState();
}

class _ResumePhotoState extends State<ResumePhoto> {
  //************************************** V A R I A B  L E S ***********************************
  var croppedFileVar;
  bool showError = false;
  bool isUploading = false;

  //************************************** F U N C T I O N S ***********************************

  Future<void> selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _cropImage(pickedFile);
        showError = false;
      });
    }
  }

  Future<void> _cropImage(var _pickedFile) async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
              hideBottomControls: true,
              toolbarTitle: 'Edit',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          croppedFileVar = croppedFile;
        });
      }
    }
  }

  Future<void> takePicture() async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      preferredCameraDevice: CameraDevice.rear,
      source: ImageSource.camera,
    );

    if (imageFile == null) return;
    _cropImage(imageFile);
  }

  void showPhotoOptions() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: const Color(0xFF101010),
        context: context,
        builder: (context) {
          return Container(
            height: 240.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Center(
                    child: Container(
                      height: 3.h,
                      width: 100.w,
                      color: Colors.black12,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    "Choose Option",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ListTile(
                    onTap: () {
                      takePicture();
                      Navigator.pop(context);
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 2.h),
                    leading: Icon(
                      CupertinoIcons.camera,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Camera",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      selectImage();
                      Navigator.pop(context);
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 2.h),
                    leading: Icon(
                      CupertinoIcons.photo_on_rectangle,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Gallery",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                  )
                ],
              ),
            ),
          );
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
          tween: Tween<double>(begin: 0.2222222222222, end: 0.3333333333333),
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
        //     tween: Tween<double>(begin: 0.2222222222222, end: 0.3333333333333),
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
          "Photo",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (croppedFileVar != null) {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.rightToLeftJoined,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                    child: Skills(
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
                      imagePath: croppedFileVar.path!.toString(),
                      address: widget.address,
                      phoneNo: widget.phoneNo,
                      emailAddress: widget.emailAddress,
                      rewardPoints: widget.rewardPoints,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    'Add a photo to continue!',
                    style: TextStyle(fontSize: 14.sp),
                  )),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text(
                "Next",
                style: TextStyle(
                    color: croppedFileVar != null
                        ? Colors.black
                        : const Color(0xFF899CB4),
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  showPhotoOptions();
                },
                child: Container(
                  height: 400.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      shape: BoxShape.rectangle,
                      color: const Color(0xFFF4F8FB),
                      border: Border.all(
                          color: const Color(0xFF899CB4).withOpacity(0.1),
                          width: 1.2.w)),
                  child: Container(
                    height: 400.h,
                    width: double.infinity,
                    decoration: croppedFileVar != null
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: FileImage(File(croppedFileVar!.path!)),
                              fit: BoxFit.cover,
                            ),
                          )
                        : null,
                    child: Center(
                      child: croppedFileVar != null
                          ? null
                          : Text(
                              "U P L O A D   P H O T O",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF899CB4),
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                )),
            SizedBox(
              height: 12.h,
            ),
            Text(
              "This particular resume template requires your photo.",
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp),
            ),
          ],
        ),
      ),
    );
  }
}
