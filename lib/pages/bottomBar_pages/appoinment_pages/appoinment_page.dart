import 'package:bima_gyaan/pages/bottomBar_pages/appoinment_pages/appoinment_card_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/appoinment_pages/controllers/appoitmentController.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/appoinment_pages/models/appoitmentModel.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/scgedule_section/screen/schedule_screen.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppoinmentPage extends StatefulWidget {
  const AppoinmentPage({super.key});

  @override
  State<AppoinmentPage> createState() => _AppoinmentPageState();
}

class _AppoinmentPageState extends State<AppoinmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    appointmentController.fetchUserAppointments();
    super.initState();
  }

  Future<void> _refreshAppointments() async {
    await appointmentController.fetchUserAppointments();
    appointmentController.appointments.refresh();
  }

  Widget _buildAppointmentList(List<AppointmentModel> appointments,
      String emptyMessage, String currentUserId) {
    return RefreshIndicator(
      color: AppColors.orange2,
      onRefresh: _refreshAppointments,
      child: appointmentController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : appointmentController.errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    appointmentController.errorMessage.value,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : appointments.isEmpty
                  ? Center(
                      child: Text(
                        emptyMessage,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = appointments[index];

                        bool showAcceptRejectButtons =
                            appointment.status == 'pending' &&
                                appointment.createdBy != currentUserId;

                        bool showRescheduleCancelButtons =
                            appointment.status == 'accepted' &&
                                appointment.createdBy == currentUserId;

                        bool showRescheduleButton =
                            appointment.status == 'rejected' &&
                                appointment.createdBy == currentUserId;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.sizeOf(context).height * 0.015,
                            horizontal: MediaQuery.sizeOf(context).width * 0.03,
                          ),
                          child: AppoinmentCardWidget(
                            name: appointment.oppositeUserName ?? 'Unknown',
                            subject: appointment.subject.isEmpty
                                ? 'No Subject'
                                : appointment.subject,
                            description: appointment.description.isEmpty
                                ? 'No Description'
                                : appointment.description,
                            dateOrTime: appointment.date,
                            rightSideWidget: const Icon(Icons.calendar_today),
                            imageUrl: appointment.oppositeUserImage ?? '',
                            button1Text: showAcceptRejectButtons
                                ? "Accept"
                                : showRescheduleCancelButtons ||
                                        showRescheduleButton
                                    ? "Reschedule"
                                    : null,
                            button2Text: showAcceptRejectButtons
                                ? "Reject"
                                : showRescheduleCancelButtons
                                    ? "Cancel"
                                    : null,
                            button1onPressed: showAcceptRejectButtons
                                ? () async {
                                    await appointmentController
                                        .updateAppointmentStatus(
                                      appointment.id,
                                      'accepted',
                                    );
                                    print(
                                        "Appointment accepted: ${appointment.subject}");
                                  }
                                : showRescheduleCancelButtons ||
                                        showRescheduleButton
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ScheduleScreen(
                                              appointmentId: appointment.id,
                                            ),
                                          ),
                                        );
                                        print(
                                            "Reschedule button pressed for ${appointment.subject}");
                                      }
                                    : null,
                            button2onPressed: showAcceptRejectButtons
                                ? () async {
                                    await appointmentController
                                        .updateAppointmentStatus(
                                      appointment.id,
                                      'rejected',
                                    );
                                    print(
                                        "Appointment rejected: ${appointment.subject}");
                                  }
                                : showRescheduleCancelButtons
                                    ? () {
                                        appointmentController
                                            .deleteAppointment(appointment.id);
                                        print(
                                            "Cancel button pressed for ${appointment.subject}");
                                      }
                                    : null,
                            meetingLinkOrLocation:
                                appointment.meetingLink ?? 'No Link',
                          ),
                        );
                      },
                    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserId =
        appointmentController.auth.currentUser!.uid; // Get current user ID
    return ReusableBackGroundScreen(
      tabTitles: const ["Pending", "Accepted", "Rejected"],
      tabViews: [
        Obx(() {
          final pendingAppointments = appointmentController.appointments
              .where((appointment) => appointment.status == 'pending')
              .toList();
          return _buildAppointmentList(pendingAppointments,
              'No pending appointments found.', currentUserId);
        }),
        Obx(() {
          final acceptedAppointments = appointmentController.appointments
              .where((appointment) => appointment.status == 'accepted')
              .toList();
          return _buildAppointmentList(acceptedAppointments,
              'No accepted appointments found.', currentUserId);
        }),
        Obx(() {
          final rejectedAppointments = appointmentController.appointments
              .where((appointment) => appointment.status == 'rejected')
              .toList();
          return _buildAppointmentList(rejectedAppointments,
              'No rejected appointments found.', currentUserId);
        }),
      ],
    );
  }
}

