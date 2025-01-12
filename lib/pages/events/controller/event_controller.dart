import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/event_model.dart';
class EventController extends GetxController {
  var eventsList = <Event>[].obs; // Observable list to hold events
  var isLoading = false.obs; // Observable for loading state
  var hasError = false.obs; // Observable for error state
  var errorMessage = ''.obs; // Observable for error message
  // Fetch all events from the 'events' collection
  Future<void> fetchAllEvents() async {
    isLoading.value = true;
    hasError.value = false;
    eventsList.value = [];
    try {
      final querySnapshot =
      await FirebaseFirestore.instance.collection('events').get();

      eventsList.value = querySnapshot.docs
          .map((doc) => Event.fromDocument(doc.data()))
          .toList();

      // Sort the eventsList by pickupDate in descending order
      eventsList.sort((a, b) {
        DateTime dateA = _parseDate(a.pickupDate);
        DateTime dateB = _parseDate(b.pickupDate);
        return dateB.compareTo(dateA); // Descending order
      });

      if (eventsList.isEmpty) {
        errorMessage.value = "No events available.";
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = "Error fetching events: $e";
    } finally {
      isLoading.value = false;
    }
  }

// Helper method to parse date
//   DateTime _parseDate(String dateString) {
//     try {
//       return DateFormat('d/M/yyyy').parse(dateString);
//     } catch (e) {
//       return DateTime.now(); // Return a default value if parsing fails
//     }
//   }

  // Future<void> fetchAllEvents() async {
  //   isLoading.value = true;
  //   hasError.value = false;
  //   eventsList.value = [];
  //   try {
  //     final querySnapshot =
  //     await FirebaseFirestore.instance.collection('events').get();
  //
  //     eventsList.value = querySnapshot.docs
  //         .map((doc) => Event.fromDocument(doc.data()))
  //         .toList();
  //
  //     // Sort the eventsList by pickupDate
  //     eventsList.sort((a, b) {
  //       DateTime dateA = _parseDate(a.pickupDate);
  //       DateTime dateB = _parseDate(b.pickupDate);
  //       return dateA.compareTo(dateB); // Ascending order
  //     });
  //
  //     if (eventsList.isEmpty) {
  //       errorMessage.value = "No events available.";
  //     }
  //   } catch (e) {
  //     hasError.value = true;
  //     errorMessage.value = "Error fetching events: $e";
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

// Helper method to parse date
  DateTime _parseDate(String dateString) {
    try {
      return DateFormat('d/M/yyyy').parse(dateString);
    } catch (e) {
      return DateTime.now(); // Return a default value if parsing fails
    }
  }

  // Future<void> fetchAllEvents() async {
  //   isLoading.value = true;
  //   hasError.value = false;
  //   eventsList.value = [];
  //   try {
  //     final querySnapshot =
  //         await FirebaseFirestore.instance.collection('events').get();
  //     eventsList.value = querySnapshot.docs
  //         .map((doc) => Event.fromDocument(doc.data()))
  //         .toList();
  //     if (eventsList.isEmpty) {
  //       errorMessage.value = "No events available.";
  //     }
  //   } catch (e) {
  //     hasError.value = true;
  //     errorMessage.value = "Error fetching events: $e";
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  @override
  void onInit() {
    super.onInit();
    fetchAllEvents();
  }
}
