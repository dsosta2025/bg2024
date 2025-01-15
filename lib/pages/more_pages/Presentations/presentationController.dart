import 'package:bima_gyaan/pages/home/models/speakerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Presentationcontroller extends GetxController{
  var speakers = <Speaker>[].obs;
  var isLoadingSpeakers = false.obs;
  var hasErrorSpeakers = false.obs;
  var errorMessageSpeakers = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool containsBreak(String input) {
    return input.toLowerCase().contains('break');
  }
  // Function to fetch speakers based on event ID
  Future<void> fetchSpeakers(String eventId) async {
    isLoadingSpeakers.value = true;
    hasErrorSpeakers.value = false;

    try {
      final querySnapshot = await _firestore
          .collection('speakers')
          .where('event_id', isEqualTo: eventId)
          .get();

      // Filter and map documents to the Speaker model
      speakers.value = querySnapshot.docs
          .map((doc) => Speaker.fromMap(doc.data() as Map<String, dynamic>))
          .where((speaker) => !containsBreak(speaker.sessionName)) // Exclude sessions with 'break' in the name
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
  // Function to fetch schedules based on event ID

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
}