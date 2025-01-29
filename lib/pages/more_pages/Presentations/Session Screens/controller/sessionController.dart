import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bima_gyaan/pages/home/models/sessionsListModel.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/sessionScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
class Sessioncontroller extends GetxController{

  var sessions = <Session>[].obs;
  var isLoadingSessions = false.obs;
  var hasErrorSessions = false.obs;
  var errorMessageSessions = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch sessions
  Future<void> fetchSessions(String documentId) async {
    print(documentId);
    print("!!!!!!!!!!!!!!!!!!!!");
    isLoadingSessions.value = true;
    hasErrorSessions.value = false;
    sessions.value = [];
    try {
      final docSnapshot =
      await _firestore.collection('sessions').doc(documentId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final sessionList = data['Sessions'] as List<dynamic>;
        // Map each session in the list to the Session model

        sessions.value = sessionList
            .map((session) => Session.fromMap(session as Map<String, dynamic>))
            .toList();
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");


        print(sessions.length);
        if (sessions.isEmpty) {
          errorMessageSessions.value = 'No sessions available.';
        }
      } else {
        errorMessageSessions.value = 'Document does not exist.';
        sessions.clear();
      }
    } catch (e) {
      hasErrorSessions.value = true;
      errorMessageSessions.value = 'Failed to fetch sessions: $e';
    } finally {
      isLoadingSessions.value = false;
    }
  }
RxBool isLoading = false.obs;

  Future<void> viewPDF(BuildContext context, String pdfUrl) async {
    try {
      isLoading.value = true;
      // Get temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String filePath = '${tempDir.path}/temp_view.pdf';

      // Download the PDF file
      var response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        File pdfFile = File(filePath);
        await pdfFile.writeAsBytes(response.bodyBytes);

        // Navigate to the PDF viewer screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerScreen(pdfPath: filePath),
          ),
        );
      } else {
        throw Exception("Failed to download PDF");
      }
    } catch (e) {
      debugPrint("Error viewing PDF: $e");
      throw Exception("Failed to view PDF");
    }
    finally
        {
          isLoading.value = false;
        }
  }
  Future<String> downloadPDF(String pdfUrl) async {
    try {
      // Get external storage directory (for download)
      Directory? downloadsDir = await getExternalStorageDirectory();
      if (downloadsDir == null) {
        throw Exception("Failed to access storage");
      }

      // Define file path
      String filePath = '${downloadsDir.path}/downloaded_pdf.pdf';

      // Download the PDF file
      var response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        File pdfFile = File(filePath);
        await pdfFile.writeAsBytes(response.bodyBytes);

        return filePath; // Return the downloaded file path
      } else {
        throw Exception("Failed to download PDF");
      }
    } catch (e) {
      debugPrint("Error downloading PDF: $e");
      throw Exception("Failed to download PDF");
    }
  }

//
  //
  // Future<void> viewPDF(BuildContext context, String base64Pdf) async {
  //   try {
  //     // Decode the Base64 string
  //     Uint8List pdfData = base64Decode(base64Pdf);
  //
  //     // Save the PDF to a temporary file
  //     Directory tempDir = await getTemporaryDirectory();
  //     String filePath = '${tempDir.path}/temp_view.pdf';
  //     File pdfFile = File(filePath);
  //     await pdfFile.writeAsBytes(pdfData);
  //
  //     // Navigate to the PDF viewer screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PDFViewerScreen(pdfPath: filePath),
  //       ),
  //     );
  //   } catch (e) {
  //     debugPrint("Error viewing PDF: $e");
  //     throw Exception("Failed to view PDF");
  //   }
  // }
  //
  // Future<String> downloadPDF(String base64Pdf) async {
  //   try {
  //     // Decode the Base64 string to binary data
  //     Uint8List pdfData = base64Decode(base64Pdf);
  //
  //     // Get the temporary directory
  //     Directory tempDir = await getTemporaryDirectory();
  //
  //     // Create a file path for the PDF
  //     String filePath = '${tempDir.path}/downloaded_pdf.pdf';
  //
  //     // Write the binary data to the file
  //     File pdfFile = File(filePath);
  //     await pdfFile.writeAsBytes(pdfData);
  //
  //
  //     // Return the file path
  //     return filePath;
  //   } catch (e) {
  //     debugPrint("Error downloading PDF: $e");
  //     throw Exception("Failed to download PDF");
  //   }
  // }

}