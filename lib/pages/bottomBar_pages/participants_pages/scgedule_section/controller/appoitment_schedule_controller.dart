import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Auth
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppointmentScheduleController extends GetxController {
  // Define the controller variables for each input field
  var subjectController = TextEditingController();
  var descriptionController = TextEditingController();
  var meetingLinkController = TextEditingController();
  var meetingVenueController = TextEditingController();
  var selectedDate = "Date".obs;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to create an appointment with only two participants
  Future<void> createAppointment(String opponentUserId) async {
    try {
      // Get the current user's ID
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        Get.snackbar('Error', 'No user is currently signed in');
        return;
      }

      // Create the participants list with currentUser and opponentUser
      List<String> participants = [currentUser.uid, opponentUserId];

      // Appointment data to be stored in Firestore
      await _firestore.collection('appointments').add({
        'participants': participants,
        'createdBy': currentUser.uid,
        'date': selectedDate.value,
        'subject': subjectController.text,
        'description': descriptionController.text,
        'meetingLink': meetingLinkController.text.isNotEmpty
            ? meetingLinkController.text
            : null,
        'meetingVenue': meetingVenueController.text.isNotEmpty
            ? meetingVenueController.text
            : null,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Success', 'Appointment scheduled successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to schedule appointment: $e');
    }
  }
}
