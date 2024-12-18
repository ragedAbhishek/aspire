import 'package:aspire/HomePage.dart';
import 'package:aspire/Onboarding/LoginPage.dart';
import 'package:aspire/Onboarding/SplashScreen.dart';
import 'package:aspire/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.sofiaSans.toString(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/SplashScreen",
        routes: {
          // ***************** D O N ' T   R E M O V E   T H E S E  *******************
          "/SplashScreen": (context) => SplashScreen(),

          // ***************** R E M O V E   T H E S E  *******************
          "/LoginPage": (context) => const LoginPage(),
          "/HomePage": (context) => const HomePage(),
        },
      ),
      designSize: Size(392.72727272727275, 825.4545454545455),
    );
  }
}
