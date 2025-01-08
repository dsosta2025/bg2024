import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppoinmentCardWidget extends StatelessWidget {
  final String name;
  final String subject;
  final String description; // Optional additional text
  final String dateOrTime; // Optional additional text
  final String imageUrl; // Optional additional text
  final String meetingLinkOrLocation; // Optional additional text
  final Widget rightSideWidget;
  final String? button1Text;
  final String? button2Text; // Optional additional text
  final VoidCallback? button1onPressed; // Function for 'Schedule' button press
  final VoidCallback? button2onPressed; // Function for 'Chat' button press

  const AppoinmentCardWidget({
    super.key,
    required this.name,
    required this.subject,
    required this.description,
    required this.dateOrTime,
    required this.rightSideWidget,
    required this.imageUrl,
     this.button1Text,
     this.button2Text,
    this.button1onPressed, // Optional for 'Schedule' button press
    this.button2onPressed, // Optional for 'Chat' button press
    required this.meetingLinkOrLocation,
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
        children: [
          // Container(
          //   width: width * 0.25,
          //   height: height * 0.16,
          //   decoration: BoxDecoration(
          //       color: Colors.red,
          //       borderRadius: BorderRadius.circular(width * 0.05)),
          // ),
          // SizedBox(width: width * 0.035),
          Container(
            width: width * 0.25,
            height: height * 0.16,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.05)),
            child: imageUrl.isNotEmpty
                ? Image.network(imageUrl)
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
          SizedBox(
            width: width * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: width * 0.047,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    rightSideWidget,
                  ],
                ),
                SizedBox(height: height * 0.01),
                Text(
                  "Subject - $subject",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  "Description - $description",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  dateOrTime,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  meetingLinkOrLocation,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height * 0.015),
                Row(
                  children: [
                    // Show button 1 only if button1onPressed is not null
                    if (button1onPressed != null) ...[
                      CustomeButton(
                        text: button1Text??'',
                        onPressed: button1onPressed!,
                        horizontalPadding: width * 0.04,
                        verticalPadding: height * 0.012,
                      ),
                    ],
                    SizedBox(width: width * 0.025),

                    // Show button 2 only if button2onPressed is not null
                    if (button2onPressed != null) ...[
                      CustomeButton(
                        text: button2Text??'',
                        onPressed: button2onPressed!,
                        horizontalPadding: width * 0.04,
                        verticalPadding: height * 0.012,
                        transparent: true,
                      ),
                    ],
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

// class AppoinmentCardWidget extends StatelessWidget {
//   final String name;
//   final String subject;
//   final String description; // Optional additional text
//   final String dateOrTime; // Optional additional text
//   final String imageUrl; // Optional additional text
//   final String meetingLinkOrLocation; // Optional additional text
//   final Widget rightSideWidget;
//   final String button1Text;
//   final String button2Text; // Optional additional text
//   final VoidCallback? button1onPressed; // Function for 'Schedule' button press
//   final VoidCallback? button2onPressed; // Function for 'Chat' button press
//
//   const AppoinmentCardWidget({
//     super.key,
//     required this.name,
//     required this.subject,
//     required this.description,
//     required this.dateOrTime,
//     required this.rightSideWidget,
//     required this.imageUrl,
//     required this.button1Text,
//     required this.button2Text,
//     this.button1onPressed, // Required parameter for the 'Schedule' button press
//     this.button2onPressed,
//     required this.meetingLinkOrLocation,
//     // Required parameter for the 'Chat' button press
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     return Container(
//       padding: EdgeInsets.symmetric(
//           vertical: height * 0.02, horizontal: width * 0.05),
//       decoration: BoxDecoration(
//         color: AppColors.lightPeach,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: width * 0.25,
//             height: height * 0.16,
//             decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(width * 0.05)),
//           ),
//           SizedBox(
//             width: width * 0.035,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     name,
//                     style: TextStyle(
//                       fontFamily: 'poppins',
//                       fontSize: width * 0.047,
//                       color: AppColors.dark,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   rightSideWidget,
//                 ],
//               ),
//               SizedBox(height: height * 0.01),
//               Text(
//                 "Subject - $subject",
//                 style: TextStyle(
//                   fontFamily: 'poppins',
//                   fontSize: width * 0.025,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: height * 0.003),
//               Text(
//                 "Description - $description",
//                 style: TextStyle(
//                   fontFamily: 'poppins',
//                   fontSize: width * 0.025,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Text(
//                 dateOrTime,
//                 style: TextStyle(
//                   fontFamily: 'poppins',
//                   fontSize: width * 0.025,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Text(
//                 meetingLinkOrLocation,
//                 style: TextStyle(
//                   fontFamily: 'poppins',
//                   fontSize: width * 0.025,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: height * 0.015),
//               Row(
//                 children: [
//                   CustomeButton(
//                     text: button1Text,
//                     onPressed: button1onPressed!, // Use the passed function
//                     horizontalPadding: width * 0.04,
//                     verticalPadding: height * 0.012,
//                   ),
//                   SizedBox(width: width * 0.025),
//                   CustomeButton(
//                     text: button2Text,
//                     onPressed: button2onPressed!,
//                     // Use the passed function
//                     horizontalPadding: width * 0.04,
//                     verticalPadding: height * 0.012,
//                     transparent: true,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
