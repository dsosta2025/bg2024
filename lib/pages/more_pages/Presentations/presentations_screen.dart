import 'package:bima_gyaan/pages/home_pages/speakers.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/sessionScreen.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/presentationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresentationsScreen extends StatelessWidget {
  String id;
  String year;

  PresentationsScreen({super.key, required this.id,required this.year});

  Presentationcontroller controller = Get.put(Presentationcontroller());

  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    controller.fetchSpeakers(id);
    return Scaffold(
      body: Stack(
        children: [
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
                        ' $year',
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
              height: height - 100, // Adjust as needed
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 249, 247, 247),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Obx(() {
                if (controller.isLoadingSpeakers.value) {
                  // Loading state
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.hasErrorSpeakers.value) {
                  // Error state
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 40, color: Colors.red),
                        const SizedBox(height: 10),
                        Text(
                          controller.errorMessageSpeakers.value,
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                } else if (controller.speakers.isEmpty) {
                  // Empty data state
                  return const Center(
                    child: Text(
                      'No speakers available for this event.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                } else {
                  // Success state: List of speakers
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: controller.speakers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeddionScreen(
                                    id: controller.speakers[index].sessionId,
                                    year: year,
                                  ),
                                ),
                              );
                            },
                            child: Speakers(
                              sessionName:
                                  controller.speakers[index].sessionName,
                              time: controller.speakers[index].time,
                              isBreak: false,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
