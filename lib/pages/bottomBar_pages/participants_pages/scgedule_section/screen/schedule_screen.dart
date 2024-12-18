import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/scgedule_section/controller/appoitment_schedule_controller.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For formatting the date if needed

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key, required this.opponentUserId});

  String opponentUserId;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    // GetX controller
    final AppointmentScheduleController appointmentController =
        Get.put(AppointmentScheduleController());

    var spacer = SizedBox(
      height: height * 0.03,
    );

    return ReusableBackGroundScreen(
      appBarTitle: 'Schedule appointment',
      singleView: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.03, horizontal: width * 0.05),
          child: Column(
            children: [
              spacer,
              buildDataContainer(width, height, context, appointmentController),
              spacer,
              MyTextFeild(
                hintText: 'Subject',
                controller: appointmentController.subjectController,
              ),
              spacer,
              MyTextFeild(
                hintText: 'Description',
                controller: appointmentController.descriptionController,
              ),
              spacer,
              MyTextFeild(
                hintText: 'Meeting link (optional)',
                controller: appointmentController.meetingLinkController,
              ),
              spacer,
              MyTextFeild(
                hintText: 'Meeting Venue (optional).',
                controller: appointmentController.meetingVenueController,
              ),
              spacer,
              spacer,
              CustomButton(
                text: 'Schedule',
                onPressed: () {
                  // Assuming the current user ID is stored in 'currentUserId'
                  // String currentUserId =
                  //     "currentUser123"; // Replace with actual current user ID
                  // String opponentUserId =
                  //     "otherUser456"; // Replace with actual opponent user ID

                  // Pass only two participants (currentUser and opponentUser) to the controller
                  appointmentController.createAppointment(opponentUserId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDataContainer(double width, double height, BuildContext context,
      AppointmentScheduleController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.0065, horizontal: width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              controller.selectedDate.value,
              style: TextStyle(
                color: Colors.grey,
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              // Open the date picker dialog
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                // Update the controller's text field with the selected date
                print(controller.selectedDate.value);
                controller.selectedDate.value =
                    DateFormat('yyyy-MM-dd').format(selectedDate);
              }
            },
            icon: Icon(
              Icons.calendar_month,
              size: width * 0.05,
            ),
          )
        ],
      ),
    );
  }
// Widget buildDataContainer(double width, double height, BuildContext context, AppointmentScheduleController controller) {
//   return Container(
//     padding: EdgeInsets.symmetric(
//         vertical: height * 0.0065, horizontal: width * 0.035),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(20.r),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Date",
//           style: TextStyle(
//             color: Colors.grey,
//             fontSize: width * 0.035,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         IconButton(
//             onPressed: () async {
//               DateTime? selectedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2101),
//               );
//               if (selectedDate != null) {
//                 controller.dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//               }
//             },
//             icon: Icon(
//               Icons.calendar_month,
//               size: width * 0.05,
//             ))
//       ],
//     ),
//   );
// }
}

// class ScheduleScreen extends StatelessWidget {
//   const ScheduleScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//
//     TextEditingController textEditingController = TextEditingController();
//
//     var spacer = SizedBox(
//       height: height * 0.03,
//     );
//
//     return ReusableBackGroundScreen(
//       appBarTitle: 'Schedule appointment',
//       singleView: Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: height * 0.03, horizontal: width * 0.05),
//         child: Column(
//           children: [
//             spacer,
//             buildDataContainer(width, height),
//             spacer,
//             MyTextFeild(
//               hintText: 'Subject',
//               controller: textEditingController,
//             ),
//             spacer,
//             MyTextFeild(
//               hintText: 'Description',
//               controller: textEditingController,
//             ),
//             spacer,
//             MyTextFeild(
//               hintText: 'Meeting link (optional)',
//               controller: textEditingController,
//             ),
//             spacer,
//             MyTextFeild(
//               hintText: 'Meeting Venue (optional).',
//               controller: textEditingController,
//             ),
//
//             spacer,
//             spacer,
//             CustomButton(text: 'Schedule', onPressed: () {})
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget buildDataContainer(double width, double height) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           vertical: height * 0.0065, horizontal: width * 0.035),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Date",
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: width * 0.035,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.calendar_month,
//                 size: width * 0.05,
//               ))
//         ],
//       ),
//     );
//   }
// }
