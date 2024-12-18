import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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

  @override
  void onInit() {
    super.onInit();
    fetchAllEvents();
  }
}
