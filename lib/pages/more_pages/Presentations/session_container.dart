import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionContainer extends StatelessWidget {
  final String sessionName;
  final String time;
  final VoidCallback onPressed;

  const SessionContainer({
    super.key,
    required this.sessionName,
    required this.time,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.w,
      height: 79.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE7E0),
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
        padding: EdgeInsets.only(top: 10.h, left: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 32.w,
                height: 47.h,
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}