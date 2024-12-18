import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookSlotController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addIndividualSlot({
    required String eventId,
    required String name,
    required String email,
    required String date,
    required String uploadId,
  }) async {
    try {
      await _firestore
          .collection('booked_slots')
          .doc(eventId)
          .collection('individual_book_slots')
          .add({
        'name': name,
        'email': email,
        'date': date,
        'uploadId': uploadId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Get.snackbar("Success", "Individual slot booked successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to book individual slot: $e");
    }
  }

  Future<void> addOrganizationSlot({
    required String eventId,
    required String name,
    required String email,
    required String date,
    required String companyName,
    required String pax,
  }) async {
    try {
      await _firestore
          .collection('booked_slots')
          .doc(eventId)
          .collection('organization_book_slots')
          .add({
        'name': name,
        'email': email,
        'date': date,
        'companyName': companyName,
        'pax': pax,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Get.snackbar("Success", "Organization slot booked successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to book organization slot: $e");
    }
  }
}
