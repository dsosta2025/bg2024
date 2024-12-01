import 'package:bima_gyaan/pages/bottomBar_pages/event_pages/Widgets/calendar_widget.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 15.h,
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Image.asset(
              'lib/assets/BG LOGO3.png',
              height: 26.h,
              width: 290.33.w,
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Sponsored by',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: 0.001,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Image.asset(
                        'lib/assets/Plus Logo.png',
                        width: 69.82.w,
                        height: 16.h,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.w),
                    child: Column(
                      children: [
                        Text(
                          'Powered by',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: 0.001,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Image.asset(
                          'lib/assets/Xsentinel.png',
                          width: 66.w,
                          height: 23.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              width: 344.w,
              height: 95.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.blueGradient,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dark.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'No Event on this day',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 36.h),
            Container(
              width: 345.w,
              height: 668.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  SizedBox(height: 20),
                  CalendarWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
