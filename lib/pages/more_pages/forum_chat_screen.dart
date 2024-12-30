import 'package:bima_gyaan/pages/more_pages/more_page.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ForumChatScreen extends StatelessWidget {
  const ForumChatScreen({super.key});

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
                Get.back();
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  MorePage()),
                // );
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
                    'Forum Chat',
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
            // left: 0,
            // right: 0,
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
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
