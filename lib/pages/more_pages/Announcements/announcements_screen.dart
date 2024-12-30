import 'package:bima_gyaan/pages/more_pages/Announcements/accouncements_container.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementsScreen extends StatelessWidget {
  final List<Announcement> _announcements = [
    Announcement(
      title: 'Registration',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      date: '23 Oct, 2024',
      time: '2:30 pm',
    ),
    Announcement(
      title: 'Registration',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      date: '23 Oct, 2024',
      time: '2:30 pm',
    ),
    Announcement(
      title: 'Registration',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      date: '23 Oct, 2024',
      time: '2:30 pm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Announcements',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: screenWidth * 0.07,
          ),
        ),
        toolbarHeight: screenHeight * 0.1,
      ),
      body: Container(
        height: screenHeight,
        padding: EdgeInsets.only(top: screenHeight * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.1),
            topRight: Radius.circular(screenWidth * 0.1),
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: 16,
          ),
          itemCount: _announcements.length,
          itemBuilder: (context, index) {
            return AnnouncementCard(
              announcement: _announcements[index],
            );
          },
        ),
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: AppColors.lightPeach,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Icon(
                Icons.campaign,
                color: Colors.white,
                size: screenWidth * 0.07,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    announcement.description,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date: ${announcement.date}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Time: ${announcement.time}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Announcement {
  final String title;
  final String description;
  final String date;
  final String time;

  Announcement({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });
}

// class AnnouncementsScreen extends StatelessWidget {
//   const AnnouncementsScreen({super.key});
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
//                 Get.back();
//
//                 // Navigator.pushReplacement(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => const MorePage()),
//                 // );
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
//                     'Announcements',
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
//                   color: Color.fromARGB(255, 249, 247, 247),
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30),
//                       topLeft: Radius.circular(30))),
//               width: 393.w,
//               height: 761.h,
//               child: Padding(
//                 padding: EdgeInsets.all(25.r),
//                 child: const Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     AccouncementsContainer(
//                       headingText: 'Registration',
//                       contentText: 'Lorem ipsum dolor sit amet.',
//                     ),
//                     // You can add more AnnouncementsContainer instances here if needed
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
