import 'dart:convert';

import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionSpeakerCardP extends StatelessWidget {
  final String name;
  final String yourBase64String; // Optional additional text
  final String address; // Optional additional text
  final String imageUrl; // Optional additional text
  final VoidCallback onViewTap;
  final VoidCallback onDownloadTap;

  const SessionSpeakerCardP({
    super.key,
    required this.name,
    required this.yourBase64String,
    required this.address,
    required this.imageUrl,
    required this.onViewTap,
    required this.onDownloadTap,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.2,
            height: height * 0.1,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.05)),
            child: imageUrl.isNotEmpty
                ? Image.memory(
                    base64Decode(imageUrl),
                    fit: BoxFit.contain,
              width: width*0.05,
              height: width*0.05,
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: Image.asset(
                      "lib/assets/user.png",
                    ),
                  ),
          ),
          SizedBox(
            width: width * 0.035,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.43,
                child: Text(
                  name,
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: width * 0.04,
                      color: AppColors.dark,
                      fontWeight: FontWeight.w900,
                      height: height * 0.0012),
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                width: width * 0.43,
                child: Text(
                  address,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  CustomeButton(
                    text: 'View PPT',
                    onPressed: onViewTap,
                    // Use the passed function
                    horizontalPadding: width * 0.04,
                    verticalPadding: height * 0.012,
                    transparent: true,
                    textSize: width * 0.025,
                  ),
                  SizedBox(width: width * 0.025),
                  CustomeButton(
                    text: 'Download PPT',
                    onPressed: onDownloadTap,
                    // Use the passed function
                    horizontalPadding: width * 0.04,
                    verticalPadding: height * 0.012,
                    textSize: width * 0.025,
                  ),
                ],
              ),
              // SizedBox(height: height * 0.003),

              // Row(
              //   children: [
              //     Text(
              //       post,
              //       style: TextStyle(
              //         fontFamily: 'poppins',
              //         fontSize: width * 0.025,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     SizedBox(
              //       width: width * 0.015,
              //     ),
              //     Container(
              //       height: height * 0.02,
              //       width: 1,
              //       color: Colors.black,
              //     ),
              //     SizedBox(
              //       width: width * 0.015,
              //     ),
              //     Text(
              //       webAddress,
              //       style: TextStyle(
              //         fontFamily: 'poppins',
              //         fontSize: width * 0.025,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: height*0.015,),
              // Row(
              //   children: [
              //     CustomeButton(
              //       text: 'Schedule',
              //       onPressed: () {},
              //       horizontalPadding: width * 0.04,
              //       verticalPadding: height * 0.012,
              //
              //     ),
              //     SizedBox(width: width*0.025,),
              //     CustomeButton(
              //       text: 'Chat',
              //       onPressed: () {},
              //       horizontalPadding: width * 0.04,
              //       verticalPadding: height * 0.012,
              //       transparent: true,
              //     ),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session2.dart';
// import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Widgets/common_container.dart';
// import 'package:bima_gyaan/pages/more_pages/Presentations/presentations_screen.dart';
// import 'package:bima_gyaan/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class Session1 extends StatelessWidget {
//   const Session1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 15.h,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.white,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: AppColors.blueGradient,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 25.h,
//             left: 20.w,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                          PresentationsScreen(year: '2024'),
//                   ),
//                 );
//               },
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.arrow_back,
//                     size: 24,
//                     color: AppColors.white,
//                   ),
//                   SizedBox(width: 36.w),
//                   Text(
//                     'Presentations',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 100.h,
//             child: Container(
//               constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height * 1),
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 249, 247, 247),
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(30),
//                     topLeft: Radius.circular(30)),
//               ),
//               width: 393.w,
//               height: 761.h,
//               child: Padding(
//                 padding: EdgeInsets.all(20.r),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Opacity(
//                           opacity: 0.2,
//                           child: IconButton(
//                             icon:
//                                 const Icon(Icons.keyboard_arrow_left, size: 24),
//                             onPressed: () {},
//                           ),
//                         ),
//                         Text(
//                           'Session 1',
//                           style: TextStyle(
//                             fontFamily: 'Poppins',
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                         IconButton(
//                           icon:
//                               const Icon(Icons.keyboard_arrow_right, size: 24),
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const Session2()),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     const CommonContainer(
//                       SpeakersName: 'Jenny Wilson',
//                       CompanyName: 'Louis Vuitton',
//                       imageUrl: 'lib/assets/speaker1.png',
//                     ),
//                     SizedBox(height: 20.h),
//                     const CommonContainer(
//                       SpeakersName: 'Ronald Richards',
//                       CompanyName: 'MasterCard',
//                       imageUrl: 'lib/assets/speaker2.png',
//                     ),
//                     SizedBox(height: 20.h),
//                     const CommonContainer(
//                       SpeakersName: 'Ronald Richards',
//                       CompanyName: 'Facebook',
//                       imageUrl: 'lib/assets/speaker3.png',
//                     ),
//                     SizedBox(height: 20.h),
//                     const CommonContainer(
//                       SpeakersName: 'Ronald Richards',
//                       CompanyName: 'Starbucks',
//                       imageUrl: 'lib/assets/speaker4.png',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
