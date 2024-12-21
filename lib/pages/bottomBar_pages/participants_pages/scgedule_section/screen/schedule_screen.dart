import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/scgedule_section/controller/appoitment_schedule_controller.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For formatting the date if needed

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({
    super.key,
    this.opponentUserId,
    this.appointmentId, // Optional parameter for editing
  });

  final String? opponentUserId; // Optional now
  final String? appointmentId; // Nullable, used for editing

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    // GetX controller
    final AppointmentScheduleController appointmentController =
        Get.put(AppointmentScheduleController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // If editing, load existing data
    if (appointmentId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Fetch and populate data only once when the screen is initialized
        var doc = await appointmentController.firestore
            .collection('appointments')
            .doc(appointmentId)
            .get();

        if (doc.exists) {
          var data = doc.data();
          if (data != null) {
            print(data['subject']);
            appointmentController.subjectController.text =
                data['subject'] ?? '';
            appointmentController.descriptionController.text =
                data['description'] ?? '';
            appointmentController.meetingLinkController.text =
                data['meetingLink'] ?? '';
            appointmentController.meetingVenueController.text =
                data['meetingVenue'] ?? '';
            appointmentController.selectedDate.value = data['date'] ?? 'Date';
          }
        }
      });
    }

    var spacer = SizedBox(height: height * 0.03);

    return ReusableBackGroundScreen(
      appBarTitle:
          appointmentId != null ? 'Edit Appointment' : 'Schedule Appointment',
      singleView: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.03, horizontal: width * 0.05),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                spacer,
                buildDataContainer(
                    width, height, context, appointmentController),
                spacer,
                MyTextFeild(
                  hintText: 'Subject',
                  controller: appointmentController.subjectController,
                  validator: '',
                ),
                spacer,
                MyTextFeild(
                  hintText: 'Description',
                  controller: appointmentController.descriptionController,
                  validator: '',
                ),
                spacer,
                MyTextFeild(
                  hintText: 'Meeting link (optional)',
                  controller: appointmentController.meetingLinkController,
                  validator: 'optional',
                ),
                spacer,
                MyTextFeild(
                  hintText: 'Meeting Venue (optional)',
                  controller: appointmentController.meetingVenueController,
                  validator: 'optional',
                ),
                spacer,
                spacer,
                Obx(() {
                  return appointmentController.isLoading.value
                      ? CircularProgressIndicator()
                      : CustomButton(
                          text: appointmentId != null
                              ? 'Update Appointment'
                              : 'Schedule',
                          onPressed: () async {
                            if (formKey.currentState != null &&
                                formKey.currentState!.validate()) {
                              if (appointmentId != null) {
                                // Update the appointment
                                await appointmentController
                                    .updateAppointment(appointmentId!);
                              } else {
                                // Create a new appointment
                                if (opponentUserId == null) {
                                  appointmentController.hasError.value = true;
                                  appointmentController.errorMessage.value =
                                      'Opponent user ID is required for new appointments.';
                                  return;
                                }
                                await appointmentController
                                    .createAppointment(opponentUserId!);
                              }

                              // Clear text fields after operation
                              appointmentController.subjectController.clear();
                              appointmentController.descriptionController
                                  .clear();
                              appointmentController.meetingLinkController
                                  .clear();
                              appointmentController.meetingVenueController
                                  .clear();

                              // Pop the screen back to previous
                              Navigator.of(context).pop();
                            }
                          },
                        );
                }),
                Obx(() {
                  if (appointmentController.hasError.value) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        appointmentController.errorMessage.value,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return SizedBox.shrink(); // Empty widget if no error
                }),
              ],
            ),
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
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              controller.selectedDate.value,
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
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
}

// class ScheduleScreen extends StatelessWidget {
//   ScheduleScreen({super.key, required this.opponentUserId});
//
//   final String opponentUserId;
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//
//     // GetX controller
//     final AppointmentScheduleController appointmentController =
//     Get.put(AppointmentScheduleController());
//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//     var spacer = SizedBox(
//       height: height * 0.03,
//     );
//
//     return ReusableBackGroundScreen(
//       appBarTitle: 'Schedule appointment',
//       singleView: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               vertical: height * 0.03, horizontal: width * 0.05),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 spacer,
//                 buildDataContainer(width, height, context, appointmentController),
//                 spacer,
//                 MyTextFeild(
//                   hintText: 'Subject',
//                   controller: appointmentController.subjectController,
//                   validator: '',
//                 ),
//                 spacer,
//                 MyTextFeild(
//                   hintText: 'Description',
//                   controller: appointmentController.descriptionController,
//                   validator: '',
//
//                 ),
//                 spacer,
//                 MyTextFeild(
//                   hintText: 'Meeting link (optional)',
//                   controller: appointmentController.meetingLinkController,
//                   validator: 'optional',
//
//                 ),
//                 spacer,
//                 MyTextFeild(
//                   hintText: 'Meeting Venue (optional).',
//                   controller: appointmentController.meetingVenueController,
//                   validator: 'optional',
//                 ),
//                 spacer,
//                 spacer,
//                 Obx(() {
//                   return appointmentController.isLoading.value
//                       ? CircularProgressIndicator()
//                       : CustomButton(
//                     text: 'Schedule',
//                     onPressed: () async {
//                       // Check if the formKey's currentState is not null before calling validate
//                       if (formKey.currentState != null && formKey.currentState!.validate()) {
//                         await appointmentController.createAppointment(opponentUserId);
//
//                         // Clear the text fields after appointment creation
//                         appointmentController.subjectController.clear();
//                         appointmentController.descriptionController.clear();
//                         appointmentController.meetingLinkController.clear();
//                         appointmentController.meetingVenueController.clear();
//
//                         // Pop the screen back to previous
//                         Navigator.of(context).pop();
//                       }
//                     },
//                   );
//                 }),
//
//                 // Obx(() {
//                 //   return appointmentController.isLoading.value
//                 //       ? CircularProgressIndicator()
//                 //       : CustomButton(
//                 //     text: 'Schedule',
//                 //     onPressed: () async {
//                 //       if(formKey.currentState!.validate()) {
//                 //         await appointmentController.createAppointment(
//                 //             opponentUserId);
//                 //       }
//                 //
//                 //       // Clear the text fields after appointment creation
//                 //       appointmentController.subjectController.clear();
//                 //       appointmentController.descriptionController.clear();
//                 //       appointmentController.meetingLinkController.clear();
//                 //       appointmentController.meetingVenueController.clear();
//                 //
//                 //       // Pop the screen back to previous
//                 //       Navigator.of(context).pop();
//                 //     },
//                 //   );
//                 // }),
//                 // Display error message if there is an error
//                 Obx(() {
//                   if (appointmentController.hasError.value) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: Text(
//                         appointmentController.errorMessage.value,
//                         style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }
//                   return SizedBox.shrink(); // Empty widget if no error
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildDataContainer(double width, double height, BuildContext context,
//       AppointmentScheduleController controller) {
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
//           Obx(
//                 () => Text(
//               controller.selectedDate.value,
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: width * 0.035,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () async {
//               // Open the date picker dialog
//               DateTime? selectedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2101),
//               );
//               if (selectedDate != null) {
//                 // Update the controller's text field with the selected date
//                 controller.selectedDate.value =
//                     DateFormat('yyyy-MM-dd').format(selectedDate);
//               }
//             },
//             icon: Icon(
//               Icons.calendar_month,
//               size: width * 0.05,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
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
