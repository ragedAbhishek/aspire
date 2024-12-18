import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermOfService extends StatefulWidget {
  const TermOfService({super.key});

  @override
  State<TermOfService> createState() => _TermOfServiceState();
}

class _TermOfServiceState extends State<TermOfService> {
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
            "Terms of Service",
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.sp,
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
                Image.asset(
                  "assets/logos/LOGOFullPNG.png",
                  fit: BoxFit.cover,
                  height: 56.h,
                  width: 128.w,
                  color: Colors.black,
                ),
                Text(
                  "June 16, 2024",
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  "Data Privacy",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "At Aspire, we hold your data privacy as our top priority. We are committed to ensuring that all your personal information remains secure and confidential. As part of our strict data protection policy, we explicitly guarantee that we do not share any of your data with third parties. Your trust is invaluable to us, and we will never compromise on safeguarding your sensitive information. Whether it's personal details, usage patterns, or any other data collected through the app, rest assured that it will solely be used to enhance your app experience and provide you with personalized services. We continuously employ state-of-the-art encryption and security measures to maintain the utmost privacy of your data. ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Reward Policy",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "You can earn reward points by referring your friends to the app. When your friends sign up using your unique referral link, you will earn reward points credited to your account. These reward points can be redeemed for various rewards and benefits available within the app.It's important to note that while you can accumulate and use reward points for many transactions, they cannot be applied when using referral coupons or other promotional offers. If you apply a referral coupon during a transaction, you will not be able to use your accumulated reward points for that particular transaction.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Refund Policy",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "At Aspire, we are committed to providing high-quality service and an exceptional user experience. However, please note that all purchases and subscriptions made through the Aspire app are final and non-refundable. Once a transaction is completed, we are unable to offer refunds, exchanges, or credits for any reason. We encourage users to thoroughly review their purchases and utilize any available trial periods to ensure the product meets their expectations before finalizing their transaction. If you encounter any issues with our services, our customer support team is available to assist and address any concerns you may have.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                )
              ],
            ),
          ),
        ));
  }
}
