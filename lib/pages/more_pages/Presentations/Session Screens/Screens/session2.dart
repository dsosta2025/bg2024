import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session1.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Screens/session3.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/Session%20Screens/Widgets/common_container.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/presentations_screen.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Session2 extends StatelessWidget {
  const Session2({super.key});

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
                  MaterialPageRoute(
                    builder: (context) => const PresentationsScreen(
                      year: '2024',
                    ),
                  ),
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
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Session1()),
                            );
                          },
                        ),
                        Text(
                          'Session 2',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.keyboard_arrow_right, size: 24),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Session3()),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const CommonContainer(
                      SpeakersName: 'Jenny Wilson',
                      CompanyName: 'Louis Vuitton',
                      imageUrl: 'lib/assets/speaker1.png',
                    ),
                    SizedBox(height: 20.h),
                    const CommonContainer(
                      SpeakersName: 'Ronald Richards',
                      CompanyName: 'MasterCard',
                      imageUrl: 'lib/assets/speaker2.png',
                    ),
                    SizedBox(height: 20.h),
                    const CommonContainer(
                      SpeakersName: 'Ronald Richards',
                      CompanyName: 'Facebook',
                      imageUrl: 'lib/assets/speaker3.png',
                    ),
                    SizedBox(height: 20.h),
                    const CommonContainer(
                      SpeakersName: 'Ronald Richards',
                      CompanyName: 'Starbucks',
                      imageUrl: 'lib/assets/speaker4.png',
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
