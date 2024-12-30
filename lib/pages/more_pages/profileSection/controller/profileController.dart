import 'dart:io';

import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/models/user_model.dart';
import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  final Rx<UserModel?> currentUser =
      Rx<UserModel?>(null); // To store the current user
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance

  Future<void> fetchCurrentUser() async {
    try {
      isLoading(true);
      errorMessage('');
      // Get the current user's UID from Firebase Auth
      String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (currentUserId.isEmpty) {
        errorMessage('No user is currently signed in.');
        return;
      }

      // Fetch the user document using the UID as the document ID
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(currentUserId).get();
      if (!userDoc.exists) {
        errorMessage('User not found in the database.');
      } else {
        currentUser.value = UserModel.fromMap(userDoc.data()!);
      }
    } catch (error) {
      errorMessage('Failed to fetch user: $error');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCurrentUser();
  }
  Rx<File?> selectedImage = Rx<File?>(null);

  // Method to pick image
  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        selectedImage(File(pickedFile.path));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  // Method to upload image to Firebase Storage
  // Future<String?> uploadImageToStorage(String userId) async {
  //   try {
  //     if (selectedImage.value != null) {
  //       final storageRef = FirebaseStorage.instance
  //           .ref()
  //           .child('profile_images/$userId.jpg');
  //       await storageRef.putFile(selectedImage.value!);
  //       return await storageRef.getDownloadURL();
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to upload image: $e',
  //         snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  //   }
  //   return null;
  // }

  // Updated editProfile method
  RxBool isEditing = false.obs;
  RxString editErrorMessage = ''.obs;

  Future<void> editProfile({
    required String fullName,
    required String email,
    required String phone,
    required String designation,
    required String organization,
  }) async {
    try {
      isEditing(true); // Set the editing state to true
      editErrorMessage(''); // Clear any previous error messages

      final userId = auth.currentUser?.uid;
      if (userId == null) {
        editErrorMessage('No user is currently signed in.');
        // Show the custom error snackbar
        CustomSnackbarr.show(Get.context!, 'Error', 'No user is currently signed in.', isError: true);
        return;
      }

      print('object');
      String? imageUrl = currentUser.value?.imageUrl;

      // If a new image is selected, upload it
      // if (selectedImage.value != null) {
      //   imageUrl = await uploadImageToStorage(userId);
      // }

      final updatedData = {
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'designation': designation,
        'organization': organization,
        'imageUrl': imageUrl,
      };

      // Update Firestore
      await _firestore.collection('users').doc(userId).update(updatedData);

      // Update local state
      currentUser.value = UserModel(
        uid: userId,
        fullName: fullName,
        email: email,
        phone: phone,
        designation: designation,
        organization: organization,
        imageUrl: imageUrl ?? '',
        chatRoomsIdList: currentUser.value?.chatRoomsIdList ?? [],
      );
      print("sdsadasdasdsssssssss");
      // Show the custom success snackbar
      CustomSnackbarr.show(Get.context!, 'Success', 'Profile updated successfully.',
          isError: false);
    } catch (e) {
      editErrorMessage('Failed to update profile: $e');
      // Show the custom error snackbar
      CustomSnackbarr.show(Get.context!, 'Error', e.toString(), isError: true);
    } finally {
      print("sszdsdasdasdasdasdas");
      isEditing(false); // Reset the editing state
    }

// Helper method to show a confirmation dialog


  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text('Confirm Account Deletion'),
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('Delete'),
          ),
        ],
      ),
    ) ?? false; // Defaults to false if the dialog is dismissed
  }


  Future<void> deleteAccount() async {
    try {
      final userId = auth.currentUser?.uid;

      if (userId == null) {
        // If no user is signed in, show an error snackbar
        CustomSnackbarr.show(Get.context!, 'Error', 'No user is currently signed in.', isError: true);
        return;
      }

      // Prompt the user for confirmation before deleting
      bool confirmDelete = await _showDeleteConfirmationDialog();

      if (!confirmDelete) {
        // If user cancels the deletion, show a cancellation message
        CustomSnackbarr.show(Get.context!, 'Cancelled', 'Account deletion cancelled.', isError: false);
        return;
      }

      // Step 1: Delete user's data from Firestore
      await _firestore.collection('users').doc(userId).delete();
      print('User data deleted from Firestore.');

      // Step 2: Delete the user from Firebase Authentication
      await auth.currentUser?.delete();
      print('User deleted from Firebase Authentication.');

      // Step 3: Show success message
      CustomSnackbarr.show(Get.context!, 'Success', 'Account deleted successfully.', isError: false);

    } catch (e) {
      print('Error deleting account: $e');
      // Show error message if something goes wrong
      CustomSnackbarr.show(Get.context!, 'Error', 'Failed to delete account: $e', isError: true);
    }
  }


  Future<void> logout() async {
    try {
      // Perform logout
      await auth.signOut();

      // Navigate to Login Screen
      Get.offAll(() => const LoginScreen());

      // Show custom success snackbar
      CustomSnackbarr.show(Get.context!, 'Success', 'Logged out successfully!');
    } catch (e) {
      // Show custom error snackbar
      CustomSnackbarr.show(
        Get.context!,
        'Error',
        'Failed to log out: ${e.toString()}',
        isError: true,
      );
    }
  }

// Future<void> editProfile({
  //   required String fullName,
  //   required String email,
  //   required String phone,
  //   required String designation,
  //   required String organization,
  //   required String imageUrl,
  // }) async {
  //   try {
  //     // Show loading state
  //     isLoading(true);
  //     errorMessage('');
  //
  //     // Validate current user
  //     final userId = auth.currentUser?.uid;
  //     if (userId == null || userId.isEmpty) {
  //       errorMessage('No user is currently signed in.');
  //       return;
  //     }
  //
  //     // Prepare updated user data
  //     final updatedData = {
  //       'fullName': fullName,
  //       'email': email,
  //       'phone': phone,
  //       'designation': designation,
  //       'organization': organization,
  //       'imageUrl': imageUrl,
  //     };
  //
  //     // Update Firestore
  //     await _firestore.collection('users').doc(userId).update(updatedData);
  //
  //     // Update local current user object
  //     currentUser.value = UserModel(
  //       uid: userId,
  //       fullName: fullName,
  //       email: email,
  //       phone: phone,
  //       designation: designation,
  //       organization: organization,
  //       imageUrl: imageUrl,
  //       chatRoomsIdList: currentUser.value?.chatRoomsIdList ?? [],
  //     );
  //
  //     Get.snackbar('Success', 'Profile updated successfully.',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white);
  //   } catch (error) {
  //     errorMessage('Failed to update profile: $error');
  //     Get.snackbar('Error', error.toString(),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   } finally {
  //     // Hide loading state
  //     isLoading(false);
  //   }
  // }

}
