import 'package:aspire/Utils/appControl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final Connectivity _connectivity = Connectivity();

  TextEditingController feedcontroller = TextEditingController();
  bool isNotEmpty = false;
  bool isUploading = false;

  @override
  void dispose() {
    feedcontroller.dispose();
    super.dispose();
  }

  Future<void> sendMail(String url) async {
    final Uri linkedinUri = Uri.parse(url);
    if (!await launchUrl(linkedinUri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch URL";
    }
  }

  final gmail = "nxtinteractiveprojects@gmail.com";

  void send() async {
    setState(() {
      isUploading = true;
    });
    await addFeedback(
        feedback: feedcontroller.text.trim(),
        senderUserName: AppControl.loggedInUser);
    // Show a confirmation message or dialog here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Feedback sent!', style: TextStyle(fontSize: 14.sp)),
      ),
    );
    setState(() {
      isUploading = false;
    });
    feedcontroller.clear();
    Navigator.pop(context);
  }

  void lookUp(val) {
    if (val == "") {
      setState(() {
        isNotEmpty = false;
      });
    } else {
      setState(() {
        isNotEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final gmailUrl =
        "mailto:$gmail?subject=${Uri.encodeComponent("My feedback.")}&body=${Uri.encodeComponent("Write your message here.")}";
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // Set the color here
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
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
          "Feedback",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Send us your feedbacks and complaints to us. Our team will work on it and make your experience even better.",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 12.h,
              ),
              TextField(
                onChanged: (value) {
                  lookUp(value);
                },
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
                keyboardType: TextInputType.multiline,
                controller: feedcontroller,
                maxLines: 8,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Write your feedback here...",
                  hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black38),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black38, width: 1.4.w),
                      borderRadius: BorderRadius.circular(12.r)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black38, width: 1.4.w),
                      borderRadius: BorderRadius.circular(12.r)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.4.w),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              GestureDetector(
                onTap: () async {
                  if (feedcontroller.text.trim().isNotEmpty) {
                    final result = await _connectivity.checkConnectivity();
                    result.toString() == "ConnectivityResult.none"
                        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            elevation: 0,
                            content: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.black,
                                  size: ScreenUtil().setSp(20),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  "No internet connection !",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )))
                        : send();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        'Write Something!',
                        style: TextStyle(fontSize: 14.sp),
                      )),
                    );
                  }
                },
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF899CB4).withOpacity(0.1),
                          width: 1.2.w),
                      color: isNotEmpty
                          ? const Color(0xFF5cc43b)
                          : const Color(0xFFF4F8FB),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: isUploading
                      ? Center(
                          child: SizedBox(
                            height: 28.sp,
                            width: 28.sp,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.r,
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                          "Send",
                          style: TextStyle(
                              color: isNotEmpty
                                  ? Colors.white
                                  : const Color(0xFF899CB4),
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp),
                        )),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              RichText(
                text: TextSpan(
                    text:
                        "Or you can share your experience and your feedback via ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: "email.",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 17.sp),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              sendMail(gmailUrl);
                            })
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addFeedback({
    required String feedback,
    required String senderUserName,
  }) async {
    final docUser = FirebaseFirestore.instance.collection("feedback").doc();
    final json = {
      "feedback": feedback,
      "senderUserName": senderUserName,
      "reportDate": DateTime.now(),
      "solved": false,
    };
    try {
      await docUser.set(json, SetOptions(merge: true));
    } catch (e) {
      // print("Error adding feedback: $e");
    }
  }
}
