import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session1.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session2.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session3.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session4.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/session_container.dart';
import 'package:bima_gyaan/pages/more_pages/more_page.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PresentationsScreen extends StatelessWidget {
  const PresentationsScreen({super.key, required String year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 15.h,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.blueGradient,
              ),
            ),
          ),
          Positioned(
            top: 25.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MorePage()),
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 36.w),
                  Text(
                    'Presentations',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100.h,
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 1),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 249, 247, 247),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              width: 393.w,
              height: 761.h,
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_left, size: 24),
                          onPressed: () {},
                        ),
                        Text(
                          '2024',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: IconButton(
                            icon: const Icon(Icons.keyboard_arrow_right,
                                size: 24),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SessionContainer(
                      sessionName: 'Session 1',
                      time: '9:15 am - 10:00 am',
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const Session1()))
                      },
                    ),
                    SizedBox(height: 20.h),
                    SessionContainer(
                      sessionName: 'Session 2',
                      time: '10:30 am - 12:15 pm',
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const Session2()))
                      },
                    ),
                    SizedBox(height: 20.h),
                    SessionContainer(
                      sessionName: 'Session 3',
                      time: '12:15 pm - 13:15 pm',
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const Session3()))
                      },
                    ),
                    SizedBox(height: 20.h),
                    SessionContainer(
                      sessionName: 'Session 4',
                      time: '14:15 pm -16:15 pm',
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const Session4()))
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
