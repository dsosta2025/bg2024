import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuySponsorController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var selectedDate = "Date".obs;

  Future<void> submitSponsorData({
    required String sponsorType,
    required String eventId,
    required String name,
    required String email,
    required String companyName,
    required String gstNumber,
  }) async {
    try {
      await _firestore.collection('sponsor_requests').add({
        'sponsorType': sponsorType,
        'eventId': eventId,
        'name': name,
        'email': email,
        'companyName': companyName,
        'gstNumber': gstNumber,
        'date': selectedDate.value,
        'timestamp': FieldValue.serverTimestamp(),
      });

      CustomSnackbarr.show(
        Get.context!,
        "Success",
        "Sponsorship request submitted successfully!",
      );
    } catch (e) {
      CustomSnackbarr.show(
        Get.context!,
        "Error",
        "Failed to submit sponsorship request: $e",
        isError: true,
      );
    }
  }
}
