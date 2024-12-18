import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQS extends StatefulWidget {
  const FAQS({super.key});

  @override
  State<FAQS> createState() => _FAQSState();
}

class _FAQSState extends State<FAQS> {
  @override
  Widget build(BuildContext context) {
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
          "FAQ's",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Frequently asked\nQuestions",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 32.sp),
              ),
              SizedBox(
                height: 12.h,
              ),
              ExpansionTile(
                tilePadding:
                    EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text(
                  "What is Aspire?",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
