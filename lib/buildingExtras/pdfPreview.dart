import 'dart:io';
import 'dart:math';
import 'package:aspire/BuildingBlocks/Certificate.dart';
import 'package:aspire/BuildingBlocks/Educations.dart';
import 'package:aspire/BuildingBlocks/Experience.dart';
import 'package:aspire/BuildingBlocks/Projects.dart';
import 'package:aspire/BuildingBlocks/skills.dart';
import 'package:aspire/Extras/conts.dart';
import 'package:aspire/ResumeCodes/resume10Ten.dart';
import 'package:aspire/ResumeCodes/resume4Four.dart';
import 'package:aspire/ResumeCodes/resume2Two.dart';
import 'package:aspire/ResumeCodes/resume3Three.dart';
import 'package:aspire/ResumeCodes/resume1One.dart';
import 'package:aspire/ResumeCodes/resume5Five.dart';
import 'package:aspire/ResumeCodes/resume6Six.dart';
import 'package:aspire/ResumeCodes/resume7Seven.dart';
import 'package:aspire/ResumeCodes/resume8Eight.dart';
import 'package:aspire/ResumeCodes/resume9Nine.dart';
import 'package:aspire/Utils/appControl.dart';
import 'package:aspire/Utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class PdfPreviewPage extends StatefulWidget {
  bool hasBuilt;
  bool isServerData;
  bool isBlackNWhite;
  List details;
  bool hasSaved;
  int option;
  bool hasImage;
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

  PdfPreviewPage({
    super.key,
    required this.hasBuilt,
    required this.isServerData,
    required this.isBlackNWhite,
    required this.details,
    required this.hasSaved,
    required this.option,
    required this.hasImage,
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
  });

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  final _razorpay = Razorpay();
  bool isPaymentSucessfull = false;
  bool isSavingToServer = false;
  bool isChecking = false;
  double discountPercent = 0.00;
  List rewardInfo = [];
  Color baseColor = const Color.fromARGB(31, 53, 53, 53);
  Color highlightColor = Colors.white10;
  TextEditingController couponCode = TextEditingController();
  final GlobalKey<FormState> _pdfPreviewPageKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //******************************************* R A Z O R   P A Y    C O D E S   H E R E ***************************************

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    makePaymentAndSaveDataToServer(false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(
        msg: "Payment Declined",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  //******************************************* F U N C T I O N S   H E R E ***************************************

  void checkForCouponCode(String code) async {
    setState(() {
      isChecking = true;
    });
    final DocumentSnapshot userDoc =
        await _firestore.collection('coupons').doc(code).get();
    if (!userDoc.exists) {
      // Does Not Exists
      rewardInfo = ["INVALID"];

      // print("*********** I N V A L I D   C O U P O N");
    } else {
      // Exists
      // print("*********** V A L I D   C O U P O N");

      FirebaseFirestore.instance
          .collection("coupons")
          .doc(code)
          .get()
          .then((docSnapshot) {
        var data = docSnapshot.data();
        String couponType = data?["couponType"] ?? "";
        String createdBy = data?["createdBy"] ?? "";
        double discountPercentage = data?["discountPercentage"] ?? 0.00;
        int maxRedeemAllow = data?["maxRedeemAllowed"] ?? 0;
        int redeemed = data?["redeemed"] ?? 0;
        String code = data?["code"] ?? "";
        if (maxRedeemAllow > redeemed) {
          if (createdBy == AppControl.loggedInUser) {
            setState(() {
              rewardInfo = ["INVALID"];
              discountPercent = 0.00;
            });
          } else {
            setState(() {
              discountPercent = discountPercentage;
              rewardInfo = [
                couponType,
                createdBy,
                discountPercentage,
                maxRedeemAllow,
                redeemed,
                code
              ];
            });
          }
        } else {
          setState(() {
            discountPercent = 0;

            rewardInfo = [
              couponType,
              createdBy,
              discountPercentage,
              maxRedeemAllow,
              redeemed,
              code
            ];
          });
        }
      });
    }

    setState(() {
      isChecking = false;
    });
  }

  void showPaymentOptions(
      bool isRefferal, double rewardPoints, String countryCode) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r))),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  "Select payment method",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: () {
                    isRefferal
                        ? Fluttertoast.showToast(
                            msg: "Cannot use with refferal code applied.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0)
                        : rewardPoints >=
                                (widget.details[2] -
                                    ((widget.details[2] / 100) *
                                        discountPercent))
                            ? makePaymentAndSaveDataToServer(true)
                            : Fluttertoast.showToast(
                                msg: "Insufficient amount",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 142, 142, 142)
                                .withOpacity(0.1),
                            spreadRadius: 4,
                            blurRadius: 16,
                            offset: const Offset(4, 2),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 115.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r)),
                              image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/icons/giftCard.png",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Reward Points",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        "You can pay using reward points. Your available balance is ",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp),
                                  ),
                                  TextSpan(
                                    text:
                                        "${countryCodeToCurrencySymbol(countryCode)}${rewardPoints.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.sp),
                                  )
                                ])),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black45,
                          size: 16.sp,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                GestureDetector(
                    onTap: () {
                      var options = {
                        'key': RAZORPAY_KEY,
                        'amount': (((widget.details[2] -
                                        ((widget.details[2] / 100) *
                                            discountPercent)) +
                                    0.01) *
                                100)
                            .toInt(),
                        'name': 'Aspire',
                        "currency":
                            countryCodeToCurrency(countryCode).toString(),
                        'description':
                            "Name: ${widget.firstName.toString()} ${widget.lastName.toString()}\nAddress: ${widget.address.toString()}",
                        'timeout': 300,
                        'prefill': {
                          'contact': "+91 ${widget.phoneNo.toString()}",
                          'email': AppControl.loggedInUser
                        }
                      };
                      _razorpay.open(options);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 142, 142, 142)
                                  .withOpacity(0.1),
                              spreadRadius: 4,
                              blurRadius: 16,
                              offset: const Offset(4, 2),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 115.h,
                            width: 115.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    bottomLeft: Radius.circular(20.r)),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/icons/wallet.png",
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          SizedBox(
                            width: 200,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pay using",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    "UPI, Debit card, Credit card, Google Pay, PhonePe, BHIM UPI or Paytm.",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black45,
                            size: 16.sp,
                          )
                        ],
                      ),
                    )),
                const Spacer(),
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Powered by ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400)),
                    WidgetSpan(
                        child: Image.asset(
                      "assets/icons/razorpayLogo.png",
                      color: Colors.blue,
                      height: 20.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    ))
                  ])),
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void removePreviousPages(BuildContext context, int count) {
  //   int popCount = 0;
  //   Navigator.of(context).popUntil((route) {
  //     return popCount++ >= count;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0XFFECECEC),
    ));
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
            //*****************************************  LOADING SCREEN ***********************************************/
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
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
                title: Text(
                  'Preview',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                child: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: double.infinity,
                    height: 500.h,
                    decoration: const BoxDecoration(color: Colors.black),
                  ),
                ),
              ),
            );
          }

          var data = snapshot.data!.data()!;

          double rewardPoints = data["rewardPoints"] ?? 0.00;
          String countryCode = data["countryCode"] ?? "";

          return Scaffold(
            backgroundColor: const Color(0xFFD1D1D1),
            appBar: AppBar(
              backgroundColor: const Color(0xFFBEBEBE),
              centerTitle: true,
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
              title: Text(
                'Preview',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: PdfPreview(
                pdfPreviewPageDecoration:
                    const BoxDecoration(color: Colors.white),
                actionBarTheme: const PdfActionBarTheme(
                    backgroundColor: Colors.white, elevation: 0),
                actions: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Form(
                      key: _pdfPreviewPageKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 12.h,
                            ),
                            isPaymentSucessfull || widget.hasSaved
                                ? Center(
                                    child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "Resume has been ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.sp)),
                                          TextSpan(
                                              text: "sucessfully saved",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF5cc43b),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp)),
                                          TextSpan(
                                              text: ". You can ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.sp)),
                                          TextSpan(
                                              text: "Download",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF5cc43b),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp)),
                                          TextSpan(
                                              text: " it anytime.",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.sp)),
                                        ])),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 276,
                                            child: TextFormField(
                                              onFieldSubmitted: (value) {
                                                if (_pdfPreviewPageKey
                                                    .currentState!
                                                    .validate()) {
                                                  checkForCouponCode(couponCode
                                                      .text
                                                      .trim()
                                                      .toUpperCase());
                                                }
                                              },
                                              controller: couponCode,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "*Enter Coupon Code";
                                                } else if (value.length != 8) {
                                                  return "Enter Valid Code";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w500),
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                  // filled: true,
                                                  // fillColor: Colors.black12
                                                  //     .withOpacity(0.08),
                                                  hintText:
                                                      "Have a coupon?Type it here",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1.4.w,
                                                          color:
                                                              Colors.black38)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1.4.w,
                                                              color: Colors
                                                                  .black38))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (_pdfPreviewPageKey
                                                  .currentState!
                                                  .validate()) {
                                                checkForCouponCode(couponCode
                                                    .text
                                                    .trim()
                                                    .toUpperCase());
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18.w,
                                                  vertical: 14.h),
                                              child: Center(
                                                child: Text(
                                                  "Apply",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFF5cc43b),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 19.sp),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      isChecking
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 17.h,
                                                  width: 17.w,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2.w,
                                                          backgroundColor:
                                                              Colors.black12,
                                                          color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Text(
                                                  "Checking...",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16.sp),
                                                )
                                              ],
                                            )
                                          : rewardInfo.isEmpty
                                              ? const SizedBox.shrink()
                                              : rewardInfo[0] == "INVALID"
                                                  ? Text(
                                                      "Coupon Not Found!",
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 159, 15, 5),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13.sp),
                                                    )
                                                  : rewardInfo[3] >
                                                          rewardInfo[4]
                                                      ? Text(
                                                          "Coupon applied successfully!",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13.sp),
                                                        )
                                                      : Text(
                                                          "Already Redeemed!",
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  159, 15, 5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13.sp),
                                                        ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "To Pay",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19.sp),
                                          ),
                                          Text(
                                            "${countryCodeToCurrencySymbol(countryCode)}${(widget.details[2] - ((widget.details[2] / 100) * discountPercent)).toStringAsFixed(2)} ${countryCodeToCurrency(countryCode)}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 21.sp),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0.h,
                                      ),
                                      discountPercent != 0
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Spacer(),
                                                Text(
                                                  "-${countryCodeToCurrencySymbol(countryCode)}${((widget.details[2] / 100) * discountPercent).toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15.sp),
                                                )
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      Text(
                                        "Pay and download resume.",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      )
                                    ],
                                  ),
                            widget.hasSaved || isPaymentSucessfull
                                ? PdfPreviewAction(
                                    icon: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(16.r)),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.h),
                                            child: Center(
                                              child: Text(
                                                "Download",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                      ),
                                    ),
                                    onPressed:
                                        (context, build, pageFormat) async {
                                      final pdf = await build(pageFormat);
                                      await Printing.layoutPdf(
                                        onLayout:
                                            (PdfPageFormat format) async => pdf,
                                      );
                                    },
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: InkWell(
                                        onTap: () {
                                          showPaymentOptions(
                                              discountPercent != 0 &&
                                                      rewardInfo[0] ==
                                                          "Referral"
                                                  ? true
                                                  : false,
                                              rewardPoints,
                                              countryCode);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(16.r)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.h),
                                            child: Center(
                                                child: isSavingToServer
                                                    ? Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 17.h,
                                                            width: 17.w,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth:
                                                                    2.w,
                                                                color: Colors
                                                                    .white,
                                                                backgroundColor:
                                                                    Colors
                                                                        .black12,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8.w,
                                                          ),
                                                          Text(
                                                            "Processing...",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )
                                                    : Text(
                                                        "Proceed to Checkout",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                          ),
                                        )))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
                canChangeOrientation: false,
                canChangePageFormat: false,
                allowPrinting: false,
                allowSharing: false,
                canDebug: false,
                // useActions: false,
                pdfFileName: "Resume.pdf",
                build: (context) {
                  if (widget.option == 1) {
                    return resumeOne(
                        hasSaved: widget.hasSaved,
                        isServerData: widget.isServerData,
                        isBlackNWhite: widget.isBlackNWhite,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        imagePath: widget.imagePath,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else if (widget.option == 2) {
                    return resumeTwo(
                        hasSaved: widget.hasSaved,
                        isServerData: widget.isServerData,
                        isBlackNWhite: widget.isBlackNWhite,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        emailAddress: widget.emailAddress,
                        imagePath: widget.imagePath,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else if (widget.option == 3) {
                    return resumeThree(
                        hasSaved: widget.hasSaved,
                        isServerData: widget.isServerData,
                        isBlackNWhite: widget.isBlackNWhite,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        imagePath: widget.imagePath,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else if (widget.option == 4) {
                    return resumeFour(
                        hasSaved: widget.hasSaved,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else if (widget.option == 5) {
                    return resumeFive(
                        hasSaved: widget.hasSaved,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else if (widget.option == 6) {
                    return resumeSix(
                        hasSaved: widget.hasSaved,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else if (widget.option == 7) {
                    return resumeSeven(
                        hasSaved: widget.hasSaved,
                        isServerData: widget.isServerData,
                        isBlackNWhite: widget.isBlackNWhite,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        imagePath: widget.imagePath,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else if (widget.option == 8) {
                    return resumeEight(
                        hasSaved: widget.hasSaved,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else if (widget.option == 9) {
                    return resumeNine(
                        hasSaved: widget.hasSaved,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  } else {
                    return resumeTen(
                        hasSaved: widget.hasSaved,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        designation: widget.designation,
                        address: widget.address,
                        phoneNo: widget.phoneNo,
                        emailAddress: widget.emailAddress,
                        skill: widget.skills,
                        education: widget.education,
                        experience: widget.experience,
                        project: widget.project,
                        certificate: widget.certificate,
                        profile: widget.profile,
                        countryCode: countryCode);
                  }
                }),
          );
        });
  }

  String generateDocumentID() {
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

  String generateCouponID(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  void makePaymentAndSaveDataToServer(bool isRewardPurchase) {
    setState(() {
      isSavingToServer = true;
    });
    String detail_code = generateDocumentID();

    if (widget.hasImage) {
      if (widget.isServerData) {
        if (widget.isBlackNWhite) {
          uploadImage(File(widget.imagePath), detail_code, isRewardPurchase);
        } else {
          saveData(widget.imagePath, detail_code, isRewardPurchase);
        }
      } else {
        uploadImage(File(widget.imagePath), detail_code, isRewardPurchase);
      }
    } else {
      saveData("", detail_code, isRewardPurchase);
    }
  }

  UploadTask? uploadTask;

  Future<void> uploadImage(
      File file, String detail_code, bool isRewardPurchase) async {
    final ref = FirebaseStorage.instance.ref().child(
        "savedResumeImage/${AppControl.loggedInUser}_${detail_code}.jpg");
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!;
    final urlDownload = await snapshot.ref.getDownloadURL();
    if (urlDownload.isNotEmpty) {
      saveData(urlDownload, detail_code, isRewardPurchase);
    }
  }

  Future<void> saveData(imageUrl, detail_code, isRewardPurchase) async {
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
          firestore.collection('savedResume');

      Map<String, dynamic> data = {
        'option': widget.option,
        'details': widget.details,
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

      // print('Data saved to Firebase');
    } catch (error) {
      // print('Error saving data: $error');
    }

    // CODE TO ADD RESUME TO USERDATA
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('userData')
        .doc(AppControl.loggedInUser);
    reference.update({
      'savedResume': FieldValue.arrayUnion([detail_code]),
    });

    // CODE TO CREATE REFERRAL COUPON
    if (widget.hasBuilt) {
      null;
    } else {
      String couponCode = generateCouponID(8);
      FirebaseFirestore.instance.collection('coupons').doc(couponCode).set({
        'couponType': "Referral",
        'createdBy': AppControl.loggedInUser,
        'discountPercentage': 50.0,
        'maxRedeemAllowed': 3,
        'redeemed': 0,
        'code': couponCode,
      });
      final DocumentReference reference = FirebaseFirestore.instance
          .collection('userData')
          .doc(AppControl.loggedInUser);
      reference.update({'hasBuilt': true, 'referralCode': couponCode});
    }

    // CODE TO CREDIT REWARD POINTS
    if (discountPercent != 0) {
      if (rewardInfo[0] == 'Referral') {
        final FirebaseFirestore _firestore = FirebaseFirestore.instance;
        FirebaseFirestore.instance
            .collection("userData")
            .doc(rewardInfo[1])
            .get()
            .then((docSnapshot) {
          var data = docSnapshot.data();
          var rewardPoints = data?["rewardPoints"];
          _firestore.collection('userData').doc(rewardInfo[1]).update({
            'rewardPoints': rewardPoints +
                (widget.details[2] -
                    ((widget.details[2] / 100) * discountPercent))
          });
        });
      }
    }
    // CODE TO CREDIT REWARD POINTS
    if (discountPercent != 0) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      FirebaseFirestore.instance
          .collection("coupons")
          .doc(rewardInfo[5])
          .get()
          .then((docSnapshot) {
        var data = docSnapshot.data();
        var redeemed = data?["redeemed"];
        _firestore
            .collection('coupons')
            .doc(rewardInfo[5])
            .update({'redeemed': redeemed + 1});
      });
    }

    // CODE TO DEBIT REWARD POINTS - IF REPOINTS ARE USED FOR PURCHASE
    if (isRewardPurchase) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      FirebaseFirestore.instance
          .collection("userData")
          .doc(AppControl.loggedInUser)
          .get()
          .then((docSnapshot) {
        var data = docSnapshot.data();
        var rewardPoints = data?["rewardPoints"];
        _firestore.collection('userData').doc(AppControl.loggedInUser).update({
          'rewardPoints': rewardPoints -
              (widget.details[2] -
                  ((widget.details[2] / 100) * discountPercent))
        });
      });
    }

    setState(() {
      isSavingToServer = false;
      isPaymentSucessfull = true;
    });
  }
}
