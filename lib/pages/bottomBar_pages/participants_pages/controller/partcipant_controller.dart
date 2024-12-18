import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/models/user_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ParticipantsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }
  // Method to fetch users, excluding the current user
  void fetchUsers() async {
    try {
      isLoading(true);
      errorMessage('');

      // Get the current user's ID
      String currentUserId = auth.currentUser?.uid ?? '';

      if (currentUserId.isEmpty) {
        errorMessage('No user is currently signed in.');
        return;
      }

      // Fetch users from Firestore, excluding the current user
      final querySnapshot = await _firestore.collection('users')
          .where('uid', isNotEqualTo: currentUserId) // Exclude the current user
          .get();

      if (querySnapshot.docs.isEmpty) {
        errorMessage('No participants found.');
      } else {
        users.value = querySnapshot.docs
            .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (error) {
      errorMessage('Failed to fetch users: $error');
    } finally {
      isLoading(false);
    }
  }
}
