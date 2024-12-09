import 'package:bima_gyaan/pages/more_pages/edit_Profile.dart';
import 'package:bima_gyaan/pages/more_pages/more_page.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0.05.h,
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
              Navigator.pop(context);
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
                    'Profile',
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
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 1),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 249, 247, 247),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  width: 393.w,
                  height: 761.h,
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 60.r,
                          backgroundImage:
                              const AssetImage('lib/assets/Profile image.png'),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Ralph Edwards',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        // Role (Insurer)
                        _buildProfileDetail(Icons.person, 'insurer'),

                        _buildProfileDetail(Icons.business, 'Xsentinal'),

                        // Email
                        _buildProfileDetail(Icons.email, 'email@domain.com'),

                        // Phone Number
                        _buildProfileDetail(Icons.phone, '+91 888 888 9595'),

                        SizedBox(height: 30.h),

                        //const Spacer(),
                        // Buttons: Logout and Delete Account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomeButton(
                              text: "Logout",
                              onPressed: () {},
                              horizontalPadding: width * 0.15,
                              verticalPadding: 12,
                            ),
                            CustomeButton(
                              transparent: true,
                              text: "Delete Account",
                              onPressed: () {},
                              horizontalPadding: width * 0.07,
                              verticalPadding: 12,
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(width * 0.05),
                      width: width * 0.12,
                      height: width * 0.12,
                      decoration: BoxDecoration(
                          gradient: AppColors.getOrangeGradient(),
                          borderRadius: BorderRadius.circular(width * 0.025)),
                      child: Icon(
                        Icons.edit_note_rounded,
                        color: Colors.white,
                        size: width * 0.06,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for profile details
Widget _buildProfileDetail(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
    child: Row(
      children: [
        Icon(icon, size: 24, color: Colors.black54),
        SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              color: AppColors.dark,
              fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

// Widget for buttons
Widget _buildButton(BuildContext context, String text, Color color,
    VoidCallback onPressed, double width, bool isRtransparent) {
  return CustomeButton(
    transparent: isRtransparent,
    text: text,
    onPressed: () {},
    horizontalPadding: width * 0.15,
    verticalPadding: 12,
  );
}
