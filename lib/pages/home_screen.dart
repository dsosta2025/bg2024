import 'package:bima_gyaan/pages/bottom_navigation.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/hotel_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(393, 683), minTextAdapt: true);

    return Scaffold(
      // appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildLogo(),
            _buildSponsoredBySection(),
            _buildHotelInfoSection(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 15.h,
      backgroundColor: AppColors.white,
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 50.h),
      child: Image.asset(
        'lib/assets/BG LOGO3.png',
        height: 26.h,
        width: 290.33.w,
      ),
    );
  }

  Widget _buildSponsoredBySection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSponsoredBy(
              'Sponsored by', 'lib/assets/Plus Logo.png', 69.82.w, 16.h),
          SizedBox(width: 50.w),
          _buildSponsoredBy(
              'Powered by', 'lib/assets/Xsentinel.png', 66.w, 23.h),
        ],
      ),
    );
  }

  Widget _buildSponsoredBy(
      String title, String logoPath, double width, double height) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            height: 1.4,
            letterSpacing: 0.001,
          ),
        ),
        SizedBox(height: 10.h),
        Image.asset(
          logoPath,
          width: width,
          height: height,
        ),
      ],
    );
  }

  Widget _buildHotelInfoSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.r),
          topLeft: Radius.circular(30.r),
        ),
      ),
      width: 393.w,
      height: 550.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildHotelInfoCard(context, 'lib/assets/Home Screen1.png',
              'Hotel Sofitel Mumbai BKC', 'Mumbai', '6 September 2025'),
          _buildHotelInfoCard(context, 'lib/assets/Home Screen2.png',
              'Hotel Taj Mahal', 'Mumbai', '6 September 2024'),
          _buildHotelInfoCard(context, 'lib/assets/Home Screen3.png',
              'Hotel Sofitel Mumbai BKC', 'Mumbai', '6 September 2023'),
          _buildHotelInfoCard(context, 'lib/assets/Home Screen4.png',
              'Hotel Sofitel Mumbai BKC', 'Mumbai', '6 September 2022'),
        ],
      ),
    );
  }

  Widget _buildHotelInfoCard(BuildContext context, String backgroundImage,
      String hotelName, String hotelLocation, String dateText) {
    return HotelInfoCard(
      backgroundImage: backgroundImage,
      hotelName: hotelName,
      hotelLocation: hotelLocation,
      dateText: dateText,
      buttonText: 'Know More',
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => const BottomNavigation()),
        );
        print('Know more pressed for $hotelName');
      },
    );
  }
}
