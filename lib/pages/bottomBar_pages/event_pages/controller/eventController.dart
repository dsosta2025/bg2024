import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EventsController extends GetxController {
  var eventsList = <Map<String, String>>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var selectedEventName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEventsByDate();
  }

  Future<void> fetchEventsByDate() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('events_date').get();

      final fetchedEvents = querySnapshot.docs.expand((doc) {
        final dataList = (doc['Date'] as List<dynamic>)
            .map((event) => {
                  'date': event['date']?.toString() ?? '', // Handle nulls
                  'name': event['name']?.toString() ?? '', // Handle nulls
                })
            .toList();
        return dataList;
      }).toList();

      // Sort events by date
      fetchedEvents.sort((a, b) {
        DateTime dateA = DateFormat('dd/MM/yyyy').parse(a['date']!);
        DateTime dateB = DateFormat('dd/MM/yyyy').parse(b['date']!);
        return dateA.compareTo(dateB);
      });

      eventsList.value = fetchedEvents;
    } catch (e) {
      errorMessage.value = 'Error fetching events: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void findEventByDate(String selectedDate) {
    try {
      final event = eventsList.firstWhere(
        (e) => e['date'] == selectedDate,
        orElse: () => {'name': 'No Event on this day'},
      );
      selectedEventName.value = event['name']!;
    } catch (e) {
      selectedEventName.value = 'Error finding event: $e';
    }
  }
}
