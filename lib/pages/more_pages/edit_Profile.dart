import 'package:bima_gyaan/pages/more_pages/more_page.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

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
                    ' Edit Profile',
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
            child: Container(
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

                    // User Name
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
                    CustomeButton(
                      text: "Save changes",
                      onPressed: () {},
                      horizontalPadding: width * 0.15,
                      verticalPadding: 12,
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for profile details
Widget _buildProfileDetail(IconData icon, String text) {
  TextEditingController controller = TextEditingController();
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
    child: MyTextFeild(
      hintText: text,
      controller: controller,
    )
  );
}
