import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Schedule extends StatelessWidget {
  final String time;
  final String registrationText;
  final String? additionalText; // Optional additional text

  const Schedule({
    super.key,
    required this.time,
    required this.registrationText,
    this.additionalText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 117.h,
      width: 345.w,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 10.sp,
              color: AppColors.dark,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: 112.w,
            child: const Divider(
              thickness: 0,
              height: 0,
              color: AppColors.orange,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            registrationText,
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          // if (additionalText != null) ...[
          //   SizedBox(height: 10.h),
          //   Text(
          //     additionalText!,
          //     style: TextStyle(
          //       fontSize: 12.sp,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ],
          SizedBox(height: 5.h),

          Container(
            width: 180.w,
            padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.w)
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  "Hotel Sofitel Mumbai BKC",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
