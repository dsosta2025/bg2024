import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
import 'package:bima_gyaan/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Main Color

      routes: {
        // SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) =>  LoginScreen(),
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
