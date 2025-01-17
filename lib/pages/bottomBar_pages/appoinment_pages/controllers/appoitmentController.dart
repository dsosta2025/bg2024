import 'package:bima_gyaan/pages/bottomBar_pages/appoinment_pages/models/appoitmentModel.dart';
import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  RxList<AppointmentModel> appointments = <AppointmentModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchUserAppointments();
    super.onInit();
  }

  Future<void> fetchUserAppointments() async {
    try {
      isLoading(true);
      errorMessage('');

      String currentUserId = auth.currentUser?.uid ?? '';

      if (currentUserId.isEmpty) {
        errorMessage('No user is currently signed in.');
        return;
      }

      final querySnapshot = await _firestore
          .collection('appointments')
          .where('participants', arrayContains: currentUserId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        errorMessage('No appointments found for the current user.');
        hasError.value = false;
        return;
      } else {
        hasError.value = false;
        List<AppointmentModel> appointmentList = [];
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> appointmentData =
              doc.data() as Map<String, dynamic>;
          List<String> participants =
              List<String>.from(appointmentData['participants'] ?? []);

          String oppositeUserId = participants.firstWhere(
            (id) => id != currentUserId,
            orElse: () =>
                '', // Provide a fallback value (empty string) if no opposite user is found
          );
          String? oppositeUserName;
          String? oppositeUserImage;

          if (oppositeUserId != null) {
            // Fetch opposite user details
            final userDoc =
                await _firestore.collection('users').doc(oppositeUserId).get();
            if (userDoc.exists) {
              oppositeUserName = userDoc['fullName'];
              oppositeUserImage = userDoc['imageUrl'];
            }
          }

          // Create AppointmentModel with additional data
          appointmentList.add(
            AppointmentModel.fromMap({
              ...appointmentData,
              'oppositeUserName': oppositeUserName,
              'oppositeUserImage': oppositeUserImage,
            }),
          );
        }

        appointments.value = appointmentList;
      }
    } catch (e) {
      print(e);
      hasError.value  = true;
      errorMessage('Failed to fetch appointments: $e');
    } finally {
      // hasError.value  = true;
      isLoading(false);
    }
  }

  Future<void> updateAppointmentStatus(
      String appointmentId, String newStatus) async {
    try {
      // Update Firestore
      await _firestore.collection('appointments').doc(appointmentId).update({
        'status': newStatus,
      });

      // Update locally by replacing the object
      final index = appointments.indexWhere((a) => a.id == appointmentId);
      if (index != -1) {
        final updatedAppointment =
            appointments[index].copyWith(status: newStatus);
        appointments[index] = updatedAppointment;
        appointments.refresh();
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to update appointment status: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<void> deleteAppointment(String appointmentId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Delete Firestore document
      await _firestore.collection('appointments').doc(appointmentId).delete();

      // Update locally by removing the appointment from the list
      appointments.removeWhere((appointment) => appointment.id == appointmentId);

      isLoading.value = false;

      // Show success snackbar
      CustomSnackbarr.show(
          Get.context!, 'Success', 'Appointment deleted successfully!');
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to delete appointment: $e';

      // Show error snackbar
      CustomSnackbarr.show(Get.context!, 'Error', errorMessage.value,
          isError: true);
    }
  }
}
