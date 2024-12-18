import 'package:bima_gyaan/pages/events/screens/event_screen.dart';
import 'package:bima_gyaan/widgets/customesnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Show success message
      CustomSnackbar.showSuccess('Login successful!');

      // Navigate to Home Screen
      Get.offAll(() =>  EventScreen());
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
    } catch (e) {
      CustomSnackbar.showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided for that user.';
        break;
      case 'invalid-email':
        message = 'Invalid email format.';
        break;
      case 'user-disabled':
        message = 'This user account has been disabled.';
        break;
      default:
        message = e.message ?? 'An unknown error occurred.';
    }
    CustomSnackbar.showError(message);
  }
}
