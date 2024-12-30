import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observables
  var questions = [].obs;

  // Fetch questions for the current user
  void fetchQuestions() async {
    try {
      // Get current user's ID
      String userId = _auth.currentUser?.uid ?? 'unknown_user';

      // Reference to the document
      DocumentReference userDoc = _firestore.collection('questions').doc(userId);

      // Listen to real-time updates
      userDoc.snapshots().listen((docSnapshot) {
        if (docSnapshot.exists) {
          // Update the questions observable
          var data = docSnapshot.data() as Map<String, dynamic>;
          questions.value = data['questions'] ?? [];
        } else {
          questions.value = [];
        }
      });
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  // Add a question to Firestore
  Future<void> addQuestion(String questionText, String eventId) async {
    try {
      // Get current user's ID
      String userId = _auth.currentUser?.uid ?? 'unknown_user';

      // Reference to the document
      DocumentReference userDoc = _firestore.collection('questions').doc(userId);

      // Check if the document exists
      DocumentSnapshot docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        // Create the document with eventId if it doesn't exist
        await userDoc.set({
          'eventId': eventId,
          'questions': [],
        });
      }

      // Add the new question to the questions list
      await userDoc.update({
        'questions': FieldValue.arrayUnion([
          {
            'text': questionText,
            'timestamp':  Timestamp.now(), // Correct Firestore timestamp usage
          }
        ]),
      });
    } catch (e) {
      print('Error adding question: $e');
    }
  }
}
