import 'package:bima_gyaan/pages/home_pages/speakers.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session1.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session2.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session3.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session4.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/sessionScreen.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/presentationController.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/session_container.dart';
import 'package:bima_gyaan/pages/more_pages/more_page.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PresentationsScreen extends StatelessWidget {
  String id;

  PresentationsScreen({super.key, required this.id});

  Presentationcontroller controller = Get.put(Presentationcontroller());

  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    controller.fetchSpeakers(id);

    return Scaffold(
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
                  Text(
                    'Presentation ',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
              child: Padding(
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
                                      id: controller
                                          .speakers.value[index].sessionId),
                                ));
                          },

                          child: Speakers(
                            sessionName:
                                controller.speakers.value[index].sessionName,
                            time: controller.speakers.value[index].time,
                            isBreak: false,
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
