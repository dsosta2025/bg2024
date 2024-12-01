import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/home_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotelInfoCard extends StatelessWidget {
  final String backgroundImage;
  final String hotelName;
  final String hotelLocation;
  final String dateText;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const HotelInfoCard({
    super.key,
    required this.backgroundImage,
    required this.hotelName,
    required this.hotelLocation,
    required this.dateText,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115.h,
      width: 350.w,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0.r),
            child: SizedBox(
              child: Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0.r),
            child: SizedBox(
              width: 350.w,
              height: 135.h,
              child: Container(
                color: const Color(0xFF380D0D).withOpacity(0.5),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 9.0.h, left: 16.0.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hotelLocation,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0.r),
                      child: Container(
                        width: 130.w,
                        height: 30.h,
                        color: AppColors.white.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.0.w),
                              child: Image.asset(
                                'lib/assets/calendar.png',
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                            Text(
                              dateText,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Text(
                      hotelName,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  // SizedBox(width: 8.0.w),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 15),
                child: HomeCustomButton(
                  text: buttonText,
                  onPressed: onButtonPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
