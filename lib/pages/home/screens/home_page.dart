import 'package:bima_gyaan/pages/home/controller/homeController.dart';
import 'package:bima_gyaan/pages/home_pages/bookSlotSection/screen/book_slot_Screen.dart';
import 'package:bima_gyaan/pages/home_pages/buy_sponsor_section/buy_sponsor_screen.dart';
import 'package:bima_gyaan/pages/home_pages/schedule.dart';
import 'package:bima_gyaan/pages/home_pages/speakers.dart';
import 'package:bima_gyaan/pages/home_pages/sponsors.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../home_pages/session_speaker_card.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.eventId, required this.eventYear});

  String eventId;
  String eventYear;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    print(widget.eventId);
    controller.fetchSchedules(widget.eventId);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool containsBreak(String input) {
    return input.toLowerCase().contains('break');
  }

  late var speakersTab;
  bool istap = true;
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
    controller.fetchSchedules(widget.eventId);
    controller.fetchSpeakers(widget.eventId);
    controller.fetchSponsors(widget.eventId);
    // controller.fetchSessions("documentId");
    final scheduleTab = Obx(() {
      if (controller.isLoading.value) {
        // Loading state
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      } else if (controller.hasError.value) {
        // Error state
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.redAccent, size: 40.w),
              SizedBox(height: 10.h),
              Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () => controller.fetchSchedules(widget.eventId),
                child: const Text("Retry"),
              ),
            ],
          ),
        );
      } else if (controller.schedules.isEmpty) {
        // Empty state
        return Center(
          child: Text(
            'No schedules available.',
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        );
      } else {
        // Success state (show schedule list)
        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.04,
            vertical: MediaQuery.sizeOf(context).height * 0.02,
          ),
          itemCount: controller.schedules.length,
          itemBuilder: (context, index) {
            final item = controller.schedules.value[index];
            return Column(
              children: [
                Schedule(
                  time: item.scheduleTime!,
                  registrationText: item.scheduleTitle,
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
              ],
            );
          },
        );
      }
    });

    if (istap) {
      speakersTab = Obx(() {
        if (controller.isLoadingSpeakers.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else if (controller.hasErrorSpeakers.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.redAccent, size: 40.w),
                SizedBox(height: 10.h),
                Text(
                  controller.errorMessageSpeakers.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () => controller.fetchSpeakers(widget.eventId),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        } else if (controller.speakers.isEmpty) {
          return Center(
            child: Text(
              'No speakers available.',
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.02),
            itemCount: controller.speakers.length,
            itemBuilder: (context, indexx) {
              return InkWell(
                onTap: containsBreak(
                        controller.speakers.value[indexx].sessionName)
                    ? null
                    : () async {
                        await controller.fetchSessions(
                            controller.speakers.value[indexx].sessionId);
                        istap = false;
                        setState(() {
                          speakersTab = Obx(() {
                            if (controller.isLoadingSessions.value) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.sessions.value = [];
                                          controller.sessions.refresh();
                                          istap = true;
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.25,
                                      ),
                                      Text(
                                        controller
                                            .speakers.value[indexx].sessionName,
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
                                    height: height * .2,
                                  ),
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ],
                              );
                            } else if (controller.hasErrorSessions.value) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.sessions.value = [];
                                            controller.sessions.refresh();
                                            istap = true;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.25,
                                        ),
                                        Text(
                                          controller.speakers.value[indexx]
                                              .sessionName,
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
                                      height: height * .15,
                                    ),
                                    Icon(Icons.error,
                                        color: Colors.redAccent, size: 40.w),
                                    SizedBox(height: 10.h),
                                    Text(
                                      controller.errorMessageSessions.value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19.sp,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    ElevatedButton(
                                      onPressed: () => controller.fetchSessions(
                                          controller.speakers.value[indexx]
                                              .sessionId),
                                      child: const Text("Retry"),
                                    ),
                                  ],
                                ),
                              );
                            } else if (controller.sessions.isEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.sessions.value = [];
                                            controller.sessions.refresh();
                                            istap = true;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.25,
                                        ),
                                        Text(
                                          controller.speakers.value[indexx]
                                              .sessionName,
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
                                      height: height * .2,
                                    ),
                                    Text(
                                      'No speakers available.',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04,
                                    vertical: height * 0.02),
                                itemCount: controller.sessions.value.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (index == 0)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                controller.sessions.value = [];
                                                controller.sessions.refresh();
                                                istap = true;
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back_ios,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.25,
                                            ),
                                            Text(
                                              controller.speakers.value[indexx]
                                                  .sessionName,
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
                                      InkWell(
                                        onTap: () {
                                          _showDialog(
                                              context,
                                              controller
                                                  .sessions.value[index].name,
                                              controller
                                                  .sessions.value[index].companyDetails,
                                              controller.sessions.value[index]
                                                  .description,
                                              width);
                                        },

                                        child: SessionSpeakerCard(
                                          imageUrl: controller
                                              .sessions.value[index].imageUrl,
                                          name: controller
                                              .sessions.value[index].name,
                                          toTime: controller
                                              .sessions.value[index].time,
                                          address: controller
                                              .sessions.value[index].topic,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        });
                      },
                child: Column(
                  children: [
                    Speakers(
                      sessionName:
                          controller.speakers.value[indexx].sessionName,
                      time: controller.speakers.value[indexx].time,
                      isBreak: containsBreak(
                          controller.speakers.value[indexx].sessionName),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
            },
          );
        }
      });
    }

    final sponsorsTab = Obx(() {
      if (controller.isSponsorLoading.value) {
        // Loading state
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      } else if (controller.hasSponsorError.value) {
        // Error state
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.redAccent, size: 40.w),
              SizedBox(height: 10.h),
              Text(
                controller.sponsorErrorMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () => controller.fetchSponsors(widget.eventId),
                child: const Text("Retry"),
              ),
            ],
          ),
        );
      } else if (controller.sponsors.isEmpty) {
        // Empty state
        return Center(
          child: Text(
            'No sponsors available.',
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        );
      } else {
        // Success state (show sponsors list)
        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.04,
            vertical: MediaQuery.sizeOf(context).height * 0.02,
          ),
          itemCount: controller.sponsors.length,
          itemBuilder: (context, index) {
            final sponsor = controller.sponsors.value[index];
            return Column(
              children: [
                Sponsors(
                  assetPath: sponsor.sponsorLogoPath,
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
              ],
            );
          },
        );
      }
    });

    // final sponsorsTab = ListView.builder(
    //   padding: EdgeInsets.symmetric(
    //       horizontal: width * 0.04, vertical: height * 0.02),
    //   itemCount: sponsorsData.length,
    //   itemBuilder: (context, index) {
    //     return Column(
    //       children: [
    //         Sponsors(
    //           assetPath: sponsorsData[index],
    //         ),
    //         SizedBox(height: 20.h),
    //       ],
    //     );
    //   },
    // );
    bool showButtons = int.parse(widget.eventYear) >= DateTime.now().year;

    return ReusableBackGroundScreen(
      tabTitles: const ["Schedule", "Speakers", "Sponsors"],
      tabViews: [scheduleTab, speakersTab, sponsorsTab],
      tbaButtons: showButtons
          ? [
              CustomButton(
                  text: 'Event Registration',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookSlotScreen(
                            eventId: widget.eventId,
                          ),
                        ));
                  }),
              CustomButton(
                  text: 'Event Registration',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookSlotScreen(
                            eventId: widget.eventId,
                          ),
                        ));
                  }),
              CustomButton(
                  text: 'Buy sponsorship',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuySponsorScreen(
                            eventId: widget.eventId,
                          ),
                        ));
                  }),
            ]
          : [],
    );
  }

  void _showDialog(BuildContext context, String name, String designation,
      String description, double width) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.lightPeach,
          title: Text('$name'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('$designation'),
                SizedBox(height: 7.h),
                Text("About : ",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 7.h),
                Text('$description'),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: 'Description:  ',
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold, // Bold the heading
                //           color: Colors.black, // Optional: Ensure it's visible
                //         ),
                //       ),
                //       TextSpan(
                //         text: description,
                //         style: TextStyle(
                //           color: Colors.black, // Optional: Color for the description
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: AppColors.orange2)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
// if (istap) {
//   speakersTab = Obx(() =>
//       ListView.builder(
//         padding: EdgeInsets.symmetric(
//             horizontal: width * 0.04, vertical: height * 0.02),
//         itemCount: controller.speakers.length,
//         itemBuilder: (context, indexx) {
//           return InkWell(
//             onTap: () async {
//               await controller.fetchSessions(
//                   controller.speakers.value[indexx].sessionId);
//               istap = false;
//               setState(() {
//                 speakersTab = ListView.builder(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: width * 0.04, vertical: height * 0.02),
//                   itemCount: controller.sessions.value.length,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         if (index == 0)
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     controller.sessions.value = [];
//                                     controller.sessions.refresh();
//                                     istap = true;
//                                     setState(() {});
//                                   },
//                                   icon: const Icon(
//                                     Icons.arrow_back_ios,
//                                     color: AppColors.white,
//                                   )),
//                               SizedBox(
//                                 width: width * 0.25,
//                               ),
//                               Text(
//                                 controller
//                                     .speakers.value[indexx].sessionName,
//                                 style: TextStyle(
//                                   fontFamily: 'poppins',
//                                   fontSize: width * 0.047,
//                                   color: AppColors.white,
//                                   fontWeight: FontWeight.w800,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         SizedBox(
//                           height: height * 0.03,
//                         ),
//                         SessionSpeakerCard(
//                           imageUrl:
//                           controller.sessions.value[index].imageUrl,
//                           name: controller.sessions.value[index].name,
//                           toTime: controller.sessions.value[index].time,
//                           address: controller.sessions.value[index].topic,
//                         )
//                       ],
//                     );
//                   },
//                 );
//               });
//             },
//             child: Column(
//               children: [
//                 Speakers(
//                   sessionName:
//                   controller.speakers.value[indexx].sessionName,
//                   time: controller.speakers.value[indexx].time,
//                 ),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           );
//         },
//       ));
// }

// final scheduleTab = Obx(() => ListView.builder(
//       padding: EdgeInsets.symmetric(
//           horizontal: width * 0.04, vertical: height * 0.02),
//       itemCount: controller.schedules.length,
//       itemBuilder: (context, index) {
//         final item = controller.schedules.value[index];
//         return Column(
//           children: [
//             Schedule(
//               time: item.scheduleTime!,
//               registrationText: item.scheduleTitle,
//               // additionalText: "item[" "additionalText" "]",
//             ),
//             SizedBox(height: height * 0.025),
//           ],
//         );
//       },
//     ));
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
//                     'lib/assets/logo_bigGyan.png',
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
