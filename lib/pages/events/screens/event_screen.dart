import 'package:bima_gyaan/pages/bottom_navigation.dart';
import 'package:bima_gyaan/pages/events/controller/event_controller.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/hotel_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventScreen extends StatelessWidget {
  EventScreen({super.key});

  static const routeName = '/';
  final EventController controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(393, 683), minTextAdapt: true);

    controller.fetchAllEvents();

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          _buildLogo(),
          _buildSponsoredBySection(),
          _buildHotelInfoSection(context),
        ],
      ),
    ));
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 50.w),
            SizedBox(height: 16.h),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => controller.fetchAllEvents(),
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event, color: Colors.grey, size: 50.w),
            SizedBox(height: 16.h),
            Text(
              "No events available.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 50.h),
      child: Image.asset(
        'lib/assets/BG LOGO3.png',
        height: 26.h,
        width: 290.33.w,
      ),
    );
  }

  Widget _buildSponsoredBySection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSponsoredBy(
              'Sponsored by', 'lib/assets/Plus Logo.png', 69.82.w, 16.h),
          SizedBox(width: 50.w),
          _buildSponsoredBy(
              'Powered by', 'lib/assets/Xsentinel.png', 66.w, 23.h),
        ],
      ),
    );
  }

  Widget _buildSponsoredBy(
      String title, String logoPath, double width, double height) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            height: 1.4,
            letterSpacing: 0.001,
          ),
        ),
        SizedBox(height: 10.h),
        Image.asset(
          logoPath,
          width: width,
          height: height,
        ),
      ],
    );
  }

  Widget _buildHotelInfoSection(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        // Show loading spinner
        return SizedBox(
            height: 450.h,
            child: const Center(child: CircularProgressIndicator()));
      } else if (controller.hasError.value) {
        // Show error state with retry button
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 50.w),
              SizedBox(height: 16.h),
              Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () => controller.fetchAllEvents(),
                child: const Text("Retry"),
              ),
            ],
          ),
        );
      } else if (controller.eventsList.isEmpty) {
        // Show empty state
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event, color: Colors.grey, size: 50.w),
              SizedBox(height: 16.h),
              Text(
                "No events available.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      } else {
        // Show events list
        return Container(
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.r),
              topLeft: Radius.circular(30.r),
            ),
          ),
          width: 393.w,
          height: 550.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.eventsList.length,
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
            itemBuilder: (context, index) {
              return _buildHotelInfoCard(
                context,
                'lib/assets/Home Screen1.png',
                controller.eventsList[index].location,
                controller.eventsList[index].name,
                controller.eventsList[index].pickupDate,
                controller.eventsList[index].id,
                controller.eventsList[index].year,

              );
            },
          ),
        );
      }
    });
  }

  // Widget _buildHotelInfoSection(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: AppColors.orange,
  //       borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(30.r),
  //         topLeft: Radius.circular(30.r),
  //       ),
  //     ),
  //     width: 393.w,
  //     height: 550.h,
  //     child: Obx(() => ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: controller.eventsList.length,
  //       padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
  //       itemBuilder: (context, index) {
  //         return _buildHotelInfoCard(
  //           context,
  //           'lib/assets/Home Screen1.png',
  //           controller.eventsList[index].location,
  //           controller.eventsList[index].name,
  //           controller.eventsList[index].pickupDate,
  //           controller.eventsList[index].id,
  //         );
  //       },
  //     )),
  //   );
  // }

  Widget _buildHotelInfoCard(BuildContext context, String backgroundImage,
      String hotelName, String hotelLocation, String dateText, String eventId, String eventYear) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 7.w),
      child: HotelInfoCard(
        backgroundImage: backgroundImage,
        hotelName: hotelName,
        hotelLocation: hotelLocation,
        dateText: dateText,
        buttonText: 'Know More',
        onButtonPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => BottomNavigation(
                      eventId: eventId,
                     eventYear: eventYear,
                    )),
          );
          print('Know more pressed for $hotelName');
        },
      ),
    );
  }
}

// class EventScreen extends StatelessWidget {
//   EventScreen({super.key});
//
//   static const routeName = '/';
//   EventController controller = Get.put(EventController());
//   @override
//   Widget build(BuildContext context) {
//     controller.fetchAllEvents();
//     ScreenUtil.init(context,
//         designSize: const Size(393, 683), minTextAdapt: true);
//     return Scaffold(
//       // appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildLogo(),
//             _buildSponsoredBySection(),
//             _buildHotelInfoSection(context),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildLogo() {
//     return Padding(
//       padding: EdgeInsets.only(top: 50.h),
//       child: Image.asset(
//         'lib/assets/BG LOGO3.png',
//         height: 26.h,
//         width: 290.33.w,
//       ),
//     );
//   }
//   Widget _buildSponsoredBySection() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _buildSponsoredBy(
//               'Sponsored by', 'lib/assets/Plus Logo.png', 69.82.w, 16.h),
//           SizedBox(width: 50.w),
//           _buildSponsoredBy(
//               'Powered by', 'lib/assets/Xsentinel.png', 66.w, 23.h),
//         ],
//       ),
//     );
//   }
//   Widget _buildSponsoredBy(
//       String title, String logoPath, double width, double height) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w400,
//             height: 1.4,
//             letterSpacing: 0.001,
//           ),
//         ),
//         SizedBox(height: 10.h),
//         Image.asset(
//           logoPath,
//           width: width,
//           height: height,
//         ),
//       ],
//     );
//   }
//   Widget _buildHotelInfoSection(BuildContext context) {
//     print("////////////////////////////");
//     print( controller.eventsList[1].id);
//     return Container(
//         decoration: BoxDecoration(
//           color: AppColors.orange,
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(30.r),
//             topLeft: Radius.circular(30.r),
//           ),
//         ),
//         width: 393.w,
//         height: 550.h,
//         child: Obx(() => ListView.builder(
//               shrinkWrap: true,
//               itemCount: controller.eventsList.length,
//               padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
//               itemBuilder: (context, index) {
//                 return _buildHotelInfoCard(
//                     context,
//                     'lib/assets/Home Screen1.png',
//                     controller.eventsList[index].location,
//                     controller.eventsList[index].name,
//                     controller.eventsList[index].pickupDate,
//                     controller.eventsList[index].id);
//               },
//             ))
//
//         );
//   }
//   Widget _buildHotelInfoCard(BuildContext context, String backgroundImage,
//       String hotelName, String hotelLocation, String dateText, String eventId) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 7.w),
//       child: HotelInfoCard(
//         backgroundImage: backgroundImage,
//         hotelName: hotelName,
//         hotelLocation: hotelLocation,
//         dateText: dateText,
//         buttonText: 'Know More',
//         onButtonPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (builder) => BottomNavigation(
//                       eventId: eventId,
//                     )),
//           );
//           print('Know more pressed for $hotelName');
//         },
//       ),
//     );
//   }
// }
// Column(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     _buildHotelInfoCard(context, 'lib/assets/Home Screen1.png',
//         'Hotel Sofitel Mumbai BKC', 'Mumbai', '6 September 2025'),
//     _buildHotelInfoCard(context, 'lib/assets/Home Screen2.png',
//         'Hotel Taj Mahal', 'Mumbai', '6 September 2024'),
//     _buildHotelInfoCard(context, 'lib/assets/Home Screen3.png',
//         'Hotel Sofitel Mumbai BKC', 'Mumbai', '6 September 2023'),
//     _buildHotelInfoCard(context, 'lib/assets/Home Screen4.png',
//         'Hotel Sofitel Mumbai BKC', 'Mumbai', '6 September 2022'),
//   ],
// ),