// class AppoinmentPage extends StatefulWidget {
//   const AppoinmentPage({super.key});
//
//   @override
//   State<AppoinmentPage> createState() => _AppoinmentPageState();
// }
//
// class _AppoinmentPageState extends State<AppoinmentPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final AppointmentController appointmentController =
//       Get.put(AppointmentController());
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 3, vsync: this);
//     appointmentController.fetchUserAppointments();
//     super.initState();
//   }
//   Widget _buildAppointmentList(List<AppointmentModel> appointments,
//       String emptyMessage, String currentUserId) {
//     if (appointmentController.isLoading.value) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     } else if (appointmentController.errorMessage.isNotEmpty) {
//       return Center(
//         child: Text(
//           appointmentController.errorMessage.value,
//           style: const TextStyle(color: Colors.red, fontSize: 16),
//         ),
//       );
//     } else if (appointments.isEmpty) {
//       return Center(
//         child: Text(
//           emptyMessage,
//           style: const TextStyle(color: Colors.grey, fontSize: 16),
//         ),
//       );
//     } else {
//       return ListView.builder(
//         itemCount: appointments.length,
//         itemBuilder: (context, index) {
//           final appointment = appointments[index];
//
//           bool showAcceptRejectButtons =
//               appointment.status == 'pending' && appointment.createdBy != currentUserId;
//
//           bool showRescheduleCancelButtons =
//               appointment.status == 'accepted' && appointment.createdBy == currentUserId;
//
//           bool showRescheduleButton =
//               appointment.status == 'rejected' && appointment.createdBy == currentUserId;
//
//           return Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: MediaQuery.sizeOf(context).height * 0.015,
//               horizontal: MediaQuery.sizeOf(context).width * 0.03,
//             ),
//             child: AppoinmentCardWidget(
//               name: appointment.oppositeUserName ?? 'Unknown',
//               subject: appointment.subject.isEmpty ? 'No Subject' : appointment.subject,
//               description: appointment.description.isEmpty ? 'No Description' : appointment.description,
//               dateOrTime: appointment.date,
//               rightSideWidget: const Icon(Icons.calendar_today),
//               imageUrl: appointment.oppositeUserImage ?? '',
//
//               button1Text: showAcceptRejectButtons
//                   ? "Accept"
//                   : showRescheduleCancelButtons || showRescheduleButton
//                   ? "Reschedule"
//                   : null,
//               button2Text: showAcceptRejectButtons
//                   ? "Reject"
//                   : showRescheduleCancelButtons
//                   ? "Cancel"
//                   : null,
//
//               button1onPressed: showAcceptRejectButtons
//                   ? () async {
//                 await appointmentController.updateAppointmentStatus(
//                   appointment.id,
//                   'accepted',
//                 );
//                 print("Appointment accepted: ${appointment.subject}");
//               }
//                   : showRescheduleCancelButtons || showRescheduleButton
//                   ? () {
//                 print("Reschedule button pressed for ${appointment.subject}");
//               }
//                   : null,
//
//               button2onPressed: showAcceptRejectButtons
//                   ? () async {
//                 await appointmentController.updateAppointmentStatus(
//                   appointment.id,
//                   'rejected',
//                 );
//                 print("Appointment rejected: ${appointment.subject}");
//               }
//                   : showRescheduleCancelButtons
//                   ? () {
//                 print("Cancel button pressed for ${appointment.subject}");
//               }
//                   : null,
//
//               meetingLinkOrLocation: appointment.meetingLink ?? 'No Link',
//             ),
//           );
//         },
//       );
//     }
//   }
//
//   // Widget _buildAppointmentList(List<AppointmentModel> appointments,
//   //     String emptyMessage, String currentUserId) {
//   //   if (appointmentController.isLoading.value) {
//   //     return const Center(
//   //       child: CircularProgressIndicator(),
//   //     );
//   //   } else if (appointmentController.errorMessage.isNotEmpty) {
//   //     return Center(
//   //       child: Text(
//   //         appointmentController.errorMessage.value,
//   //         style: const TextStyle(color: Colors.red, fontSize: 16),
//   //       ),
//   //     );
//   //   } else if (appointments.isEmpty) {
//   //     return Center(
//   //       child: Text(
//   //         emptyMessage,
//   //         style: const TextStyle(color: Colors.grey, fontSize: 16),
//   //       ),
//   //     );
//   //   } else {
//   //     return ListView.builder(
//   //       itemCount: appointments.length,
//   //       itemBuilder: (context, index) {
//   //         final appointment = appointments[index];
//   //
//   //         // Logic for button visibility
//   //         bool showAcceptRejectButtons = appointment.status == 'pending' &&
//   //             appointment.createdBy != currentUserId;
//   //
//   //         bool showRescheduleCancelButtons = appointment.status == 'accepted' &&
//   //             appointment.createdBy == currentUserId;
//   //
//   //         bool showRescheduleButton = appointment.status == 'rejected' &&
//   //             appointment.createdBy == currentUserId;
//   //
//   //         return Padding(
//   //           padding: EdgeInsets.symmetric(
//   //             vertical: MediaQuery.sizeOf(context).height * 0.015,
//   //             horizontal: MediaQuery.sizeOf(context).width * 0.03,
//   //           ),
//   //           child: AppoinmentCardWidget(
//   //             name: appointment.oppositeUserName ?? 'Unknown',
//   //             subject: appointment.subject.isEmpty
//   //                 ? 'No Subject'
//   //                 : appointment.subject,
//   //             description: appointment.description.isEmpty
//   //                 ? 'No Description'
//   //                 : appointment.description,
//   //             dateOrTime: appointment.date,
//   //             rightSideWidget: const Icon(Icons.calendar_today),
//   //             imageUrl: appointment.oppositeUserImage ?? '',
//   //
//   //             // Conditional buttons
//   //             button1Text: showAcceptRejectButtons
//   //                 ? "Accept"
//   //                 : showRescheduleCancelButtons || showRescheduleButton
//   //                     ? "Reschedule"
//   //                     : null,
//   //             button2Text: showAcceptRejectButtons
//   //                 ? "Reject"
//   //                 : showRescheduleCancelButtons
//   //                     ? "Cancel"
//   //                     : null,
//   //
//   //             button1onPressed: showAcceptRejectButtons
//   //                 ? () {
//   //                     print("Accept button pressed for ${appointment.subject}");
//   //                   }
//   //                 : showRescheduleCancelButtons || showRescheduleButton
//   //                     ? () {
//   //                         print(
//   //                             "Reschedule button pressed for ${appointment.subject}");
//   //                       }
//   //                     : null,
//   //
//   //             button2onPressed: showAcceptRejectButtons
//   //                 ? () {
//   //                     print("Reject button pressed for ${appointment.subject}");
//   //                   }
//   //                 : showRescheduleCancelButtons
//   //                     ? () {
//   //                         print(
//   //                             "Cancel button pressed for ${appointment.subject}");
//   //                       }
//   //                     : null,
//   //
//   //             meetingLinkOrLocation: appointment.meetingLink ?? 'No Link',
//   //           ),
//   //         );
//   //       },
//   //     );
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final String currentUserId =
//         appointmentController.auth.currentUser!.uid; // Get current user ID
//     return ReusableBackGroundScreen(
//       tabTitles: const ["Pending", "Accepted", "Rejected"],
//       tabViews: [
//         Obx(() {
//           final pendingAppointments = appointmentController.appointments
//               .where((appointment) => appointment.status == 'pending')
//               .toList();
//           return _buildAppointmentList(pendingAppointments,
//               'No pending appointments found.', currentUserId);
//         }),
//         Obx(() {
//           final acceptedAppointments = appointmentController.appointments
//               .where((appointment) => appointment.status == 'accepted')
//               .toList();
//           return _buildAppointmentList(acceptedAppointments,
//               'No accepted appointments found.', currentUserId);
//         }),
//         Obx(() {
//           final rejectedAppointments = appointmentController.appointments
//               .where((appointment) => appointment.status == 'rejected')
//               .toList();
//           return _buildAppointmentList(rejectedAppointments,
//               'No rejected appointments found.', currentUserId);
//         }),
//       ],
//     );
//   }
// }

