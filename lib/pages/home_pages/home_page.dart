import 'package:bima_gyaan/pages/home_pages/bookSlotSection/book_slot_Screen.dart';
import 'package:bima_gyaan/pages/home_pages/buy_sponsor_section/buy_sponsor_screen.dart';
import 'package:bima_gyaan/pages/home_pages/schedule.dart';
import 'package:bima_gyaan/pages/home_pages/speakers.dart';
import 'package:bima_gyaan/pages/home_pages/sponsors.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'session_speaker_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late var speakersTab;

  bool istap = true;

  // careers@voi11.com
  final List<Map<String, String>> scheduleData = [
    {"time": "08:00 AM To 08:45 AM", "registrationText": "Registration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {
      "time": "09:00 AM To 09:15 AM",
      "registrationText": "Welcome Note By",
      "additionalText": "Ms.Uttara Vaid"
    },
    {
      "time": "09:15 AM To 10:15 AM",
      "registrationText": "1st Session",
      "additionalText": "Dr.Raveendra N / Mr.Suresh B"
    },
    {"time": "10:15 AM To 10:30 AM", "registrationText": "Break"},
    {
      "time": "10:30 AM To 12:15 PM",
      "registrationText": "2nd Session",
      "additionalText": "Ms.Uttara Vaid"
    },
    {
      "time": "12:15 PM To 13:15 PM",
      "registrationText": "3rd Session",
      "additionalText": "Mr.Suresh B"
    },
    {"time": "13:15 PM To 14:15 PM", "registrationText": "Lunch"},
    {
      "time": "14:15 PM To 16:15 PM",
      "registrationText": "4th Session",
      "additionalText": "Ms.Unnati Bajpai"
    },
    {"time": "16:15 PM To 16:30 PM", "registrationText": "Break"},
    {
      "time": "16:30 PM To 17:15 PM",
      "registrationText": "5th Session",
      "additionalText": "Mr.Suresh B"
    },
    {
      "time": "17:15 PM To 17:45 PM",
      "registrationText": "6th Session",
      "additionalText": "Ms.Uttara Vaid"
    },
    {"time": "17:45 PM To 18:15 PM", "registrationText": "Closing"},
  ];

  final List<Map<String, String>> speakersData = [
    {"sessionName": "Session 1", "time": "09:15 AM - 10:15 AM"},
    {"sessionName": "Session Break", "time": "10:15 AM - 10:30 AM"},
    {"sessionName": "Session 2", "time": "10:30 AM - 12:15 PM"},
    {"sessionName": "Session 3", "time": "12:15 PM - 13:15 PM"},
    {"sessionName": "Lunch", "time": "13:15 PM - 14:15 PM"},
    {"sessionName": "Session 4", "time": "14:15 PM - 16:15 PM"},
    {"sessionName": "Break", "time": "16:15 PM - 16:30 PM"},
    {"sessionName": "Session 5", "time": "16:30 PM - 17:15 PM"},
    {"sessionName": "Session 6", "time": "17:15 PM - 17:45 PM"},
    {"sessionName": "Closing", "time": "17:45 PM - 18:15 PM"},
  ];

  final List<String> sponsorsData = [
    "lib/assets/Sponsors1.png",
    "lib/assets/Sponsors2.png",
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    // Tab content
    final scheduleTab = ListView.builder(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.02),
      itemCount: scheduleData.length,
      itemBuilder: (context, index) {
        final item = scheduleData[index];
        return Column(
          children: [
            Schedule(
              time: item["time"]!,
              registrationText: item["registrationText"]!,
              additionalText: item["additionalText"],
            ),
            SizedBox(height: height * 0.025),
          ],
        );
      },
    );

    // Speakers Tab
    if (istap)
      speakersTab = ListView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        itemCount: speakersData.length,
        itemBuilder: (context, index) {
          final item = speakersData[index];
          return InkWell(
            onTap: () {
              istap = false;
              setState(() {
                speakersTab = ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.02),
                  itemCount: sponsorsData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (index == 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    istap = true;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.white,
                                  )),
                              SizedBox(
                                width: width * 0.25,
                              ),
                              Text(
                                "Session 1",
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: width * 0.047,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SessionSpeakerCard(
                          imageUrl: '',
                          name: 'Bessie Cooper',
                          toTime: '9:25 am',
                          fromTime: '9:15 am',
                          address: 'Mitsubishi',
                        )
                      ],
                    );
                  },
                );
              });
            },
            child: Column(
              children: [
                Speakers(
                  sessionName: item["sessionName"]!,
                  time: item["time"]!,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      );

    // Sponsors Tab
    final sponsorsTab = ListView.builder(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.02),
      itemCount: sponsorsData.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Sponsors(
              assetPath: sponsorsData[index],
            ),
            SizedBox(height: 20.h),
          ],
        );
      },
    );

    return ReusableBackGroundScreen(
      tabTitles: const ["Schedule", "Speakers", "Sponsors"],
      tabViews: [scheduleTab, speakersTab, sponsorsTab],
      tbaButtons: [
        CustomButton(
            text: 'Event Registration',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookSlotScreen(),
                  ));
            }),
        CustomButton(
            text: 'Event Registration',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookSlotScreen(),
                  ));
            }),
        CustomButton(
            text: 'Buy sponsorship',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuySponsorScreen(),
                  ));
            }),
      ],
    );
  }

