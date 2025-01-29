// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   static const routeName = '/';
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
// WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//   if (LocalStorage.instance.isUserLoggedIn()) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (BuildContext context) => const Bottom()));
//   } else {
//     Navigator.push(context,
//         MaterialPageRoute(builder: (context) => const LoginPage()));
//   }
// });
// super.initState();
//}

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:bima_gyaan/pages/events/screens/event_screen.dart';
import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // If using Firebase for authentication

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Check user authentication state
    Future.delayed(const Duration(seconds: 2), () {
      final user =
          FirebaseAuth.instance.currentUser; // Check Firebase authentication

      if (user != null) {
        Get.off(() => EventScreen());
      } else {
        // If the user is not logged in, navigate to the LoginScreen
        Get.off(() => const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.blueGradient,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          // Center Image
          Image.asset(
            'lib/assets/BG LOGO1.png',
            width: 269,
            height: 115,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/splashpeople.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
          const Divider(
            thickness: 3,
            height: 0,
            color: AppColors.dark,
          ),
          const SizedBox(height: 70),
          // Bottom Section
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Sponsored by',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        letterSpacing: 0.001,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      'lib/assets/Plus Logo.png',
                      width: 98.77,
                      height: 22.63,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Powered by',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        letterSpacing: 0.001,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    Image.asset(
                      'lib/assets/logo_bigGyan.png',
                      width: 70.w,
                      height: 50.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:bima_gyaan/pages/home_screen.dart';
// import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
// import 'package:bima_gyaan/utils/colors.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   Future<void> _navigateBasedOnAuthStatus(BuildContext context) async {

//     await Future.delayed(const Duration(seconds: 2));

//     final bool isLoggedIn = await _checkUserLoginStatus();

//     if (isLoggedIn) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } else {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     }
//   }

//   Future<bool> _checkUserLoginStatus() async {

//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {

//     _navigateBasedOnAuthStatus(context);

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 15,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: AppColors.blueGradient,
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           const Spacer(),
//           Image.asset(
//             'lib/assets/BG LOGO1.png',
//             width: 269,
//             height: 115,
//           ),
//           const Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'lib/assets/splashpeople.png',
//                 fit: BoxFit.cover,
//               ),
//             ],
//           ),
//           const Divider(
//             thickness: 3,
//             height: 0,
//             color: AppColors.dark,
//           ),
//           const SizedBox(height: 70),
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     const Text(
//                       'Sponsored by',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         height: 1.4,
//                         letterSpacing: 0.001,
//                         textBaseline: TextBaseline.alphabetic,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Image.asset(
//                       'lib/assets/Plus Logo.png',
//                       width: 98.77,
//                       height: 22.63,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     const Text(
//                       'Powered by',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         height: 1.4,
//                         letterSpacing: 0.001,
//                         textBaseline: TextBaseline.alphabetic,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Image.asset(
//                       'lib/assets/logo_bigGyan.png',
//                       width: 93.37,
//                       height: 32.54,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
