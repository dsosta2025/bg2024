import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session1.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/controller/sessionController.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SeddionScreen extends StatelessWidget {
  String id;
  String year;

  SeddionScreen({super.key, required this.id, required this.year});

  Sessioncontroller controller = Get.put(Sessioncontroller());

  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    controller.fetchSessions(id);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(controller.sessions.length);
    return Stack(
      children: [
        Scaffold(
          body: Stack(
            children: [
              // For your background gradient, etc.
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1B6FB5),
                      Color(0xFF4AAAFA),
                    ],
                  ),
                ),
              ),
              // Example back button and title
              Positioned(
                top: 40,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.white),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Text(
                            'Presentation ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            " $year",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Main container
              Positioned(
                top: 100,
                child: Container(
                  width: width,
                  height: height - 100, // or any dimension you want
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 249, 247, 247),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Obx(
                    () => Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: ListView.builder(
                        itemCount: controller.sessions.length,
                        itemBuilder: (context, index) {
                          final pdfUrl =
                              controller.sessions.value[index].pdf_url ?? '';
                          return Padding(
                            padding: EdgeInsets.all(width * 0.02),
                            child: SessionSpeakerCardP(
                              imageUrl:
                                  controller.sessions.value[index].imageUrl,
                              name: controller.sessions.value[index].name,
                              yourBase64String: pdfUrl,
                              address: controller
                                  .sessions.value[index].companyDetails,
                              onDownloadTap: () async {
                                if (pdfUrl.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "PDF URL is empty!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  );
                                  return;
                                }
                                // Show downloading toast
                                Fluttertoast.showToast(
                                  msg: "Downloading file...",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                );

                                try {
                                  print(pdfUrl);
                                  print(
                                      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                                  // Simulate the download process
                                  String filePath =
                                      await controller.downloadPDF(pdfUrl);
                                  print("File path: $filePath");
                                  // Show download complete toast
                                  Fluttertoast.showToast(
                                    msg: "Download complete!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                  );
                                } catch (e) {
                                  // Show error toast
                                  Fluttertoast.showToast(
                                    msg: "Download failed!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  );
                                  debugPrint("Error during download: $e");
                                }
                              },
                              onViewTap: () async {
                                if (pdfUrl.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "PDF URL is empty!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  );
                                  return;
                                }
                                await controller.viewPDF(context, pdfUrl);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => controller.isLoading.value
              ? Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.orange2,
                      strokeWidth: width * 0.005,
                    ),
                  ),
                )
              : const SizedBox(),
        )
      ],
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PDFViewerScreen({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
      ),
      body: PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageFling: true,
      ),
    );
  }
}
