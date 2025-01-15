import 'package:bima_gyaan/pages/events/model/event_model.dart';
import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
import 'package:bima_gyaan/pages/more_pages/Announcements/announcements_screen.dart';
import 'package:bima_gyaan/pages/more_pages/Gallery/gallery_screen.dart';
import 'package:bima_gyaan/pages/more_pages/Presentations/presentations_screen.dart';
import 'package:bima_gyaan/pages/more_pages/aboutBigGyaan/screen/aboutScreen.dart';
import 'package:bima_gyaan/pages/more_pages/faq_screen.dart';
import 'package:bima_gyaan/pages/more_pages/feedbackSection/screens/feedbackScreen.dart';
import 'package:bima_gyaan/pages/more_pages/morepageController.dart';
import 'package:bima_gyaan/pages/more_pages/profileSection/screens/profile_screen.dart';
import 'package:bima_gyaan/pages/more_pages/qnaSection/screens/qnaScreen.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MorePage extends StatefulWidget {
  String evenId;

  MorePage({super.key, required this.evenId});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  bool isGalleryExpanded = false;
  bool isPresentationsExpanded = false;
  MorePageController controller = Get.put(MorePageController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    controller.fetchGalleryDocIds();
    controller.fetchAllEvents();
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
              padding: EdgeInsets.symmetric(vertical: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Powered by',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: 0.001,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                      Image.asset(
                        'lib/assets/Xsentinel.png',
                        width: 70.w,
                        height: 50.h,
                      ),
                    ],
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
                  Obx(() {
                    return buildExpandableMenuItem(
                      title: "Gallery",
                      years: controller.galleryDocIds,
                      isExpanded: isGalleryExpanded,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          isGalleryExpanded = expanded;
                        });
                      },
                      onYearTap: (docId) {
                        // Navigate with the docId instead of year
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GalleryScreen(year: docId),
                          ),
                        );
                      },
                    );
                  }),

                  buildDivider(),
                  Obx(() {
                    return buildExpandableMenuItemP(
                      title: "Presentations",
                      events: controller.eventsList.value,
                      // Now doc IDs
                      isExpanded: isPresentationsExpanded,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          isPresentationsExpanded = expanded;
                        });
                      },
                      onEventTap: (docId) {
                        // Navigate with doc ID
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PresentationsScreen(id: docId.id),
                          ),
                        );
                      },
                    );
                  }),
                  // buildExpandableMenuItem(
                  //   title: "Gallery",
                  //   years: ["2024", "2023", "2022"],
                  //   isExpanded: isGalleryExpanded,
                  //   onExpansionChanged: (expanded) {
                  //     setState(() {
                  //       isGalleryExpanded = expanded;
                  //     });
                  //   },
                  //   onYearTap: (year) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => GalleryScreen(year: year),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // buildExpandableMenuItem(
                  //   title: "Presentations",
                  //   years: ["2024", "2023", "2022"],
                  //   isExpanded: isPresentationsExpanded,
                  //   onExpansionChanged: (expanded) {
                  //     setState(() {
                  //       isPresentationsExpanded = expanded;
                  //     });
                  //   },
                  //   onYearTap: (year) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => PresentationsScreen(year: year),
                  //       ),
                  //     );
                  //   },
                  // ),
                  buildDivider(),
                  buildMenuItem(
                    Icons.chat,
                    "Q&A",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => QAScreen(),
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
                        builder: (builder) => AnnouncementsScreen(),
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
                        builder: (builder) => FAQScreen(),
                      ),
                    ),
                  ),
                  buildDivider(),
                  buildMenuItem(
                    Icons.account_balance_outlined,
                    "About BimaGyaan",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => AboutScreen(),
                      ),
                    ),
                  ),
                  buildDivider(),
                  buildMenuItem(
                    Icons.feedback,
                    "Feedback",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => FeedbackScreen(
                          eventId: widget.evenId,
                        ),
                      ),
                    ),
                  ),
                  buildDivider(),
                  SizedBox(height: 20.h),
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
      // Sign out from Firebase
      await _auth.signOut();

      // Sign out from Google
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

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

  // Future<void> logout() async {
  //   try {
  //     // Perform logout
  //     await _auth.signOut();
  //
  //     // Navigate to Login Screen
  //     Get.offAll(() => const LoginScreen());
  //
  //     // Show custom success snackbar
  //     CustomSnackbarr.show(Get.context!, 'Success', 'Logged out successfully!');
  //   } catch (e) {
  //     // Show custom error snackbar
  //     CustomSnackbarr.show(
  //       Get.context!,
  //       'Error',
  //       'Failed to log out: ${e.toString()}',
  //       isError: true,
  //     );
  //   }
  // }

  Widget buildExpandableMenuItem({
    required String title,
    required List<String> years,
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
    required ValueChanged<String> onYearTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Theme(
        data: Theme.of(Get.context!).copyWith(
          dividerColor: Colors.transparent, // Removes the black line
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          // Adjust padding if necessary
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
        ),
      ),
    );
  }
  Widget buildExpandableMenuItemP({
    required String title,
    required List<Event> events, // Accept a list of Event objects
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
    required ValueChanged<Event> onEventTap, // Pass the tapped Event object
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Theme(
        data: Theme.of(Get.context!).copyWith(
          dividerColor: Colors.transparent, // Removes the black line
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero, // Adjust padding if necessary
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
          children: events.map((event) {
            return ListTile(
              contentPadding: EdgeInsets.only(left: 64.w, right: 20.w),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.year, // Display event year as subtitle
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white70,
                    size: 24,
                  ),
                ],
              ),
              onTap: () => onEventTap(event), // Pass the event object when tapped
            );
          }).toList(),
        ),
      ),
    );
  }


  // Widget buildExpandableMenuItem({
  //   required String title,
  //   required List<String> years,
  //   required bool isExpanded,
  //   required ValueChanged<bool> onExpansionChanged,
  //   required ValueChanged<String> onYearTap,
  // }) {
  //   return ExpansionTile(
  //     title: Row(
  //       children: [
  //         Icon(
  //           title == "Gallery" ? Icons.photo : Icons.description,
  //           color: AppColors.white,
  //           size: 24,
  //         ),
  //         SizedBox(width: 20.w),
  //         Text(
  //           title,
  //           style: const TextStyle(
  //             fontFamily: 'Poppins',
  //             color: Colors.white,
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //     trailing: Icon(
  //       isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
  //       size: 24,
  //       color: AppColors.white,
  //     ),
  //     onExpansionChanged: onExpansionChanged,
  //     children: years.map((year) {
  //       return ListTile(
  //         contentPadding: EdgeInsets.only(left: 64.w, right: 20.w),
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               year,
  //               style: const TextStyle(
  //                 fontFamily: 'Poppins',
  //                 color: Colors.white70,
  //                 fontSize: 14,
  //               ),
  //             ),
  //             const Icon(
  //               Icons.arrow_forward,
  //               color: Colors.white70,
  //               size: 24,
  //             ),
  //           ],
  //         ),
  //         onTap: () => onYearTap(year),
  //       );
  //     }).toList(),
  //   );
  // }

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
