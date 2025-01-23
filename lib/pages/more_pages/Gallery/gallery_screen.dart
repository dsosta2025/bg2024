import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bima_gyaan/pages/more_pages/Gallery/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// import other necessary packages (e.g., video_player, etc.)
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
// If you're using screen util, import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryScreen extends StatefulWidget {
  final String year; // docId

  const GalleryScreen({Key? key, required this.year}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late VideoPlayerController _videoController;

  // Inject/Get the controller
  final GalleryController controller = Get.put(GalleryController());

  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize tab controller
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });

    // Example video controller
    _videoController = VideoPlayerController.network(
      'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Fetch Firestore data once
    controller.fetchMediaModelFromDoc(widget.year);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    controller.fetchMediaModelFromDoc(widget.year);
    print(widget.year);

    return Obx(() {
      // 1. If data is null, you might show a loading indicator or a "no data" widget
      final media = controller.mediaModel.value;
      if (media == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      // 2. If the doc was empty (photos & videos are empty), show "No data found"
      if (media.photos.isEmpty && media.videos.isEmpty) {
        return Scaffold(
          body: Center(child: Text('No data found for ${widget.year}')),
        );
      }

      // 3. We have media data -> build your normal UI
      return Scaffold(
        body: Stack(
          children: [
            // For your background gradient, etc.
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1B6FB5),
                    Color(0xFF4AAAFA),
                  ],
                ),
              ),
            ),
            // Example back button and title
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white),
                    const SizedBox(width: 20),
                    Text(
                      'Gallery ${widget.year}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Main container
            Positioned(
              top: 100,
              child: Container(
                width: width,
                height: height - 100, // or any dimension you want
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 249, 247, 247),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // TabBar
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
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
                          indicatorPadding: EdgeInsets.symmetric(
                            vertical: height * 0.01,
                          ),
                          indicatorSize: TabBarIndicatorSize.values.first,
                          dividerColor: AppColors.white,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.5),
                            gradient: AppColors.getOrangeGradient(),
                          ),
                          tabs: const [
                            Tab(text: 'Photos'),
                            Tab(text: 'Videos'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // TabBarView
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Videos Tab

                            // ListView.builder(
                            //   itemCount: media.videos.length,
                            //   itemBuilder: (context, index) {
                            //     final videoUrl = media.videos[index];
                            //     return Container(
                            //       margin: const EdgeInsets.only(bottom: 12),
                            //       color: Colors.red,
                            //       height: 50,
                            //       child: Center(
                            //         child: Text(
                            //           videoUrl,
                            //           style:
                            //           const TextStyle(color: Colors.white),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),

                            // Photos Tab
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 6.0,
                              ),
                              itemCount: media.photos.length,
                              itemBuilder: (context, index) {
                                final photoUrl = media.photos[index];
                                print(photoUrl);
                                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FullScreenImageViewer(
                                                imageBase64: photoUrl),
                                      ),
                                    );
                                  },
                                  child: Image.network(photoUrl),
                                  // Image.memory(
                                  //   base64Decode(photoUrl),
                                  //   fit: BoxFit.contain,
                                  // ),
                                );

                                //   Image.network(
                                //   photoUrl,
                                //   fit: BoxFit.cover,
                                // );
                              },
                            ),
                            ListView.builder(
                              itemCount: media.videos.length,
                              itemBuilder: (context, index) {
                                final videoBase64 = media.videos[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  // For best results, wrap in an AspectRatio or give it a specific height
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    // or any ratio that fits your design
                                    child: Base64VideoWidget(
                                      base64Video: videoBase64,
                                    ),
                                  ),
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
    });
  }
}

class Base64VideoWidget extends StatefulWidget {
  final String base64Video; // The base64 string for your video

  const Base64VideoWidget({
    Key? key,
    required this.base64Video,
  }) : super(key: key);

  @override
  State<Base64VideoWidget> createState() => _Base64VideoWidgetState();
}

