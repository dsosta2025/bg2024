import 'package:bima_gyaan/pages/bottomBar_pages/appoinment_pages/models/appoitmentModel.dart';
import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Auth
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/customesnackbar.dart';
class AppointmentScheduleController extends GetxController {
  // Define the controller variables for each input field
  var subjectController = TextEditingController();
  var descriptionController = TextEditingController();
  var meetingLinkController = TextEditingController();
  var meetingVenueController = TextEditingController();
  var selectedDate = "Date".obs;

  // Loading and error states
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = "".obs;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to create an appointment with only two participants
  Future<void> createAppointment(String opponentUserId) async {
    try {
      // Set loading state to true
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      // Get the current user's ID
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        hasError.value = true;
        errorMessage.value = 'No user is currently signed in';
        CustomSnackbarr.show(Get.context!, 'Error', errorMessage.value, isError: true);
        return;
      }

      // Create the participants list with currentUser and opponentUser
      List<String> participants = [currentUser.uid, opponentUserId];

      // Prepare the appointment data
      AppointmentModel newAppointment = AppointmentModel(
        id: '', // Will be set after the document is added
        createdBy: currentUser.uid,
        date: selectedDate.value,
        description: descriptionController.text,
        meetingLink: meetingLinkController.text.isNotEmpty
            ? meetingLinkController.text
            : null,
        meetingVenue: meetingVenueController.text.isNotEmpty
            ? meetingVenueController.text
            : null,
        participants: participants,
        status: 'pending',
        subject: subjectController.text,
        createdAt: DateTime.now(), // Local time for UI display purposes
        oppositeUserName: null, // Can be fetched and set later
        oppositeUserImage: null, // Can be fetched and set later
      );

      // Add the appointment to Firestore
      final docRef = await _firestore
          .collection('appointments')
          .add(newAppointment.toMap());

      // Get the generated document ID and update it in Firestore
      String documentId = docRef.id;
      await _firestore.collection('appointments').doc(documentId).update({
        'id': documentId,
      });

      // Set loading state to false and show success snackbar
      isLoading.value = false;
      CustomSnackbarr.show(Get.context!, 'Success', 'Appointment scheduled successfully!');
    } catch (e) {
      // Handle error
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = 'Failed to schedule appointment: $e';
      CustomSnackbarr.show(Get.context!, 'Error', errorMessage.value, isError: true);
    }
  }
}

// class AppointmentScheduleController extends GetxController {
//   // Define the controller variables for each input field
//   var subjectController = TextEditingController();
//   var descriptionController = TextEditingController();
//   var meetingLinkController = TextEditingController();
//   var meetingVenueController = TextEditingController();
//   var selectedDate = "Date".obs;
//
//   // Firestore instance
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // Method to create an appointment with only two participants
//   Future<void> createAppointment(String opponentUserId) async {
//     try {
//       // Get the current user's ID
//       User? currentUser = _auth.currentUser;
//
//       if (currentUser == null) {
//         Get.snackbar('Error', 'No user is currently signed in');
//         return;
//       }
//       // Create the participants list with currentUser and opponentUser
//       List<String> participants = [currentUser.uid, opponentUserId];
//       // Prepare the appointment data
//       AppointmentModel newAppointment = AppointmentModel(
//         id: '', // Will be set after the document is added
//         createdBy: currentUser.uid,
//         date: selectedDate.value,
//         description: descriptionController.text,
//         meetingLink: meetingLinkController.text.isNotEmpty
//             ? meetingLinkController.text
//             : null,
//         meetingVenue: meetingVenueController.text.isNotEmpty
//             ? meetingVenueController.text
//             : null,
//         participants: participants,
//         status: 'pending',
//         subject: subjectController.text,
//         createdAt: DateTime.now(), // Local time for UI display purposes
//         oppositeUserName: null, // Can be fetched and set later
//         oppositeUserImage: null, // Can be fetched and set later
//       );
//
//       // Add the appointment to Firestore
//       final docRef = await _firestore
//           .collection('appointments')
//           .add(newAppointment.toMap());
//
//       // Get the generated document ID and update it in Firestore
//       String documentId = docRef.id;
//       await _firestore.collection('appointments').doc(documentId).update({
//         'id': documentId,
//       });
//
//       Get.snackbar('Success', 'Appointment scheduled successfully!');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to schedule appointment: $e');
//     }
//   }
//
//   // Future<void> createAppointment(String opponentUserId) async {
//   //   try {
//   //     // Get the current user's ID
//   //     User? currentUser = _auth.currentUser;
//   //
//   //     if (currentUser == null) {
//   //       Get.snackbar('Error', 'No user is currently signed in');
//   //       return;
//   //     }
//   //
//   //     // Create the participants list with currentUser and opponentUser
//   //     List<String> participants = [currentUser.uid, opponentUserId];
//   //
//   //     // Appointment data to be stored in Firestore
//   //     await _firestore.collection('appointments').add({
//   //       'participants': participants,
//   //       'createdBy': currentUser.uid,
//   //       'date': selectedDate.value,
//   //       'subject': subjectController.text,
//   //       'description': descriptionController.text,
//   //       'meetingLink': meetingLinkController.text.isNotEmpty
//   //           ? meetingLinkController.text
//   //           : null,
//   //       'meetingVenue': meetingVenueController.text.isNotEmpty
//   //           ? meetingVenueController.text
//   //           : null,
//   //       'status': 'pending',
//   //       'createdAt': FieldValue.serverTimestamp(),
//   //     });
//   //
//   //     Get.snackbar('Success', 'Appointment scheduled successfully!');
//   //   } catch (e) {
//   //     Get.snackbar('Error', 'Failed to schedule appointment: $e');
//   //   }
//   // }
// }
