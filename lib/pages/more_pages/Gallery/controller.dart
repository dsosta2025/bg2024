import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// -----------------------------------------------------
// MODEL
// -----------------------------------------------------
class MediaModel {
  final List<String> photos;
  final List<String> videos;

  MediaModel({
    required this.photos,
    required this.videos,
  });

  /// Firestore document structure:
  /// {
  ///   "Data": {
  ///     "Photos": [...],
  ///     "Videos": [...]
  ///   }
  /// }
  ///
  /// So we look inside `map['Data']` for `Photos` and `Videos`.
  factory MediaModel.fromMap(Map<String, dynamic> map) {
    final dataMap = map['Data'] as Map<String, dynamic>? ?? {};

    final List<String> parsedPhotos = (dataMap['Photos'] as List<dynamic>?)
            ?.map((item) => item.toString())
            .toList() ??
        [];

    final List<String> parsedVideos = (dataMap['Videos'] as List<dynamic>?)
            ?.map((item) => item.toString())
            .toList() ??
        [];

    return MediaModel(
      photos: parsedPhotos,
      videos: parsedVideos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Data': {
        'Photos': photos,
        'Videos': videos,
      },
    };
  }
}

// -----------------------------------------------------
// CONTROLLER
// -----------------------------------------------------
class GalleryController extends GetxController {
  /// Use Rxn (nullable reactive) so we can reactively listen to changes.
  final Rxn<MediaModel> mediaModel = Rxn<MediaModel>();

  /// Fetch data from Firestore, store in `mediaModel`.
  Future<void> fetchMediaModelFromDoc(String docId) async {
    print(docId);
    mediaModel.value  = null;
    try {
      final docRef =
          FirebaseFirestore.instance.collection('gallery').doc(docId);
      final snapshot = await docRef.get();

      if (!snapshot.exists) {
        // If doc doesn't exist, you can handle it differently,
        // for now we set an empty model:

        mediaModel.value = MediaModel(photos: [], videos: []);
        return;
      }

      // Debug: Print the raw snapshot
      print('Document Snapshot: $snapshot');
      // Debug: Print the raw data map
      print('RAW Firestore Data (Map): ${snapshot.data()}');

      final data = snapshot.data();
      if (data == null) {
        mediaModel.value = MediaModel(photos: [], videos: []);
        return;
      }
      print("@@@@@@@@@@@@@@@@@@@");
print(data);
      // Convert snapshot data to our MediaModel
      mediaModel.value = MediaModel.fromMap(data);

      // Debug prints
      print('Photos = ${mediaModel.value?.photos}');
      print('Videos = ${mediaModel.value?.videos}');
    } catch (e) {
      // In case of error, print or handle it as needed
      print('Error fetching doc: $e');
      // Optionally set an empty or null model
      mediaModel.value = null;
    }
  }
}

/// Reference to Firestore
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
// /// Holds the list of photo strings or objects after fetch
// List<String> _photos = [];
// List<String> get photos => _photos;
//
// /// For loading state
// bool _isLoading = false;
// bool get isLoading => _isLoading;
//
// /// Error message placeholder
// String? _errorMessage;
// String? get errorMessage => _errorMessage;
//
// /// Fetch data from "gallery" collection by docId (e.g. "2023")
// Future<void> fetchGallery(String docId) async {
//   try {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     // 1. Retrieve the document snapshot
//     DocumentSnapshot docSnapshot = await _firestore
//         .collection('gallery')
//         .doc(docId)
//         .get();
//
//     // 2. Check if document exists
//     if (!docSnapshot.exists) {
//       // Handle scenario when the document isn't found
//       _errorMessage = 'Gallery document $docId does not exist.';
//       _photos = [];
//     } else {
//       // 3. Parse the data into your desired format
//       //    Assuming your Firestore doc has a field "Photos" which is an array of base64 or image URLs.
//       final data = docSnapshot.data() as Map<String, dynamic>;
//
//       // For example, if doc has "Photos" array
//       if (data.containsKey('Photos')) {
//         List<dynamic> rawPhotos = data['Photos'];
//         // Convert all items to String, or handle based on your data type
//         _photos = rawPhotos.cast<String>();
//       } else {
//         // "Photos" field is missing
//         _errorMessage = 'No "Photos" field found in document $docId.';
//         _photos = [];
//       }
//     }
//   } catch (error) {
//     // 4. Handle errors (e.g. network issues, permission issues, etc.)
//     _errorMessage = 'Failed to fetch gallery data: $error';
//     _photos = [];
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }
