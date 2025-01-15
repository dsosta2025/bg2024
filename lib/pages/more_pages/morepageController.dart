import 'package:bima_gyaan/pages/events/model/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MorePageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Already existing reactive list for gallery
  var galleryDocIds = <String>[].obs;

  // NEW: Reactive list for presentations

  // Already existing method for gallery
  Future<void> fetchGalleryDocIds() async {
    try {
      final querySnapshot = await _firestore.collection('gallery').get();
      galleryDocIds.value = querySnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print("Error fetching gallery doc IDs: $e");
    }
  }

  // NEW: Fetch presentation document IDs
  // Future<void> fetchPresentationDocIds() async {
  //   try {
  //     final querySnapshot = await _firestore.collection('presentations').get();
  //     presentationDocIds.value = querySnapshot.docs.map((doc) => doc.id).toList();
  //   } catch (e) {
  //     print("Error fetching presentation doc IDs: $e");
  //   }
  // }

  var presentationDocIds = <String>[].obs;

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

      for (int i = 0; i < eventsList.length; i++) {
        presentationDocIds.add(eventsList.value[i].year);
      }
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

  DateTime _parseDate(String dateString) {
    try {
      return DateFormat('d/M/yyyy').parse(dateString);
    } catch (e) {
      return DateTime.now(); // Return a default value if parsing fails
    }
  }
}
