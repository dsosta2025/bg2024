import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../events/screens/event_screen.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  Future<void> signUp(
      {required String fullName,
      required String email,
      required String phone,
      required String password,
      required String organization,
      required String designation,
      required BuildContext context}) async {
    try {
      isLoading.value = true;

      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      print('User created with UID: $uid');

      Map<String, dynamic> userData = {
        'uid': uid,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'organization': organization,
        'designation': designation,
        'createdAt': FieldValue.serverTimestamp(),
        'imageUrl': '',
        'chatRoomsIdList': []
      };

      await _firestore.collection('users').doc(uid).set(userData).then((_) {
        print('User data successfully written to Firestore');
      });

      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      Get.snackbar(
        'Authentication Error',
        e.message ?? 'An authentication error occurred.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      Get.snackbar(
        'Firestore Error',
        e.message ?? 'An error occurred while saving user data.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      print('General Exception: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
