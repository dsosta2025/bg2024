import 'package:bima_gyaan/pages/bottomBar_pages/appoinment_pages/appoinment_card_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/appoinment_pages/reschedule_appoitment.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/participants_widget.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';

class AppoinmentPage extends StatefulWidget {
  const AppoinmentPage({super.key});

  @override
  State<AppoinmentPage> createState() => _HomePageState();
}

class _HomePageState extends State<AppoinmentPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Tab content
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final pending = ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.03),
            child: AppoinmentCardWidget(
              name: "John Doe",
              subject: "Follow-up Meeting",
              description: "Discuss progress and next steps for the project.",
              dateOrTime: "2024-12-10 10:00 AM",
              rightSideWidget: Icon(Icons.calendar_today),
              // Just an example widget
              imageUrl: "https://example.com/profile.jpg",
              // Image URL (if needed)
              button1Text: "Accept",
              button2Text: "Reject",
              button1onPressed: () {
                // Handle Schedule button press
                print("Schedule button pressed");
              },
              button2onPressed: () {
                // Handle Chat button press
                print("Chat button pressed");
              },
              meetingLinkOrLocation:
                  "Meeting Room 3 / Zoom Link", // Example link or location
            ));
      },
    );
    final accepted = ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.03),
            child: AppoinmentCardWidget(
              name: "John Doe",
              subject: "Follow-up Meeting",
              description: "Discuss progress and next steps for the project.",
              dateOrTime: "2024-12-10 10:00 AM",
              rightSideWidget: Icon(Icons.calendar_today),
              // Just an example widget
              imageUrl: "https://example.com/profile.jpg",
              // Image URL (if needed)
              button1Text: "Reschedule",
              button2Text: "Cancel",
              button1onPressed: () {
                // Handle Schedule button press
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RescheduleAppoitment(),
                    ));
              },
              button2onPressed: () {
                // Handle Chat button press
                print("Chat button pressed");
              },
              meetingLinkOrLocation:
                  "Meeting Room 3 / Zoom Link", // Example link or location
            ));
      },
    );
    final rejected = ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.03),
            child: AppoinmentCardWidget(
              name: "John Doe",
              subject: "Follow-up Meeting",
              description: "Discuss progress and next steps for the project.",
              dateOrTime: "2024-12-10 10:00 AM",
              rightSideWidget: Icon(Icons.calendar_today),
              // Just an example widget
              imageUrl: "https://example.com/profile.jpg",
              // Image URL (if needed)
              button1Text: "Reschedule",
              button1onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RescheduleAppoitment(),
                    ));
                // Handle Schedule button press
                print("Schedule button pressed");
              },

              meetingLinkOrLocation:
                  "Meeting Room 3 / Zoom Link", // Example link or location
            ));
      },
    );

    return ReusableBackGroundScreen(
      tabTitles: ["Pending", "Accepted", "Rejected"],
      tabViews: [pending, accepted, rejected],
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       // leading: IconButton(
//       //   icon: const Icon(Icons.arrow_back, color: Colors.black),
//       //   onPressed: () {
//       //     Navigator.pop(context);
//       //   },
//       // ),
//       automaticallyImplyLeading: false,
//       toolbarHeight: 60.h,
//       backgroundColor: AppColors.white,
//       elevation: 0,
//     ),
//     body: SingleChildScrollView(
//       child: Column(
//         children: [
//           Image.asset(
//             'lib/assets/BG LOGO3.png',
//             height: 26.h,
//             width: 290.33.w,
//           ),
//           SizedBox(height: 10.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       'Sponsored by',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w400,
//                         height: 1.4,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     Image.asset(
//                       'lib/assets/Plus Logo.png',
//                       width: 69.82.w,
//                       height: 16.h,
//                     ),
//                   ],
//                 ),
//                 // const Spacer(),
//                 SizedBox(width: 40.w),
//                 Column(
//                   children: [
//                     Text(
//                       'Powered by',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w400,
//                         height: 1.4,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     Image.asset(
//                       'lib/assets/Xsentinel.png',
//                       width: 66.w,
//                       height: 23.h,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20.h),
//           Container(
//             width: 393.w,
//             height: 570.h,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30.r),
//                 topLeft: Radius.circular(30.r),
//               ),
//             ),
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(30.r),
//                     topLeft: Radius.circular(30.r),
//                   ),
//                   child: Image.asset(
//                     'lib/assets/Appoinment BG Image.png',
//                     width: 393.w,
//                     height: 918.h,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 Container(
//                   width: 393.w,
//                   height: 683.h,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.7),
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30.r),
//                       topLeft: Radius.circular(30.r),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(30.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: AppColors.white,
//                         ),
//                         child: TabBar(
//                           controller: _tabController,
//                           labelStyle: const TextStyle(
//                             fontFamily: 'Poppins',
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           labelColor: Colors.black,
//                           unselectedLabelColor: Colors.grey,
//                           indicator: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100.r),
//                             color: AppColors.orange,
//                           ),
//                           tabs: const [
//                             Tab(text: "Pending"),
//                             Tab(text: "Accepted"),
//                             Tab(text: "Rejected"),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: TabBarView(
//                           controller: _tabController,
//                           children: const [],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
