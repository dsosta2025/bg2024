import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observables for managing states
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isSuccess = false.obs;

  // Method for Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    // Reset states before starting
    isLoading(true);
    errorMessage('');
    isSuccess(false);

    try {
      // Send password reset email via Firebase
      await _auth.sendPasswordResetEmail(email: email);

      // Success state
      isSuccess(true);
      CustomSnackbarr.show(
        Get.context!,
        'Success',
        'Password reset email sent. Please check your inbox!',
      );
    } catch (e) {
      // Error handling
      errorMessage('Failed to send password reset email: ${e.toString()}');
      CustomSnackbarr.show(Get.context!, 'Error', errorMessage.value, isError: true);
    } finally {
      isLoading(false);
    }
  }
}
