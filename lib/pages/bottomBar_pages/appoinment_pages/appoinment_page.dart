import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/participants_widget.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    final scheduleTab = ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.03),
            child: ParticipantsWidget(
              email: 'dolores.chambers@example.com',
              imageUrl: '',
              name: 'Ralph Edwards',
              post: 'Dog Trainer',
              webAddress: 'Biffco Enterprises Ltd.',
              onPressedChat: () {},
              onPressedSchedule: () {},
            ));
      },
    );
    final speakersTab = ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.03),
            child: ParticipantsWidget(
              email: 'dolores.chambers@example.com',
              imageUrl: '',
              name: 'Ralph Edwards',
              post: 'Dog Trainer',
              webAddress: 'Biffco Enterprises Ltd.',
              onPressedChat: () {},
              onPressedSchedule: () {},
            ));
      },
    );
    final sponsorsTab = ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.03),
            child: ParticipantsWidget(
              email: 'dolores.chambers@example.com',
              imageUrl: '',
              name: 'Ralph Edwards',
              post: 'Dog Trainer',
              webAddress: 'Biffco Enterprises Ltd.',
              onPressedChat: () {},
              onPressedSchedule: () {},
            ));
      },
    );
    // final scheduleTab = ListView.builder(
    //   itemCount: scheduleData.length,
    //   itemBuilder: (context, index) {
    //     final item = scheduleData[index];
    //     return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Container(
    //         height: 20,
    //         color: Colors.red,
    //       ),
    //     );
    //   },
    // );

    // final speakersTab = ListView.builder(
    //   itemCount: speakersData.length,
    //   itemBuilder: (context, index) {
    //     final item = speakersData[index];
    //     return ListTile(
    //       title: Text(item["sessionName"]!),
    //       trailing: Text(item["time"]!),
    //     );
    //   },
    // );

    // final sponsorsTab = ListView.builder(
    //   itemCount: sponsorsData.length,
    //   itemBuilder: (context, index) {
    //     return Image.asset(sponsorsData[index]);
    //   },
    // );

    // Pass tab data
    return ReusableBackGroundScreen(
      tabTitles: ["Pending", "Accepted", "Rejected"],
      tabViews: [scheduleTab, speakersTab, sponsorsTab],
    );
  }

  static final scheduleData = [
    {"time": "08:00 AM To 08:45 AM", "registrationText": "Registration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
  ];

  static final speakersData = [
    {"sessionName": "Session 1", "time": "09:15 AM - 10:15 AM"},
    {"sessionName": "Session 2", "time": "10:30 AM - 12:15 PM"},
    // More speaker items...
  ];

  static final sponsorsData = [
    "lib/assets/Sponsors1.png",
    "lib/assets/Sponsors2.png",
  ];
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