// static final scheduleData = [
//   {"time": "08:00 AM To 08:45 AM", "registrationText": "Registration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
// ];
//
// static final speakersData = [
//   {"sessionName": "Session 1", "time": "09:15 AM - 10:15 AM"},
//   {"sessionName": "Session 2", "time": "10:30 AM - 12:15 PM"},
//   // More speaker items...
// ];
//
// static final sponsorsData = [
//   "lib/assets/Sponsors1.png",
//   "lib/assets/Sponsors2.png",
// ];
}

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//
//
//
//
//
//
//
//
//
//
//     double borderRadius = width*0.1;
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         surfaceTintColor: AppColors.white,
//         title: Image.asset(
//           'lib/assets/BG LOGO3.png',
//
//         ),
//
//         centerTitle: true,
//         leading: IconButton(
//           icon:  Icon(Icons.arrow_back, color: Colors.black,size: width*0.05,),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         automaticallyImplyLeading: false,
//         toolbarHeight: height*0.0875,
//         backgroundColor: AppColors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//
//           SizedBox(height: height*0.0146),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     'Sponsored by',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: width*0.03,
//                       fontWeight: FontWeight.w400,
//                       height: 1.4,
//                     ),
//                   ),
//                   SizedBox(height: height*0.01),
//                   Image.asset(
//                     'lib/assets/Plus Logo.png',
//                     width: width*0.4,
//                     height: height*0.02,
//                   ),
//                 ],
//
//               ),
//               // const Spacer(),
//               SizedBox(width: width*0.05),
//               Column(
//                 children: [
//                   Text(
//                     'Powered by',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: width*0.03,
//                       fontWeight: FontWeight.w400,
//                       height: 1.4,
//                     ),
//                   ),
//                   SizedBox(height: height*0.01),
//                   Image.asset(
//                     'lib/assets/Xsentinel.png',
//                     width: width*0.4,
//                     height: height*0.02,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: height*0.0403),
//           Container(
//             width: width,
//             height: height*0.652,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(borderRadius),
//                 topLeft: Radius.circular(borderRadius),
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(borderRadius),
//                       topLeft: Radius.circular(borderRadius),
//                     ),
//                     child: Image.asset(
//                       'lib/assets/Appoinment BG Image.png',
//                       width: width,
//                        // height: height*0.6395,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   width: width,
//                   // height: height*0.65,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.7),
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30.r),
//                       topLeft: Radius.circular(30.r),
//                     ),
//                   ),
//                 ),
//
//                 Column(
//                   children: [
//                     Padding(
//                       padding:  EdgeInsets.only(top: height*0.025,left: width*0.08,right: width*0.08),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(width * 0.25),
//                           color: AppColors.white,
//                         ),
//                         child: TabBar(
//                           controller: _tabController,
//                           labelStyle: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: width*0.03,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.white),
//                           padding: EdgeInsets.symmetric(vertical: width*0.008,horizontal: width*0.04),
//                           indicatorPadding: EdgeInsets.symmetric(vertical: height*0.01,),
//                           indicatorSize: TabBarIndicatorSize.values.first,
//                           dividerColor: AppColors.white,
//                           labelColor: Colors.white,
//                           unselectedLabelColor: Colors.black,
//                           indicator: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100.r),
//                               gradient:AppColors.getOrangeGradient()
//                           ),
//                           tabs: [
//                             Tab(text: "Schedule"),
//                             Tab(text: "Speakers"),
//                             Tab(text: "Sponsors"),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height*0.54,
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: [
//                           // Schedule Tab
//                           ListView.builder(
//                             padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
//                             itemCount: scheduleData.length,
//                             itemBuilder: (context, index) {
//                               final item = scheduleData[index];
//                               return Column(
//                                 children: [
//                                   Schedule(
//                                     time: item["time"]!,
//                                     registrationText: item["registrationText"]!,
//                                     additionalText: item["additionalText"],
//                                   ),
//                                   SizedBox(height: height*0.025),
//                                 ],
//                               );
//                             },
//                           ),
//
//                           // Speakers Tab
//                           ListView.builder(
//                             padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
//                             itemCount: speakersData.length,
//                             itemBuilder: (context, index) {
//                               final item = speakersData[index];
//                               return Column(
//                                 children: [
//                                   Speakers(
//                                     sessionName: item["sessionName"]!,
//                                     time: item["time"]!,
//                                   ),
//                                   SizedBox(height: 20.h),
//                                 ],
//                               );
//                             },
//                           ),
//
//                           // Sponsors Tab
//                           ListView.builder(
//                             padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
//                             itemCount: sponsorsData.length,
//                             itemBuilder: (context, index) {
//                               return Column(
//                                 children: [
//                                   Sponsors(
//                                     assetPath: sponsorsData[index],
//                                   ),
//                                   SizedBox(height: 20.h),
//                                 ],
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//
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

// Expanded(
//   child: TabBarView(
//     controller: _tabController,
//     children: [
//       ListView(
//
//         padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
//         children: [
//           const Schedule(
//               time: '08:00 AM To 08:45 AM',
//               registrationText: 'Registration'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '08:45 AM To 09:00 AM',
//               registrationText: 'Inauguration'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '09:00 AM To 09:15 AM',
//               registrationText: 'Welcome Note By',
//               additionalText: 'Ms.Uttara Vaid'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '09:15 AM To 10:15 AM ',
//               registrationText: '1st Session',
//               additionalText:
//                   'Dr.Raveendra N / Mr.Suresh B'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '10:15 AM To 10:30 AM',
//               registrationText: 'Break'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '10:30 AM To 12:15 PM',
//               registrationText: '2nd Session',
//               additionalText: 'Ms.Uttara Vaid'),
//           SizedBox(height: 20.h),
//           const Schedule(
//             time: '12:15 PM To 13:15 PM',
//             registrationText: '3rd Session',
//             additionalText: 'Mr.Suresh B',
//           ),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '13:15 PM To 14:15 PM',
//               registrationText: 'Lunch'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '14:15 PM To 16:15 PM',
//               registrationText: '4th Session',
//               additionalText: 'Ms.Unnati Bajpai'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '16:15 PM To 16:30 PM',
//               registrationText: 'Break'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '16:30 PM To 17:15 PM',
//               registrationText: '5th Session',
//               additionalText: 'Mr.Suresh B'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '17:15 PM To 17:45 PM',
//               registrationText: '6th Session',
//               additionalText: 'Ms.Uttara Vaid'),
//           SizedBox(height: 20.h),
//           const Schedule(
//               time: '17:45 PM To 18:15 PM',
//               registrationText: 'Closing'),
//         ],
//       ),
//       ListView(
//         padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
//
//         children: [
//           const Speakers(
//               sessionName: 'Session 1',
//               time: '09:15 AM - 10:15 AM'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Session Break',
//               time: '10:15 AM - 10:30 AM'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Session 2',
//               time: '10:30am-12:15 pm'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Session 3',
//               time: '12:15 PM - 13:15 PM'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Lunch',
//               time: '13:15 PM - 14:15 PM'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Session 4',
//               time: '14:15 PM - 16:15 PM'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Break',
//               time: '16:15 PM - 16:30 PM'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Session 5',
//               time: '16:30 PM - 17:15 PM'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Session 6',
//               time: '17:15 PM - 17:45 PM'),
//           SizedBox(height: 20.h),
//           const Speakers(
//               sessionName: 'Closing',
//               time: '17:45 PM - 18:15 PM'),
//           SizedBox(height: 20.h),
//         ],
//       ),
//       ListView(
//         padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
//
//         children: [
//           const Sponsors(
//               assetPath: 'lib/assets/Sponsors1.png'),
//           SizedBox(height: 20.h),
//           const Sponsors(
//               assetPath: 'lib/assets/Sponsors2.png'),
//         ],
//       ),
//     ],
//   ),
// ),