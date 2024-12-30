import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackController extends GetxController {
  RxString question1Answer = ''.obs;
  RxString question2Answer = ''.obs;
  RxList<String> question3Answers = <String>[].obs;

  // Loading and error state
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // Submit feedback to Firestore
  Future<void> submitFeedback(String eventId) async {
    isLoading.value = true; // Start loading
    errorMessage.value = ''; // Reset error message

    try {
      // Get the current user ID
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        errorMessage.value = 'User not logged in!';
        CustomSnackbarr.show(Get.context!, 'Error', errorMessage.value,
            isError: true);
        return;
      }

      // Submit feedback to Firestore
      await FirebaseFirestore.instance.collection('feedbackData').add({
        'question1': question1Answer.value, // Answer to Question 1
        'question2': question2Answer.value, // Answer to Question 2
        'question3': question3Answers.toList(), // Answers to Question 3
        'eventId': eventId, // Event ID
        'userId': userId, // User ID
        'submittedAt': DateTime.now(), // Timestamp
      });

      resetFeedbackForm();
      CustomSnackbarr.show(
        Get.context!,
        'Success',
        'Feedback submitted successfully!',
        isError: false,
      );
    } catch (e) {
      errorMessage.value = 'Failed to submit feedback: $e';
      CustomSnackbarr.show(Get.context!, 'Error', errorMessage.value,
          isError: true);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  void resetFeedbackForm() {
    question1Answer.value = '';
    question2Answer.value = '';
    question3Answers.clear();
  }
}
