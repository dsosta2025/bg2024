import 'package:bima_gyaan/pages/bottomBar_pages/appoinment_pages/appoinment_page.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/event_pages/Screens/events_page.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/participants_page.dart';
import 'package:bima_gyaan/pages/home_pages/home_page.dart';
import 'package:bima_gyaan/pages/more_pages/more_page.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const ParticipantsPage(),
    const AppoinmentPage(),
    const EventsPage(),
    const MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.r),
          topRight: Radius.circular(0.r),
        ),
        child: Container(
          height: 80.h,
          width: 393.w,
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.sp,
            ),
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(
              color: AppColors.white,
              fontSize: 10.sp,
            ),
            unselectedItemColor: AppColors.white,
            selectedItemColor: AppColors.white,
            
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: _buildBottomBarIcon("lib/assets/home-2.png", "Home", 0),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.black,

                icon: _buildBottomBarIcon("lib/assets/people.png", "Participant", 1),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.black,

                icon: _buildBottomBarIcon("lib/assets/book.png", "Appoinment", 2),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.black,

                icon: _buildBottomBarIcon("lib/assets/calendar.png", "Events", 3),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.black,

                icon: _buildBottomBarIcon("lib/assets/menu.png", "More", 4),
                label: "",
              ),
            ],
            // items: [
            //   BottomNavigationBarItem(
            //     backgroundColor: Colors.black,
            //     icon: ImageIcon(
            //       const AssetImage("lib/assets/home-2.png"),
            //       size: 24.w,
            //     ),
            //     label: "Home",
            //   ),
            //   BottomNavigationBarItem(
            //     backgroundColor: Colors.black,
            //
            //     icon: ImageIcon(
            //       const AssetImage("lib/assets/people.png"),
            //       size: 24.w,
            //     ),
            //     label: "Participant",
            //   ),
            //   BottomNavigationBarItem(
            //     backgroundColor: Colors.black,
            //
            //     icon: ImageIcon(
            //       const AssetImage("lib/assets/book.png"),
            //       size: 24.w,
            //     ),
            //     label: "Appoinment",
            //   ),
            //   BottomNavigationBarItem(
            //     backgroundColor: Colors.black,
            //
            //     icon: ImageIcon(
            //       const AssetImage("lib/assets/calendar.png"),
            //       size: 24.w,
            //     ),
            //     label: "Events",
            //   ),
            //   BottomNavigationBarItem(
            //     backgroundColor: Colors.black,
            //
            //     icon: ImageIcon(
            //       const AssetImage("lib/assets/menu.png"),
            //       size: 24.w,
            //     ),
            //     label: "More",
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
  Widget _buildBottomBarIcon(String assetPath, String label, int index) {
    bool isSelected = _currentIndex == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Container(
                width: 60.w, // Adjust container size
                height: 50.h,
                decoration: BoxDecoration(
                  gradient: AppColors.getOrangeGradient(),
                  borderRadius: BorderRadius.circular(10.w)
                  // color: Colors.orange.withOpacity(0.2), // Background color for selected item
                  // shape: BoxShape.circle,
                ),
              ),
            Column(
              children: [
                ImageIcon(
                  AssetImage(assetPath),
                  size: 24.w,
                  // color: isSelected ? AppColors.orange : Colors.green,
                ),
                SizedBox(height: 5.h,),
                Text(
                  label,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 8.sp,
                      // color: AppColors.white
                    color: isSelected ? AppColors.white : Colors.grey.withOpacity(0.5),
                  ),
                ),

              ],
            ),
          ],
        ),
        // if (!isSelected) // Show label only inside for selected items
      ],
    );
  }

}
