import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class ParticipantsChatWidget extends StatelessWidget {
  final String name;
  final String message;
  final String post; // Optional additional text
  final String webAddress; // Optional additional text
  final String imageUrl; // Optional additional text
  final VoidCallback onTap;

  const ParticipantsChatWidget({
    super.key,
    required this.name,
    required this.message,
    required this.post,
    required this.webAddress,
    required this.imageUrl,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.05),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.22,
            height: height * 0.13,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(width * 0.05)),
          ),
        
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: width * 0.047,
                  color: AppColors.dark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: height * 0.005),


              Row(
                children: [
                  Text(
                    post,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: width * 0.025,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.015,
                  ),
                  Container(
                    height: height * 0.02,
                    width: 1,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: width * 0.015,
                  ),
                  Text(
                    webAddress,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: width * 0.025,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.015,),
              Container(
                width: 180.w,
                padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.w)
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                ),
              )
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(width*0.015),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.025),
                gradient: AppColors.getOrangeGradient()
              ),
              child: Icon(Icons.arrow_forward_ios_rounded,size: width*0.06,color: AppColors.white,),
            ),
          )
        ],
      ),
    );
  }
}
