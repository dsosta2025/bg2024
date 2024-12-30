import 'dart:convert';

import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionSpeakerCard extends StatelessWidget {
  final String name;
  final String toTime; // Optional additional text
  final String address; // Optional additional text
  final String imageUrl; // Optional additional text

  const SessionSpeakerCard({
    super.key,
    required this.name,
    required this.toTime,
    required this.address,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            width: width * 0.35,
            height: height * 0.16,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.05)),
            child: imageUrl.isNotEmpty
                ? Image.memory(base64Decode(imageUrl), fit: BoxFit.contain,)
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: Image.asset(
                      "lib/assets/user.png",
                    ),
                  ),
          ),
          SizedBox(
            width: width * 0.035,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.43,
                child: Text(
                  toTime,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: width * 0.037,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                width: width * 0.43,
                child: Text(
                  name,
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: width * 0.05,
                      color: AppColors.dark,
                      fontWeight: FontWeight.w800,
                      height: height * 0.0012),
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                width: width * 0.43,
                child: Text(
                  address,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              // SizedBox(height: height * 0.003),

              // Row(
              //   children: [
              //     Text(
              //       post,
              //       style: TextStyle(
              //         fontFamily: 'poppins',
              //         fontSize: width * 0.025,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     SizedBox(
              //       width: width * 0.015,
              //     ),
              //     Container(
              //       height: height * 0.02,
              //       width: 1,
              //       color: Colors.black,
              //     ),
              //     SizedBox(
              //       width: width * 0.015,
              //     ),
              //     Text(
              //       webAddress,
              //       style: TextStyle(
              //         fontFamily: 'poppins',
              //         fontSize: width * 0.025,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: height*0.015,),
              // Row(
              //   children: [
              //     CustomeButton(
              //       text: 'Schedule',
              //       onPressed: () {},
              //       horizontalPadding: width * 0.04,
              //       verticalPadding: height * 0.012,
              //
              //     ),
              //     SizedBox(width: width*0.025,),
              //     CustomeButton(
              //       text: 'Chat',
              //       onPressed: () {},
              //       horizontalPadding: width * 0.04,
              //       verticalPadding: height * 0.012,
              //       transparent: true,
              //     ),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