class _Base64VideoWidgetState extends State<Base64VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  File? _tempVideoFile;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  Future<void> _initVideoPlayer() async {
    try {
      // 1. Decode base64 -> Uint8List
      Uint8List videoBytes = base64Decode(widget.base64Video);

      // 2. Write bytes to a temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
        '${tempDir.path}/temp_video_${DateTime.now().millisecondsSinceEpoch}.mp4',
      );
      await tempFile.writeAsBytes(videoBytes);
      _tempVideoFile = tempFile;

      // 3. Initialize VideoPlayerController from file
      _controller = VideoPlayerController.file(_tempVideoFile!)
        ..setLooping(true);

      _initializeVideoPlayerFuture = _controller.initialize();
      setState(() {});
    } catch (e) {
      debugPrint('Error initializing base64 video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // If you wish, you could delete the temp file:
    // _tempVideoFile?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If _initializeVideoPlayerFuture or _tempVideoFile is not ready, show a loading indicator
    if (_tempVideoFile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<void>(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Video is ready -> Show the player
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_controller),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          // Loading
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class FullScreenImageViewer extends StatelessWidget {
  final String imageBase64;

  const FullScreenImageViewer({Key? key, required this.imageBase64})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 1,
          maxScale: 4,
          child: Image.memory(
            base64Decode(imageBase64),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// class GalleryScreen extends StatefulWidget {
//   const GalleryScreen({super.key, required String year});
//
//   @override
//   State<GalleryScreen> createState() => _GalleryScreenState();
// }
//
// class _GalleryScreenState extends State<GalleryScreen>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//   int _currentTabIndex = 0;
//   late VideoPlayerController _videoController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController!.addListener(() {
//       setState(() {
//         _currentTabIndex = _tabController!.index;
//       });
//     });
//
//
//   }
//
//   @override
//   void dispose() {
//     _tabController?.dispose();
//     _videoController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//
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
//                 Navigator.pop(context);
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
//                           controller: _tabController,
//                           labelStyle: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: width * 0.03,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.white),
//                           padding: EdgeInsets.symmetric(
//                               vertical: width * 0.008,
//                               horizontal: width * 0.04),
//                           indicatorPadding:
//                               EdgeInsets.symmetric(vertical: height * 0.01),
//                           indicatorSize: TabBarIndicatorSize.values.first,
//                           dividerColor: AppColors.white,
//                           labelColor: Colors.white,
//                           unselectedLabelColor: Colors.black,
//                           indicator: BoxDecoration(
//                             borderRadius: BorderRadius.circular(width * 0.5),
//                             gradient: AppColors.getOrangeGradient(),
//                           ),
//                           tabs: [
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: height * 0.017,
//                               ),
//                               child: Text('Videos'),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: height * 0.017,
//                               ),
//                               child: Text('Photos'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: height * 0.015),
//                     Expanded(
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: [
//                           ListView.builder(
//                             itemCount: 5,
//                             padding: EdgeInsets.all(8),
//                             itemBuilder: (context, index) {
//
//                             return   Container(
//                               height: 50,
//                               width: width * 0.9,
//                               decoration: BoxDecoration(color: Colors.red),
//                             );
//                           },),
//
//                           // Video Tab
//                           // Center(
//                           //   child: _videoController.value.isInitialized
//                           //       ? AspectRatio(
//                           //           aspectRatio:
//                           //               _videoController.value.aspectRatio,
//                           //           child: VideoPlayer(_videoController),
//                           //         )
//                           //       : CircularProgressIndicator(),
//                           // ),
//
//
//                           // Photos Tab
//                           GridView.builder(
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 10.0,
//                               mainAxisSpacing: 6/1,
//                             ),
//                             itemCount: 6, // Replace with actual image count
//                             itemBuilder: (context, index) {
//                               return Image.network(
//                                 'https://example.com/photo$index.jpg',
//                                 // Replace with actual image URL
//                                 fit: BoxFit.cover,
//                               );
//                             },
//                           ),
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
