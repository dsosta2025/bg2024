import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookSlotController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isOrganization = false.obs;

  var selectedDate = "Date".obs;
  Future<void> addIndividualSlot({
    required String eventId,
    required String name,
    required String email,
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
        'date': selectedDate.value,
        'uploadId': uploadId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      CustomSnackbarr.show(
        Get.context!,
        "Success",
        "Individual slot booked successfully!",
      );
    } catch (e) {
      CustomSnackbarr.show(
        Get.context!,
        "Error",
        "Failed to book individual slot: $e",
        isError: true,
      );
    }
  }

  Future<void> addOrganizationSlot({
    required String eventId,
    required String name,
    required String email,
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
        'date': selectedDate.value,
        'companyName': companyName,
        'pax': pax,
        'timestamp': FieldValue.serverTimestamp(),
      });
      CustomSnackbarr.show(
        Get.context!,
        "Success",
        "Organization slot booked successfully!",
      );
    } catch (e) {
      CustomSnackbarr.show(
        Get.context!,
        "Error",
        "Failed to book organization slot: $e",
        isError: true,
      );
    }
  }
}
