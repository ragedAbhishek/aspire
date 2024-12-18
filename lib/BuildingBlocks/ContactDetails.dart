import "package:aspire/BuildingBlocks/ResumePhoto.dart";
import "package:aspire/BuildingBlocks/skills.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:page_transition/page_transition.dart";

// ignore: must_be_immutable
class ContactDetails extends StatefulWidget {
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
  double rewardPoints;

  ContactDetails({
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
    required this.rewardPoints,
  });
  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  //************************************** V A R I A B  L E S ***********************************

  final GlobalKey<FormState> _contactDetailsFormKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();

  final FocusNode _addressfocusNode = FocusNode();
  final FocusNode _phoneNofocusNode = FocusNode();
  final FocusNode _emailAddressfocusNode = FocusNode();

  bool isFilled = false;

//************************************** F U N C T I O N S ***********************************

  @override
  void dispose() {
    _addressController.dispose();
    _phoneNoController.dispose();
    _emailAddressController.dispose();
    _addressfocusNode.dispose();
    _phoneNofocusNode.dispose();
    _emailAddressfocusNode.dispose();
    super.dispose();
  }

  void check() {
    if (_addressController.text.isNotEmpty &&
        _phoneNoController.text.isNotEmpty &&
        _emailAddressController.text.isNotEmpty &&
        _phoneNoController.text.length == 10) {
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
              ? Tween<double>(begin: 0.1111111111111, end: 0.2222222222222)
              : Tween<double>(begin: 0.125, end: 0.25),
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
        //         ? Tween<double>(begin: 0.1111111111111, end: 0.2222222222222)
        //         : Tween<double>(begin: 0.125, end: 0.25),
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
          "Contact Details",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_contactDetailsFormKey.currentState!.validate()) {
                if (_contactDetailsFormKey.currentState!.validate()) {
                  if (widget.hasImage) {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: widget,
                        duration: const Duration(milliseconds: 200),
                        reverseDuration: const Duration(milliseconds: 200),
                        child: ResumePhoto(
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
                          address: _addressController.text.trim(),
                          phoneNo: _phoneNoController.text.trim(),
                          emailAddress: _emailAddressController.text.trim(),
                          rewardPoints: widget.rewardPoints,
                        ),
                      ),
                    );
                  } else {
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
                          professionSummaryMaxWord:
                              widget.professionSummaryMaxWord,
                          skillMax: widget.skillMax,
                          educationMax: widget.educationMax,
                          experiencePlusProjects: widget.experiencePlusProjects,
                          firstName: widget.firstName,
                          lastName: widget.lastName,
                          designation: widget.designation,
                          imagePath: "",
                          address: _addressController.text.trim(),
                          phoneNo: _phoneNoController.text.trim(),
                          emailAddress: _emailAddressController.text.trim(),
                          rewardPoints: widget.rewardPoints,
                        ),
                      ),
                    );
                  }
                }
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Form(
          key: _contactDetailsFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Add your contact info so that hiring team can contact you.",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 17.sp),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "City and State",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  focusNode: _addressfocusNode,
                  controller: _addressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your address ";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    check();
                  },
                  onFieldSubmitted: (value) {
                    _addressfocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_phoneNofocusNode);
                  },
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "eg. Bhopal, Madhya Pradesh",
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
                  "Phone no.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  focusNode: _phoneNofocusNode,
                  controller: _phoneNoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your Phone no. ";
                    } else if (value.length != 10) {
                      return "Enter a valid phone no.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    check();
                  },
                  onFieldSubmitted: (value) {
                    _phoneNofocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_emailAddressfocusNode);
                  },
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "Your Phone no.",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          color: Colors.black12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.6.w),
                      )),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                ),
                SizedBox(
                  height: 28.h,
                ),
                Text(
                  "Email address",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  focusNode: _emailAddressfocusNode,
                  controller: _emailAddressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your email address";
                    } else if (value.endsWith(".com") == false) {
                      return "Enter a valid email address";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    check();
                  },
                  onFieldSubmitted: (value) {
                    _emailAddressfocusNode.unfocus();
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "Your email address",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
