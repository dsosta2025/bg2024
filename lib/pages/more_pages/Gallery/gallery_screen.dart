import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key, required String year});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTabIndex = 0;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _currentTabIndex = _tabController!.index;
      });
    });

    // Initialize video player (use a sample video URL or asset)
    // _videoController = VideoPlayerController.network(
    //     'https://www.w3schools.com/html/mov_bbb.mp4')
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

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
                    'Gallery 2024',
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.025,
                          left: width * 0.08,
                          right: width * 0.08),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.25),
                          color: AppColors.white,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                          padding: EdgeInsets.symmetric(
                              vertical: width * 0.008,
                              horizontal: width * 0.04),
                          indicatorPadding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          indicatorSize: TabBarIndicatorSize.values.first,
                          dividerColor: AppColors.white,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.5),
                            gradient: AppColors.getOrangeGradient(),
                          ),
                          tabs: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.017,
                              ),
                              child: Text('Videos'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.017,
                              ),
                              child: Text('Photos'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: 5,
                            padding: EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                            
                            return   Container(
                              height: 50,
                              width: width * 0.9,
                              decoration: BoxDecoration(color: Colors.red),
                            );
                          },),
                        
                          // Video Tab
                          // Center(
                          //   child: _videoController.value.isInitialized
                          //       ? AspectRatio(
                          //           aspectRatio:
                          //               _videoController.value.aspectRatio,
                          //           child: VideoPlayer(_videoController),
                          //         )
                          //       : CircularProgressIndicator(),
                          // ),

                          
                          // Photos Tab
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 6/1,
                            ),
                            itemCount: 6, // Replace with actual image count
                            itemBuilder: (context, index) {
                              return Image.network(
                                'https://example.com/photo$index.jpg',
                                // Replace with actual image URL
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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

// import 'package:bima_gyaan/pages/more_pages/more_page.dart';
// import 'package:bima_gyaan/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class GalleryScreen extends StatefulWidget {
//   const GalleryScreen({super.key, required String year});
//
//   @override
//   State<GalleryScreen> createState() => _GalleryScreenState();
// }
//
// class _GalleryScreenState extends State<GalleryScreen> with SingleTickerProviderStateMixin{
//   TabController? _tabController;
//   int _currentTabIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: 2, vsync: this,
//     );
//     _tabController!.addListener(() {
//       setState(() {
//         _currentTabIndex = _tabController!.index;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 15.h,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.white,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: AppColors.blueGradient,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 25.h,
//             left: 20.w,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const MorePage()),
//                 );
//               },
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.arrow_back,
//                     size: 24,
//                     color: AppColors.white,
//                   ),
//                   SizedBox(width: 36.w),
//                   Text(
//                     'Gallery 2024',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 100.h,
//             child: Container(
//               constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height * 1),
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 249, 247, 247),
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(30),
//                     topLeft: Radius.circular(30)),
//               ),
//               width: 393.w,
//               height: 761.h,
//               child: Padding(
//                 padding: EdgeInsets.all(20.r),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: height * 0.025,
//                           left: width * 0.08,
//                           right: width * 0.08),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(width * 0.25),
//                           color: AppColors.white,
//                         ),
//                         child: TabBar(
//                             controller: _tabController,
//                             labelStyle: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: width * 0.03,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.white),
//                             padding: EdgeInsets.symmetric(
//                                 vertical: width * 0.008,
//                                 horizontal: width * 0.04),
//                             indicatorPadding: EdgeInsets.symmetric(
//                               vertical: height * 0.01,
//                             ),
//                             indicatorSize: TabBarIndicatorSize.values.first,
//                             dividerColor: AppColors.white,
//                             labelColor: Colors.white,
//                             unselectedLabelColor: Colors.black,
//                             indicator: BoxDecoration(
//                               borderRadius: BorderRadius.circular(width * 0.5),
//                               gradient: AppColors.getOrangeGradient(),
//                             ),
//                             tabs: [
//                               Text('Videos'),
//                               Text('Photos'),
//                             ]),
//                       ),
//                     ),
//                     SizedBox(height: height * 0.015),
//                     Expanded(
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             height: 10,
//                             width: width,
//                             color: Colors.red,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             height: 10,
//                             width: width,
//                             color: Colors.grey,
//                           ),
//
//
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
