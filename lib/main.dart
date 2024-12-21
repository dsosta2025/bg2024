import 'package:bima_gyaan/firebase_options.dart';
import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
import 'package:bima_gyaan/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));

    // return ScreenUtilInit(
    //   designSize: const Size(393, 852),
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     // Main Color
    //
    //     routes: {
    //       // SplashScreen.routeName: (context) => const SplashScreen(),
    //       LoginScreen.routeName: (context) => const LoginScreen(),
    //       //CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
    //       //SignUpPage.routeName: (context) => const SignUpPage(),
    //       //ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
    //       //HomeScreen.routeName: (context) => const HomeScreen(),
    //     },
    //   ),
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // Main Color

      routes: {
        // SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => SplashScreen(),
        //CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
        //SignUpPage.routeName: (context) => const SignUpPage(),
        //ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
        //HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}

// import 'package:bima_gyaan/pages/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// Future<void> main() async {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const ScreenUtilInit(
//       designSize: Size(393, 852),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: SplashScreen(),
//       ),
//     );
//   }
// }
