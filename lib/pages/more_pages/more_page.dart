import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
import 'package:bima_gyaan/pages/more_pages/Announcements/announcements_screen.dart';
import 'package:bima_gyaan/pages/more_pages/Gallery/gallery_screen.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/presentations_screen.dart';
import 'package:bima_gyaan/pages/more_pages/faq_screen.dart';
import 'package:bima_gyaan/pages/more_pages/forum_chat_screen.dart';
import 'package:bima_gyaan/pages/more_pages/profile_screen.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  // Track expanded sections
  bool isGalleryExpanded = false;
  bool isPresentationsExpanded = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Image.asset(
          'lib/assets/BG LOGO3.png',
          height: 26.h,
          width: 290.33.w,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Sponsored by',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: 0.001,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Image.asset(
                        'lib/assets/Plus Logo.png',
                        width: 69.82.w,
                        height: 16.h,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.w),
                    child: Column(
                      children: [
                        const Text(
                          'Powered by',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: 0.001,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Image.asset(
                          'lib/assets/Xsentinel.png',
                          width: 66.w,
                          height: 23.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.blueGradient,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  buildMenuItem(
                    Icons.person,
                    "Profile",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const ProfileScreen(),
                      ),
                    ),
                  ),
                  buildDivider(),
                  buildExpandableMenuItem(
                    title: "Gallery",
                    years: ["2024", "2023", "2022"],
                    isExpanded: isGalleryExpanded,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        isGalleryExpanded = expanded;
                      });
                    },
                    onYearTap: (year) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryScreen(year: year),
                        ),
                      );
                    },
                  ),
                  buildDivider(),
                  buildExpandableMenuItem(
                    title: "Presentations",
                    years: ["2024", "2023", "2022"],
                    isExpanded: isPresentationsExpanded,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        isPresentationsExpanded = expanded;
                      });
                    },
                    onYearTap: (year) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PresentationsScreen(year: year),
                        ),
                      );
                    },
                  ),
                  buildDivider(),
                  buildMenuItem(
                    Icons.chat,
                    "Forum Chat",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const ForumChatScreen(),
                      ),
                    ),
                  ),
                  buildDivider(),
                  buildMenuItem(
                    Icons.notifications,
                    "Announcements",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const AnnouncementsScreen(),
                      ),
                    ),
                  ),
                  buildDivider(),
                  buildMenuItem(
                    Icons.help_outline,
                    "FAQ",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const FaqScreen(),
                      ),
                    ),
                  ),
                  buildDivider(),
                  SizedBox(height: 50.h),
                  buildLogoutButton(),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    try {
      // Perform logout
      await _auth.signOut();

      // Navigate to Login Screen
      Get.offAll(() => const LoginScreen());

      // Show custom success snackbar
      CustomSnackbarr.show(Get.context!, 'Success', 'Logged out successfully!');
    } catch (e) {
      // Show custom error snackbar
      CustomSnackbarr.show(
        Get.context!,
        'Error',
        'Failed to log out: ${e.toString()}',
        isError: true,
      );
    }
  }

  Widget buildExpandableMenuItem({
    required String title,
    required List<String> years,
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
    required ValueChanged<String> onYearTap,
  }) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            title == "Gallery" ? Icons.photo : Icons.description,
            color: AppColors.white,
            size: 24,
          ),
          SizedBox(width: 20.w),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      trailing: Icon(
        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        size: 24,
        color: AppColors.white,
      ),
      onExpansionChanged: onExpansionChanged,
      children: years.map((year) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 64.w, right: 20.w),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                year,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white70,
                size: 24,
              ),
            ],
          ),
          onTap: () => onYearTap(year),
        );
      }).toList(),
    );
  }

  Widget buildMenuItem(IconData icon, String title,
      {bool showArrow = false, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.white, size: 24),
                SizedBox(width: 20.w),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        color: Colors.white54,
        thickness: 1,
        height: 20,
        indent: 0,
        endIndent: 0,
      ),
    );
  }

  Widget buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: ElevatedButton(
        onPressed: () {
          logout();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          backgroundColor: AppColors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(180.w, 52.h),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logout",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.logout_outlined, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}
