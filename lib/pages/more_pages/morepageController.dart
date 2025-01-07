import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MorePageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Already existing reactive list for gallery
  var galleryDocIds = <String>[].obs;

  // NEW: Reactive list for presentations
  var presentationDocIds = <String>[].obs;

  // Already existing method for gallery
  Future<void> fetchGalleryDocIds() async {
    try {
      final querySnapshot = await _firestore.collection('gallery').get();
      galleryDocIds.value = querySnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print("Error fetching gallery doc IDs: $e");
    }
  }

  // NEW: Fetch presentation document IDs
  Future<void> fetchPresentationDocIds() async {
    try {
      final querySnapshot = await _firestore.collection('presentations').get();
      presentationDocIds.value = querySnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print("Error fetching presentation doc IDs: $e");
    }
  }
}
