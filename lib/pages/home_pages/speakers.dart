import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Speakers extends StatelessWidget {
  final String sessionName;
  final String time;
  final bool isBreak;


  const Speakers({
    super.key,
    required this.sessionName,
    required this.time,
    required this.isBreak,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.w,
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sessionName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  time,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark,
                  ),
                ),
              ],
            ),
            if(!isBreak)
            Container(
              width: 32.w,
              height: 47.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                gradient: AppColors.getOrangeGradient()

              ),
              child:  Center(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 30.w,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
