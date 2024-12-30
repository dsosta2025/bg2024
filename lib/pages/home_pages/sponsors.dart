import 'dart:convert';

import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sponsors extends StatelessWidget {
  final String assetPath;

  const Sponsors({
    super.key,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 137.h,
      width: 345.w,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Image.memory(base64Decode(assetPath), fit: BoxFit.contain,)
        // Image.asset(
        //   assetPath,
        //   fit: BoxFit.contain,
        //   height: 124.h,
        //   width: 200.w,
        // ),
      ),
    );
  }
}
