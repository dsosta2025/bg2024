import 'package:bima_gyaan/pages/home/models/sessionsListModel.dart';
import 'package:bima_gyaan/pages/home/models/speakerModel.dart';
import 'package:bima_gyaan/pages/home/models/sponserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

      // Debug: Print unsorted schedule times
      print("Before sorting:");
      schedules.value.forEach((schedule) {
        print(schedule.scheduleTime);
      });

      // Sort schedules by start time
      schedules.value.sort((a, b) {
        DateTime timeA = _extractStartTime(a.scheduleTime);
        DateTime timeB = _extractStartTime(b.scheduleTime);
        return timeA.compareTo(timeB);
      });

      // Debug: Print sorted schedule times
      print("After sorting:");
      schedules.value.forEach((schedule) {
        print(schedule.scheduleTime);
      });

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

// Helper function to extract the start time and convert it to DateTime
  DateTime _extractStartTime(String scheduleTime) {
    try {
      // 1. Split out only the start time (before " to ")
      String startTime = scheduleTime.split(' to ')[0].trim();

      // 2. Replace non-breaking/invisible spaces with a normal space
      //    but DO NOT remove all normal spaces.
      startTime =
          startTime.replaceAll('\u00A0', ' '); // common non-breaking space
      startTime = startTime.replaceAll(RegExp(r'[^\x20-\x7E]'), ' ');
      startTime = startTime.trim();

      // 3. Convert "13:15 PM" -> "01:15 PM" (12-hour format with space)
      //    or "09:15AM" -> "09:15 AM", etc.
      startTime = _fixTimeFormat(startTime);

      print("Sanitized start time: $startTime"); // e.g. "01:15 PM"

      // 4. Parse using a 12-hour format with space
      //    e.g., "hh:mm a" expects "09:15 AM", "01:15 PM", etc.
      return DateFormat('hh:mm a').parseStrict(startTime);
    } catch (e) {
      // Debug fallback
      print("Error parsing time: $scheduleTime, error: $e");
      return DateTime(1970); // Fallback for invalid time format
    }
  }

// Fix "13:15 PM" -> "01:15 PM" or "09:15AM" -> "09:15 AM"
  String _fixTimeFormat(String time) {
    // 1. Uppercase everything to simplify checks
    String upperTime = time.toUpperCase();

    // 2. Determine if it's AM or PM (if any)
    String suffix = '';
    if (upperTime.contains('PM')) {
      suffix = ' PM';
    } else if (upperTime.contains('AM')) {
      suffix = ' AM';
    }

    // 3. Remove AM/PM from the string, leaving just "13:15" or "09:15"
    upperTime = upperTime.replaceAll('AM', '').replaceAll('PM', '').trim();

    // 4. Split by ":" => ["13", "15"] or ["09", "15"]
    List<String> parts = upperTime.split(':');
    if (parts.length != 2) {
      // If it's malformed, return it as-is so the parser can fail safely
      return time;
    }

    int hour = int.parse(parts[0]); // e.g. 13 or 09
    String minute = parts[1]; // e.g. 15

    // 5. Convert 24-hour to 12-hour if > 12
    if (hour > 12) {
      hour -= 12; // e.g. 13 -> 1
    }

    // Rebuild the time: "01:15 PM"
    final finalTime = '${hour.toString().padLeft(2, '0')}:$minute$suffix';
    return finalTime;
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

      // Debug: Print unsorted times
      print("Before sorting (Speakers):");
      speakers.forEach((speaker) {
        print(speaker.time);
      });

      // Sort speakers by start time (reusing _extractStartTime)
      speakers.sort((a, b) {
        DateTime timeA = _extractStartTime(a.time);
        DateTime timeB = _extractStartTime(b.time);
        return timeA.compareTo(timeB);
      });

      // Debug: Print sorted times
      print("After sorting (Speakers):");
      speakers.forEach((speaker) {
        print(speaker.time);
      });

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

  // Future<void> fetchSpeakers(String eventId) async {
  //   isLoadingSpeakers.value = true;
  //   hasErrorSpeakers.value = false;
  //
  //   try {
  //     final querySnapshot = await _firestore
  //         .collection('speakers')
  //         .where('event_id', isEqualTo: eventId)
  //         .get();
  //
  //     // Map each document to the Speaker model
  //     speakers.value = querySnapshot.docs
  //         .map((doc) => Speaker.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //
  //     // Handle empty state
  //     if (speakers.isEmpty) {
  //       errorMessageSpeakers.value = 'No speakers available for this event.';
  //     }
  //   } catch (e) {
  //     hasErrorSpeakers.value = true;
  //     errorMessageSpeakers.value = 'Failed to fetch speakers: $e';
  //   } finally {
  //     isLoadingSpeakers.value = false;
  //   }
  // }

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
      sponsors.value =
          querySnapshot.docs.map((doc) => Sponsor.fromMap(doc.data())).toList();

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
// Future<void> fetchSchedules(String eventId) async {
//   isLoading.value = true;
//   hasError.value = false;
//
//   try {
//     final querySnapshot = await _firestore
//         .collection('schedules')
//         .where('event_id', isEqualTo: eventId)
//         .get();
//
//     // Map each document to the Schedule model
//     schedules.value = querySnapshot.docs
//         .map((doc) => Schedule.fromMap(doc.data()))
//         .toList();
//
//     // Handle empty state
//     if (schedules.isEmpty) {
//       errorMessage.value = 'No schedules available for this event.';
//     }
//   } catch (e) {
//     hasError.value = true;
//     errorMessage.value = 'Failed to fetch schedules: $e';
//   } finally {
//     isLoading.value = false;
//   }
// }

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
