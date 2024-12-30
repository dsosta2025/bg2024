import 'package:bima_gyaan/pages/home/models/sessionsListModel.dart';
import 'package:bima_gyaan/pages/home/models/speakerModel.dart';
import 'package:bima_gyaan/pages/home/models/sponserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/homeModel.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var schedules = <Schedule>[].obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Function to fetch schedules based on event ID
  Future<void> fetchSchedules(String eventId) async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final querySnapshot = await _firestore
          .collection('schedules')
          .where('event_id', isEqualTo: eventId)
          .get();

      // Map each document to the Schedule model
      schedules.value = querySnapshot.docs
          .map((doc) => Schedule.fromMap(doc.data()))
          .toList();

      // Handle empty state
      if (schedules.isEmpty) {
        errorMessage.value = 'No schedules available for this event.';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to fetch schedules: $e';
    } finally {
      isLoading.value = false;
    }
  }

  var speakers = <Speaker>[].obs;
  var isLoadingSpeakers = false.obs;
  var hasErrorSpeakers = false.obs;
  var errorMessageSpeakers = ''.obs;

  // Function to fetch speakers based on event ID
  Future<void> fetchSpeakers(String eventId) async {
    isLoadingSpeakers.value = true;
    hasErrorSpeakers.value = false;

    try {
      final querySnapshot = await _firestore
          .collection('speakers')
          .where('event_id', isEqualTo: eventId)
          .get();

      // Map each document to the Speaker model
      speakers.value = querySnapshot.docs
          .map((doc) => Speaker.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Handle empty state
      if (speakers.isEmpty) {
        errorMessageSpeakers.value = 'No speakers available for this event.';
      }
    } catch (e) {
      hasErrorSpeakers.value = true;
      errorMessageSpeakers.value = 'Failed to fetch speakers: $e';
    } finally {
      isLoadingSpeakers.value = false;
    }
  }

  var sessions = <Session>[].obs;
  var isLoadingSessions = false.obs;
  var hasErrorSessions = false.obs;
  var errorMessageSessions = ''.obs;

  // Function to fetch sessions
  Future<void> fetchSessions(String documentId) async {
    isLoadingSessions.value = true;
    hasErrorSessions.value = false;
    sessions.value = [];
    try {
      final docSnapshot =
          await _firestore.collection('sessions').doc(documentId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final sessionList = data['Sessions'] as List<dynamic>;
        // Map each session in the list to the Session model
        sessions.value = sessionList
            .map((session) => Session.fromMap(session as Map<String, dynamic>))
            .toList();

        print(sessions.length);
        if (sessions.isEmpty) {

          errorMessageSessions.value = 'No sessions available.';
        }
      } else {
        errorMessageSessions.value = 'Document does not exist.';
        sessions.clear();
      }
    } catch (e) {
      hasErrorSessions.value = true;
      errorMessageSessions.value = 'Failed to fetch sessions: $e';
    } finally {
      isLoadingSessions.value = false;
    }
  }



  var sponsors = <Sponsor>[].obs;
  var isSponsorLoading = false.obs;
  var hasSponsorError = false.obs;
  var sponsorErrorMessage = ''.obs;


  Future<void> fetchSponsors(String eventId) async {
    isSponsorLoading.value = true;
    hasSponsorError.value = false;

    try {
      final querySnapshot = await _firestore
          .collection('sponsors')
          .where('event_id', isEqualTo: eventId)
          .get();

      // Map each document to the Sponsor model
      sponsors.value = querySnapshot.docs
          .map((doc) => Sponsor.fromMap(doc.data()))
          .toList();

      // Handle empty state
      if (sponsors.isEmpty) {
        sponsorErrorMessage.value = 'No sponsors available for this event.';
      }
    } catch (e) {
      hasSponsorError.value = true;
      sponsorErrorMessage.value = 'Failed to fetch sponsors: $e';
    } finally {
      isSponsorLoading.value = false;
    }
  }
}

// class HomeController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   var schedules = <Schedule>[].obs;
//   // Function to fetch schedules based on event ID
//   Future<void> fetchSchedules(String eventId) async {
//     print(eventId);
//     try {
//       final querySnapshot = await _firestore
//           .collection('schedules')
//           .where('event_id', isEqualTo: eventId)
//           .get();
//
//       // Map each document to the Schedule model
//       schedules.value = querySnapshot.docs
//           .map((doc) => Schedule.fromMap(doc.data()))
//           .toList();
//       print(schedules.length);
//       print("////////////////////////////////////");
//     } catch (e) {
//       print("Error fetching schedules: $e");
//     }
//   }
//
//
// }
