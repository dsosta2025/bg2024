import 'package:bima_gyaan/pages/bottomBar_pages/event_pages/Widgets/calendar_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/event_pages/controller/eventController.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart'; // Add this dependency

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart'; // For calendar widget

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final EventsController controller = Get.put(EventsController());
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Image.asset(
          'lib/assets/BG LOGO3.png',
          height: 26.h,
          width: 290.33.w,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Sponsored by',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        letterSpacing: 0.001,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Image.asset(
                      'lib/assets/Plus Logo.png',
                      width: 69.82.w,
                      height: 16.h,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Powered by',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        letterSpacing: 0.001,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    Image.asset(
                      'lib/assets/logo_bigGyan.png',
                      width: 70.w,
                      height: 50.h,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Obx(() {
              return Container(
                width: 344.w,
                height: 95.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.blueGradient,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.dark.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    controller.selectedEventName.value.isEmpty
                        ? 'No Event on this day'
                        : controller.selectedEventName.value,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 30.h),
            Container(
              width: 345.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 1, 1),
                    lastDay: DateTime.utc(2030, 1, 1),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDay);
                      print(formattedDate);
                      controller.findEventByDate(formattedDate);
                    },
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: AppColors.orange2,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false, // Hides the "2 weeks" toggle button
                    ),
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month', // Only allow the month view
                    },
                  )

                  // TableCalendar(
                  //   firstDay: DateTime.utc(2010, 1, 1),
                  //   lastDay: DateTime.utc(2030, 1, 1),
                  //   focusedDay: _focusedDay,
                  //   selectedDayPredicate: (day) {
                  //     return isSameDay(_selectedDay, day);
                  //   },
                  //   onDaySelected: (selectedDay, focusedDay) {
                  //     setState(() {
                  //       _selectedDay = selectedDay;
                  //       _focusedDay = focusedDay;
                  //     });
                  //     final formattedDate =
                  //         DateFormat('dd/MM/yyyy').format(selectedDay);
                  //     print(formattedDate);
                  //     controller.findEventByDate(formattedDate);
                  //   },
                  //   calendarStyle: const CalendarStyle(
                  //     selectedDecoration: BoxDecoration(
                  //       color: AppColors.orange2,
                  //       // Change this to your desired color
                  //       shape: BoxShape.circle, // Shape of the selected date
                  //     ),
                  //     todayDecoration: BoxDecoration(
                  //       color: Colors.blue, // Color for the current day
                  //       shape: BoxShape.circle,
                  //     ),
                  //     selectedTextStyle: TextStyle(
                  //       color: Colors.white, // Text color for the selected date
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     todayTextStyle: TextStyle(
                  //       color: Colors.white, // Text color for today's date
                  //     ),
                  //   ),
                  // )

                  // TableCalendar(
                  //   firstDay: DateTime.utc(2010, 1, 1),
                  //   lastDay: DateTime.utc(2030, 1, 1),
                  //   focusedDay: _focusedDay,
                  //
                  //   selectedDayPredicate: (day) {
                  //     return isSameDay(_selectedDay, day);
                  //   },
                  //   onDaySelected: (selectedDay, focusedDay) {
                  //     setState(() {
                  //       _selectedDay = selectedDay;
                  //       _focusedDay = focusedDay;
                  //     });
                  //     final formattedDate =
                  //         DateFormat('dd/MM/yyyy').format(selectedDay);
                  //     print(formattedDate);
                  //     controller.findEventByDate(formattedDate);
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class EventsPage extends StatelessWidget {
//   const EventsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         title: Image.asset(
//           'lib/assets/BG LOGO3.png',
//           height: 26.h,
//           width: 290.33.w,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 10.h),
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 18.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         'Sponsored by',
//                         style: TextStyle(
//                           fontFamily: 'Poppins',
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w400,
//                           height: 1.4,
//                           letterSpacing: 0.001,
//                           textBaseline: TextBaseline.alphabetic,
//                         ),
//                       ),
//                       SizedBox(height: 10.h),
//                       Image.asset(
//                         'lib/assets/Plus Logo.png',
//                         width: 69.82.w,
//                         height: 16.h,
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 50.w),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Powered by',
//                           style: TextStyle(
//                             fontFamily: 'Poppins',
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w400,
//                             height: 1.4,
//                             letterSpacing: 0.001,
//                             textBaseline: TextBaseline.alphabetic,
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         Image.asset(
//                           'lib/assets/logo_bigGyan.png',
//                           width: 66.w,
//                           height: 23.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.h),
//             Container(
//               width: 344.w,
//               height: 95.h,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: AppColors.blueGradient,
//                 ),
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.dark.withOpacity(0.1),
//                     spreadRadius: 2,
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: const Center(
//                 child: Text(
//                   'No Event on this day',
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     color: AppColors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30.h),
//             Container(
//               width: 345.w,
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(20.r),
//                 // borderRadius: BorderRadius.only(
//                 //   topLeft: Radius.circular(20.r),
//                 //   topRight: Radius.circular(20.r),
//                 // ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     spreadRadius: 2,
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: const Column(
//                 children: [
//                   SizedBox(height: 20),
//                   CalendarWidget(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
