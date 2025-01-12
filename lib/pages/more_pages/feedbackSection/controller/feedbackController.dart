import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackController extends GetxController {
  RxString question1Answer = ''.obs;
  RxString question2Answer = ''.obs;
  RxList<String> question3Answers = <String>[].obs;
  RxString question4Answer = ''.obs;
  RxString question5Answer = ''.obs;
  RxList<String> question6Answers = <String>[].obs;
  RxList<String> question7Answers = <String>[].obs;
  RxString question8Answer = ''.obs;
  RxString question9Answer = ''.obs;
  RxString question10Answer = ''.obs;
  RxString question11Answer = ''.obs;
  RxString question12Answer = ''.obs;
  RxString question13Answer = ''.obs;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> submitFeedback(String eventId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        errorMessage.value = 'User not logged in!';
        return;
      }

      await FirebaseFirestore.instance.collection('feedbackData').add({
        'question1': question1Answer.value,
        'question2': question2Answer.value,
        'question3': question3Answers.toList(),
        'question4': question4Answer.value,
        'question5': question5Answer.value,
        'question6': question6Answers.toList(),
        'question7': question7Answers.toList(),
        'question8': question8Answer.value,
        'question9': question9Answer.value,
        'question10': question10Answer.value,
        'question11': question11Answer.value,
        'question12': question12Answer.value,
        'question13': question13Answer.value,
        'eventId': eventId,
        'userId': userId,
        'submittedAt': DateTime.now(),
      });

      resetFeedbackForm();
    } catch (e) {
      errorMessage.value = 'Failed to submit feedback: $e';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    resetFeedbackForm();
  }
  void resetFeedbackForm() {
    question1Answer.value = '';
    question2Answer.value = '';
    question3Answers.clear();
    question4Answer.value = '';
    question5Answer.value = '';
    question6Answers.clear();
    question7Answers.clear();
    question8Answer.value = '';
    question9Answer.value = '';
    question10Answer.value = '';
    question11Answer.value = '';
    question12Answer.value = '';
    question13Answer.value = '';
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    resetFeedbackForm();
  }
}


// class FeedbackController extends GetxController {
//   RxString question1Answer = ''.obs;
//   RxString question2Answer = ''.obs;
//   RxList<String> question3Answers = <String>[].obs;
//
//   // Loading and error state
//   RxBool isLoading = false.obs;
//   RxString errorMessage = ''.obs;
//
//   // Submit feedback to Firestore
//   Future<void> submitFeedback(String eventId) async {
//     isLoading.value = true; // Start loading
//     errorMessage.value = ''; // Reset error message
//
//     try {
//       // Get the current user ID
//       final userId = FirebaseAuth.instance.currentUser?.uid;
//
//       if (userId == null) {
//         errorMessage.value = 'User not logged in!';
//         CustomSnackbarr.show(Get.context!, 'Error', errorMessage.value,
//             isError: true);
//         return;
//       }
//
//       // Submit feedback to Firestore
//       await FirebaseFirestore.instance.collection('feedbackData').add({
//         'question1': question1Answer.value, // Answer to Question 1
//         'question2': question2Answer.value, // Answer to Question 2
//         'question3': question3Answers.toList(), // Answers to Question 3
//         'eventId': eventId, // Event ID
//         'userId': userId, // User ID
//         'submittedAt': DateTime.now(), // Timestamp
//       });
//
//       resetFeedbackForm();
//       CustomSnackbarr.show(
//         Get.context!,
//         'Success',
//         'Feedback submitted successfully!',
//         isError: false,
//       );
//     } catch (e) {
//       errorMessage.value = 'Failed to submit feedback: $e';
//       CustomSnackbarr.show(Get.context!, 'Error', errorMessage.value,
//           isError: true);
//     } finally {
//       isLoading.value = false; // Stop loading
//     }
//   }
//
//   void resetFeedbackForm() {
//     question1Answer.value = '';
//     question2Answer.value = '';
//     question3Answers.clear();
//   }
// }
