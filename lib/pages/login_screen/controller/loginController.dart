import 'package:bima_gyaan/pages/events/screens/event_screen.dart';
import 'package:bima_gyaan/widgets/customesnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoading = false.obs;

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Show success message
      CustomSnackbar.showSuccess('Login successful!');

      // Navigate to Home Screen
      Get.offAll(() => EventScreen());
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

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // Attempt to get the currently authenticated user
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Return if the user cancels the sign-in process
      if (googleUser == null) {
        CustomSnackbar.showError("Google sign-in canceled.");
        return;
      }

      // Authenticate with Google
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Get the credentials to sign in with Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      // Show success message
      CustomSnackbar.showSuccess(
          "Welcome, ${userCredential.user?.displayName ?? 'User'}!");

      // Navigate to Home Screen
      Get.offAll(() => EventScreen());
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);

    } catch (error) {
      print(error);
      CustomSnackbar.showError("Error during Google Sign-In: $error");
    } finally {
      isLoading.value = false;
    }
  }
}

// class LoginController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   var isLoading = false.obs;
//
//   Future<void> login({required String email, required String password}) async {
//     try {
//       isLoading.value = true;
//
//       // Sign in with email and password
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//
//       // Show success message
//       CustomSnackbar.showSuccess('Login successful!');
//
//       // Navigate to Home Screen
//       Get.offAll(() =>  EventScreen());
//     } on FirebaseAuthException catch (e) {
//       _handleFirebaseAuthError(e);
//     } catch (e) {
//       CustomSnackbar.showError('Something went wrong. Please try again.');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void _handleFirebaseAuthError(FirebaseAuthException e) {
//     String message;
//     switch (e.code) {
//       case 'user-not-found':
//         message = 'No user found for that email.';
//         break;
//       case 'wrong-password':
//         message = 'Wrong password provided for that user.';
//         break;
//       case 'invalid-email':
//         message = 'Invalid email format.';
//         break;
//       case 'user-disabled':
//         message = 'This user account has been disabled.';
//         break;
//       default:
//         message = e.message ?? 'An unknown error occurred.';
//     }
//     CustomSnackbar.showError(message);
//   }
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   Future<User?> signInWithGoogle() async {
//     try {
//       // Attempt to get the currently authenticated user
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//       // Return if the user cancels the sign-in process
//       if (googleUser == null) {
//         print("Google sign-in canceled.");
//         return null;
//       }
//
//       // Authenticate with Google
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // Get the credentials to sign in with Firebase
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Sign in to Firebase
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//
//       print("User signed in: ${userCredential.user?.displayName}");
//       CustomSnackbar.showSuccess('Login successful!');
//
//       // Navigate to Home Screen
//       Get.offAll(() =>  EventScreen());
//       return userCredential.user;
//     } catch (error) {
//       print("Error during Google Sign-In: $error");
//       return null;
//     }
//   }
// }
