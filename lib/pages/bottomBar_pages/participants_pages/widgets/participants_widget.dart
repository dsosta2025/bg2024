import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';

class ParticipantsWidget extends StatelessWidget {
  final String name;
  final String email;
  final String post; // Optional additional text
  final String webAddress; // Optional additional text
  final String imageUrl; // Optional additional text
  final VoidCallback onPressedSchedule; // Function for 'Schedule' button press
  final VoidCallback onPressedChat; // Function for 'Chat' button press

  const ParticipantsWidget({
    super.key,
    required this.name,
    required this.email,
    required this.post,
    required this.webAddress,
    required this.imageUrl,
    required this.onPressedSchedule, // Required parameter for the 'Schedule' button press
    required this.onPressedChat, // Required parameter for the 'Chat' button press
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: height * 0.01),
              Text(
                email,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: width * 0.025,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: height * 0.003),
              Row(
                children: [
                  Text(
                    post,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: width * 0.025,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.015,
                  ),
                  Container(
                    height: height * 0.02,
                    width: 1,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: width * 0.015,
                  ),
                  Text(
                    webAddress,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: width * 0.025,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.015),
              Row(
                children: [
                  CustomeButton(
                    text: 'Schedule',
                    onPressed: onPressedSchedule, // Use the passed function
                    horizontalPadding: width * 0.04,
                    verticalPadding: height * 0.012,
                  ),
                  SizedBox(width: width * 0.025),
                  CustomeButton(
                    text: 'Chat',
                    onPressed: onPressedChat,
                    // Use the passed function
                    horizontalPadding: width * 0.04,
                    verticalPadding: height * 0.012,
                    transparent: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ParticipantsWidget extends StatelessWidget {
//   final String name;
//   final String email;
//   final String post; // Optional additional text
//   final String webAddress; // Optional additional text
//   final String imageUrl; // Optional additional text
//
//
//   const ParticipantsWidget({
//     super.key,
//     required this.name,
//     required this.email,
//     required this.post,
//     required this.webAddress,
//     required this.imageUrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     return Container(
//
//       padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.05),
//       decoration: BoxDecoration(
//         color: AppColors.lightPeach,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//
//
//
//
//
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
//               Text(
//                 name,
//                 style: TextStyle(
//                   fontFamily: 'poppins',
//                   fontSize: width * 0.047,
//                   color: AppColors.dark,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               SizedBox(height: height * 0.01),
//               Text(
//                 email,
//                 style: TextStyle(
//                   fontFamily: 'poppins',
//                   fontSize: width * 0.025,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: height * 0.003),
//
//               Row(
//                 children: [
//                   Text(
//                     post,
//                     style: TextStyle(
//                       fontFamily: 'poppins',
//                       fontSize: width * 0.025,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width * 0.015,
//                   ),
//                   Container(
//                     height: height * 0.02,
//                     width: 1,
//                     color: Colors.black,
//                   ),
//                   SizedBox(
//                     width: width * 0.015,
//                   ),
//                   Text(
//                     webAddress,
//                     style: TextStyle(
//                       fontFamily: 'poppins',
//                       fontSize: width * 0.025,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: height*0.015,),
//               Row(
//                 children: [
//                   CustomeButton(
//                     text: 'Schedule',
//                     onPressed: () {},
//                     horizontalPadding: width * 0.04,
//                     verticalPadding: height * 0.012,
//
//                   ),
//                   SizedBox(width: width*0.025,),
//                   CustomeButton(
//                     text: 'Chat',
//                     onPressed: () {},
//                     horizontalPadding: width * 0.04,
//                     verticalPadding: height * 0.012,
//                     transparent: true,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