// class AppoinmentPage extends StatefulWidget {
//   const AppoinmentPage({super.key});
//
//   @override
//   State<AppoinmentPage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<AppoinmentPage>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 3, vsync: this);
//     super.initState();
//   }
// AppointmentController appointmentController = Get.put(AppointmentController());
//   @override
//   Widget build(BuildContext context) {
//     appointmentController.fetchUserAppointments();
//     // Tab content
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     final pending = Obx(() {
//       final pendingAppointments = appointmentController.appointments
//           .where((appointment) => appointment.status == 'pending')
//           .toList();
//       if (appointmentController.isLoading.value) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (appointmentController.errorMessage.isNotEmpty) {
//         return Center(
//           child: Text(
//             appointmentController.errorMessage.value,
//             style: const TextStyle(color: Colors.red, fontSize: 16),
//           ),
//         );
//       } else if (pendingAppointments.isEmpty) {
//         return const Center(
//           child: Text(
//             'No pending appointments found.',
//             style: TextStyle(color: Colors.grey, fontSize: 16),
//           ),
//         );
//       } else {
//         return ListView.builder(
//           itemCount: pendingAppointments.length,
//           itemBuilder: (context, index) {
//             final appointment = pendingAppointments[index];
//             return Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: height * 0.015,
//                 horizontal: width * 0.03,
//               ),
//
//               child: AppoinmentCardWidget(
//                 name: appointment.oppositeUserName!, // Use participant data if needed
//                 subject: appointment.subject.isEmpty
//                     ? 'No Subject'
//                     : appointment.subject,
//                 description: appointment.description.isEmpty
//                     ? 'No Description'
//                     : appointment.description,
//                 dateOrTime: appointment.date,
//                 rightSideWidget: const Icon(Icons.calendar_today),
//                 imageUrl: appointment.oppositeUserImage!, // Placeholder
//                 button1Text: "Accept",
//                 button2Text: "Reject",
//                 button1onPressed: () {
//                   // Handle Accept button press
//                   print("Accept button pressed for ${appointment.subject}");
//                 },
//                 button2onPressed: () {
//                   // Handle Reject button press
//                   print("Reject button pressed for ${appointment.subject}");
//                 },
//                 meetingLinkOrLocation: appointment.meetingLink ?? 'No Link',
//               ),
//             );
//           },
//         );
//       }
//     });
//
//     final accepted = ListView.builder(
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return Padding(
//             padding: EdgeInsets.symmetric(
//                 vertical: height * 0.015, horizontal: width * 0.03),
//             child: AppoinmentCardWidget(
//               name: "John Doe",
//               subject: "Follow-up Meeting",
//               description: "Discuss progress and next steps for the project.",
//               dateOrTime: "2024-12-10 10:00 AM",
//               rightSideWidget: Icon(Icons.calendar_today),
//               // Just an example widget
//               imageUrl: "https://example.com/profile.jpg",
//               // Image URL (if needed)
//               button1Text: "Reschedule",
//               button2Text: "Cancel",
//               button1onPressed: () {
//                 // Handle Schedule button press
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => RescheduleAppoitment(),
//                     ));
//               },
//               button2onPressed: () {
//                 // Handle Chat button press
//                 print("Chat button pressed");
//               },
//               meetingLinkOrLocation:
//                   "Meeting Room 3 / Zoom Link", // Example link or location
//             ));
//       },
//     );
//     final rejected = ListView.builder(
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return Padding(
//             padding: EdgeInsets.symmetric(
//                 vertical: height * 0.015, horizontal: width * 0.03),
//             child: AppoinmentCardWidget(
//               name: "John Doe",
//               subject: "Follow-up Meeting",
//               description: "Discuss progress and next steps for the project.",
//               dateOrTime: "2024-12-10 10:00 AM",
//               rightSideWidget: Icon(Icons.calendar_today),
//               // Just an example widget
//               imageUrl: "https://example.com/profile.jpg",
//               // Image URL (if needed)
//               button1Text: "Reschedule",
//               button1onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => RescheduleAppoitment(),
//                     ));
//                 // Handle Schedule button press
//                 print("Schedule button pressed");
//               },
//
//               meetingLinkOrLocation:
//                   "Meeting Room 3 / Zoom Link", // Example link or location
//             ));
//       },
//     );
//
//     return ReusableBackGroundScreen(
//       tabTitles: const ["Pending", "Accepted", "Rejected"],
//       tabViews: [pending, accepted, rejected],
//     );
//   }
// }
// final pending = ListView.builder(
//   itemCount: 5,
//   itemBuilder: (context, index) {
//     return Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: height * 0.015, horizontal: width * 0.03),
//         child: AppoinmentCardWidget(
//           name: "John Doe",
//           subject: "Follow-up Meeting",
//           description: "Discuss progress and next steps for the project.",
//           dateOrTime: "2024-12-10 10:00 AM",
//           rightSideWidget: Icon(Icons.calendar_today),
//           // Just an example widget
//           imageUrl: "https://example.com/profile.jpg",
//           // Image URL (if needed)
//           button1Text: "Accept",
//           button2Text: "Reject",
//           button1onPressed: () {
//             // Handle Schedule button press
//             print("Schedule button pressed");
//           },
//           button2onPressed: () {
//             // Handle Chat button press
//             print("Chat button pressed");
//           },
//           meetingLinkOrLocation:
//               "Meeting Room 3 / Zoom Link", // Example link or location
//         ));
//   },
// );

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
