import 'package:bima_gyaan/pages/home/models/sessionsListModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Sessioncontroller extends GetxController{

  var sessions = <Session>[].obs;
  var isLoadingSessions = false.obs;
  var hasErrorSessions = false.obs;
  var errorMessageSessions = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch sessions
  Future<void> fetchSessions(String documentId) async {


    print(documentId);
    print("!!!!!!!!!!!!!!!!!!!!");
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
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");


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
}