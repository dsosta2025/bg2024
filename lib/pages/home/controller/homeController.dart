
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
