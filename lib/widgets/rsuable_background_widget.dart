import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';

class ReusableBackGroundScreen extends StatefulWidget {
  final List<String>? tabTitles; // Optional tab titles
  final List<Widget>? tabViews; // Optional tab views
  final List<Widget>? tbaButtons; // Optional tab-specific buttons
  final Widget? singleView; // New field for single view widget
  final bool isBookSlot;
  final String? appBarTitle;

  ReusableBackGroundScreen({
    super.key,
    this.tabTitles,
    this.tabViews,
    this.tbaButtons,
    this.singleView,
    this.appBarTitle,
    this.isBookSlot = false,
  });

  @override
  State<ReusableBackGroundScreen> createState() =>
      _ReusableBackGroundScreenState();
}

class _ReusableBackGroundScreenState extends State<ReusableBackGroundScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.tabTitles != null && widget.tabTitles!.isNotEmpty) {
      _tabController =
          TabController(length: widget.tabTitles!.length, vsync: this);
      _tabController!.addListener(() {
        setState(() {
          _currentTabIndex = _tabController!.index;
        });
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    double borderRadius = width * 0.1;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: widget.appBarTitle != null && widget.appBarTitle!.isNotEmpty
            ? Text(
                widget.appBarTitle ?? '',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Image.asset('lib/assets/BG LOGO3.png'),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: width * 0.05),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.0146),
          widget.isBookSlot
              ? SizedBox(height: height * 0.02)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("Sponsored by",
                            style: TextStyle(fontSize: width * 0.03)),
                        Image.asset('lib/assets/Plus Logo.png',
                            width: width * 0.4, height: height * 0.02),
                      ],
                    ),
                    // SizedBox(width: width * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Powered by",
                            style: TextStyle(fontSize: width * 0.03)),
                        Container(
                          // color: Colors.red,
                          child: Image.asset('lib/assets/Xsentinel.png',
                              width: width * 0.15, height: height * 0.07),
                        ),
                      ],
                    ),
                  ],
                ),
          SizedBox(height: height * 0.0403),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                color: Colors.black.withOpacity(0.7),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(borderRadius),
                        topLeft: Radius.circular(borderRadius),
                      ),
                      child: Image.asset(
                        'lib/assets/Appoinment BG Image.png',
                        width: width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(borderRadius),
                        topLeft: Radius.circular(borderRadius),
                      ),
                    ),
                  ),
                  if (widget.tabTitles != null &&
                      widget.tabViews != null &&
                      widget.tabTitles!.isNotEmpty &&
                      widget.tabViews!.isNotEmpty)
                    Column(
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
                              indicatorPadding: EdgeInsets.symmetric(
                                vertical: height * 0.01,
                              ),
                              indicatorSize: TabBarIndicatorSize.values.first,
                              dividerColor: AppColors.white,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              indicator: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(width * 0.5),
                                gradient: AppColors.getOrangeGradient(),
                              ),
                              tabs: widget.tabTitles!
                                  .map((title) => Tab(text: title))
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: widget.tabViews!,
                          ),
                        ),
                      ],
                    ),
                  if (widget.singleView != null)
                    widget.singleView!, // Show single view if provided
                  if (widget.tbaButtons != null &&
                      widget.tbaButtons!.isNotEmpty &&
                      _currentTabIndex < widget.tbaButtons!.length)
                    Padding(
                      padding: EdgeInsets.only(bottom: height * 0.025),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: widget.tbaButtons![_currentTabIndex],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ReusableBackGroundScreen extends StatefulWidget {
//   final List<String> tabTitles;
//   final List<Widget> tabViews;
//   final List<Widget>? tbaButtons;
//   bool isBookSlot;
//   final String? appBarTitle;
//   ReusableBackGroundScreen(
//       {super.key,
//       required this.tabTitles,
//       required this.tabViews,
//       this.tbaButtons,
//       this.appBarTitle,
//       this.isBookSlot = false});
//
//   @override
//   State<ReusableBackGroundScreen> createState() =>
//       _ReusableBackGroundScreenState();
// }
//
// class _ReusableBackGroundScreenState extends State<ReusableBackGroundScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentTabIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController =
//         TabController(length: widget.tabTitles.length, vsync: this);
//
//     // Listen for tab changes
//     _tabController.addListener(() {
//       setState(() {
//         _currentTabIndex = _tabController.index;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     double borderRadius = width * 0.1;
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         title: widget.isBookSlot
//             ? Text(
//                 widget.appBarTitle??'',
//                 style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: width * 0.05,
//                     fontWeight: FontWeight.w500,
//                     ),
//               )
//             : Image.asset('lib/assets/BG LOGO3.png'),
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black, size: width * 0.05),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: height * 0.0146),
//           widget.isBookSlot
//               ? SizedBox(height: height*0.02,)
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Text("Sponsored by",
//                             style: TextStyle(fontSize: width * 0.03)),
//                         Image.asset('lib/assets/Plus Logo.png',
//                             width: width * 0.4, height: height * 0.02),
//                       ],
//                     ),
//                     SizedBox(width: width * 0.05),
//                     Column(
//                       children: [
//                         Text("Powered by",
//                             style: TextStyle(fontSize: width * 0.03)),
//                         Image.asset('lib/assets/Xsentinel.png',
//                             width: width * 0.4, height: height * 0.02),
//                       ],
//                     ),
//                   ],
//                 ),
//           SizedBox(height: height * 0.0403),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(borderRadius),
//                   topRight: Radius.circular(borderRadius),
//                 ),
//                 color: Colors.black.withOpacity(0.7),
//
//               ),
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(borderRadius),
//                         topLeft: Radius.circular(borderRadius),
//                       ),
//                       child: Image.asset(
//                         'lib/assets/Appoinment BG Image.png',
//                         width: width,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: width,
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.7),
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(borderRadius),
//                         topLeft: Radius.circular(borderRadius),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: height * 0.025,
//                             left: width * 0.08,
//                             right: width * 0.08),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(width * 0.25),
//                             color: AppColors.white,
//                           ),
//                           child: TabBar(
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
//                                 borderRadius:
//                                     BorderRadius.circular(width * 0.5),
//                                 gradient: AppColors.getOrangeGradient()),
//                             tabs: widget.tabTitles
//                                 .map((title) => Tab(text: title))
//                                 .toList(),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.015),
//                       Expanded(
//                         child: TabBarView(
//                           controller: _tabController,
//                           children: widget.tabViews,
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (widget.tbaButtons != null &&
//                       widget.tbaButtons!.isNotEmpty &&
//                       _currentTabIndex < widget.tbaButtons!.length)
//                     Padding(
//                       padding: EdgeInsets.only(bottom: height * 0.025),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: widget.tbaButtons![_currentTabIndex],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ReusableBackGroundScreen extends StatefulWidget {
//   final List<String> tabTitles;
//   final List<Widget> tabViews;
//   final List<Widget>? tbaButton;
//
//
//   const ReusableBackGroundScreen({
//     super.key,
//     required this.tabTitles,
//     required this.tabViews,
//     this.tbaButton
//   });
//
//   @override
//   State<ReusableBackGroundScreen> createState() =>
//       _ReusableBackGroundScreenState();
// }
//
// class _ReusableBackGroundScreenState extends State<ReusableBackGroundScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController =
//         TabController(length: widget.tabTitles.length, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     double borderRadius = width * 0.1;
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         title: Image.asset('lib/assets/BG LOGO3.png'),
//         backgroundColor: AppColors.white,
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black, size: width * 0.05),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: height * 0.0146),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: [
//                   Text("Sponsored by",
//                       style: TextStyle(fontSize: width * 0.03)),
//                   Image.asset('lib/assets/Plus Logo.png',
//                       width: width * 0.4, height: height * 0.02),
//                 ],
//               ),
//               SizedBox(width: width * 0.05),
//               Column(
//                 children: [
//                   Text("Powered by", style: TextStyle(fontSize: width * 0.03)),
//                   Image.asset('lib/assets/Xsentinel.png', width: width * 0.4, height: height * 0.02),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: height * 0.0403),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(borderRadius),
//                   topRight: Radius.circular(borderRadius),
//                 ),
//                 color: Colors.black.withOpacity(0.7),
//               ),
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(borderRadius),
//                         topLeft: Radius.circular(borderRadius),
//                       ),
//                       child: Image.asset(
//                         'lib/assets/Appoinment BG Image.png',
//                         width: width,
//                         // height: height*0.6395,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: width,
//                     // height: height*0.65,
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.7),
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(borderRadius),
//                         topLeft: Radius.circular(borderRadius),
//                       ),
//                     ),
//                   ),
//                   Stack(
//                     children: [
//                       Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top: height * 0.025,
//                                 left: width * 0.08,
//                                 right: width * 0.08),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(width * 0.25),
//                                 color: AppColors.white,
//                               ),
//                               child: TabBar(
//                                 controller: _tabController,
//                                 labelStyle: TextStyle(
//                                     fontFamily: 'Poppins',
//                                     fontSize: width * 0.03,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.white),
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: width * 0.008,
//                                     horizontal: width * 0.04),
//                                 indicatorPadding: EdgeInsets.symmetric(
//                                   vertical: height * 0.01,
//                                 ),
//                                 indicatorSize: TabBarIndicatorSize.values.first,
//                                 dividerColor: AppColors.white,
//                                 labelColor: Colors.white,
//                                 unselectedLabelColor: Colors.black,
//                                 indicator: BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.circular(width * 0.5),
//                                     gradient: AppColors.getOrangeGradient()),
//                                 tabs: widget.tabTitles
//                                     .map((title) => Tab(text: title))
//                                     .toList(),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: height * 0.015,
//                           ),
//                           Expanded(
//                             child: TabBarView(
//                               controller: _tabController,
//                               children: widget.tabViews,
//                             ),
//                           ),
//                         ],
//                       ),
//                       if(widget.tbaButton != null)
//                         Align(
//                             alignment: Alignment.bottomCenter,
//                             child: widget.tbaButton![0])
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
