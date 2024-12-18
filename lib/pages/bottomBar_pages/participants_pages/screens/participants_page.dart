import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/controller/partcipant_controller.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/widgets/Participants_chat_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chat_screen.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/widgets/participants_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/scgedule_section/screen/schedule_screen.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticipantsPage extends StatefulWidget {
  const ParticipantsPage({super.key});

  @override
  State<ParticipantsPage> createState() => _ParticipantsPageState();
}

class _ParticipantsPageState extends State<ParticipantsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ParticipantsController controller = Get.put(ParticipantsController());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchUsers();
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final Participants = Obx(() {
      if (controller.isLoading.value) {
        // Show loading spinner while data is being fetched
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      } else if (controller.errorMessage.isNotEmpty) {
        // Show error message if there's an error
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      } else if (controller.users.isEmpty) {
        // Show empty state if no participants are found
        return Center(
          child: Text(
            'No participants found.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      } else {
        // Render the participants list
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.015,
                horizontal: width * 0.03,
              ),
              child: ParticipantsWidget(
                email: controller.users[index].email,
                imageUrl: controller.users[index].imageUrl,
                name: controller.users[index].fullName,
                post: controller.users[index].designation,
                webAddress: controller.users[index].organization,
                onPressedChat: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailScreen(
                          userId: controller.auth.currentUser!.uid,
                          otherUserId: controller.users[index].uid,
                          userName: controller.users[index].fullName,
                        ),
                      ),
                    );


                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ChatDetailScreen(),
                  //   ),
                  // );
                },
                onPressedSchedule: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleScreen(
                        opponentUserId: controller.users[index].uid,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      }
    });

    // final Participants = Obx(() => ListView.builder(
    //       itemCount: controller.users.value.length,
    //       itemBuilder: (context, index) {
    //         return Padding(
    //             padding: EdgeInsets.symmetric(
    //                 vertical: height * 0.015, horizontal: width * 0.03),
    //             child: ParticipantsWidget(
    //               email: controller.users.value[index].email,
    //               imageUrl: controller.users.value[index].imageUrl,
    //               name: controller.users.value[index].fullName,
    //               post: controller.users.value[index].designation,
    //               webAddress: controller.users.value[index].organization,
    //               onPressedChat: () {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => ChatDetailScreen(),
    //                     ));
    //               },
    //               onPressedSchedule: () {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => ScheduleScreen(),
    //                     ));
    //               },
    //             ));
    //       },
    //     ));

    final chats = ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.015, horizontal: width * 0.03),
          child: ParticipantsChatWidget(
            message: 'dolores.chambers@example.com',
            imageUrl: '',
            name: 'Ralph Edwards',
            post: 'Dog Trainer',
            webAddress: 'Biffco Enterprises Ltd.',
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ChatDetailScreen(),
              //     ));
            },
          ),
        );
      },
    );

    final sponsorsTab = ListView.builder(
      itemCount: sponsorsData.length,
      itemBuilder: (context, index) {
        return Image.asset(sponsorsData[index]);
      },
    );

    // Pass tab data
    return ReusableBackGroundScreen(
      tabTitles: [
        "Participants",
        "Chats",
      ],
      tabViews: [
        Participants,
        chats,
      ],
    );
  }

  static final scheduleData = [
    {"time": "08:00 AM To 08:45 AM", "registrationText": "Registration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
    {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
  ];

  static final speakersData = [
    {"sessionName": "Session 1", "time": "09:15 AM - 10:15 AM"},
    {"sessionName": "Session 2", "time": "10:30 AM - 12:15 PM"},
    // More speaker items...
  ];

  static final sponsorsData = [
    "lib/assets/Sponsors1.png",
    "lib/assets/Sponsors2.png",
  ];
}

// class ParticipantsPage extends StatefulWidget {
//   const ParticipantsPage({super.key});
//
//   @override
//   State<ParticipantsPage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<ParticipantsPage>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//
//
// }
