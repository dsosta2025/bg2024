import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/controller/partcipant_controller.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/widgets/Participants_chat_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chat_screen.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/widgets/participants_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/scgedule_section/screen/schedule_screen.dart';
import 'package:bima_gyaan/utils/colors.dart';
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
    controller.fetchChatUsersWithChatRoomIds();

    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final Participants = Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      } else if (controller.errorMessage.isNotEmpty) {
        // Show error message if there's an error
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      } else if (controller.users.isEmpty) {
        // Show empty state if no participants are found
        return const Center(
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
                        secondUserId: controller.users[index].uid,
                        currentUserId: controller.auth.currentUser!.uid,
                        senderImageUel: controller.users[index].imageUrl,
                        senderName: controller.users[index].fullName,
                      ),
                    ),
                  );
                  controller.fetchChatUsersWithChatRoomIds();

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

    final chats = Obx(() {
      if (controller.isOverLoading.value) {
        // Show loading spinner while fetching chats
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      } else if (controller.errorMessage.isNotEmpty) {
        // Show error message if there's an error
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      } else if (controller.userList.isEmpty) {
        // Show empty state if no chats are found
        return const Center(
          child: Text(
            'No chats available.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      } else {
        // Render the chat list
        return ListView.builder(
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            final user = controller.userList[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.015,
                horizontal: width * 0.03,
              ),
              child: ParticipantsChatWidget(
                message: user.email,
                imageUrl: user.imageUrl,
                name: user.fullName,
                post: user.designation,
                webAddress: user.organization,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetailScreen(
                        secondUserId: user.uid,
                        currentUserId: controller.auth.currentUser!.uid,
                        senderImageUel: user.imageUrl,
                        senderName: user.fullName,
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


    // final chats = Obx(() => ListView.builder(
    //       itemCount: controller.userList.value.length,
    //       itemBuilder: (context, index) {
    //         return Padding(
    //           padding: EdgeInsets.symmetric(
    //               vertical: height * 0.015, horizontal: width * 0.03),
    //           child: ParticipantsChatWidget(
    //             message:
    //                 controller.userList.value[index].email,
    //             imageUrl: controller
    //                 .userList.value[index].imageUrl,
    //             name: controller
    //                 .userList.value[index].fullName,
    //             post: controller
    //                 .userList.value[index].designation,
    //             webAddress: controller
    //                 .userList.value[index].organization,
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => ChatDetailScreen(
    //                     secondUserId: controller.userList[index].uid,
    //                     currentUserId: controller.auth.currentUser!.uid,
    //                     senderImageUel: controller.userList[index].imageUrl,
    //                     senderName: controller.userList[index].fullName,
    //                   ),
    //                 ),
    //               );
    //
    //             },
    //           ),
    //         );
    //       },
    //     ));


    // Pass tab data
    return ReusableBackGroundScreen(
      tabTitles: const [
        "Participants",
        "Chats",
      ],
      tabViews: [
        RefreshIndicator(
          color: AppColors.orange2,

          onRefresh: () async {
            await controller.fetchUsers();
          },
          child: Participants,
        ),
        // Wrap Chats list in a RefreshIndicator
        RefreshIndicator(
          color: AppColors.orange2,
          onRefresh: () async {
            await controller.fetchChatUsersWithChatRoomIds();
          },
          child: chats,
        ),
        // Participants,
        // chats,
      ],
    );
  }

}
//final sponsorsTab = ListView.builder(
//   itemCount: sponsorsData.length,
//   itemBuilder: (context, index) {
//     return Image.asset(sponsorsData[index]);
//   },
// );
// static final scheduleData = [
//   {"time": "08:00 AM To 08:45 AM", "registrationText": "Registration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
//   {"time": "08:45 AM To 09:00 AM", "registrationText": "Inauguration"},
// ];
//
// static final speakersData = [
//   {"sessionName": "Session 1", "time": "09:15 AM - 10:15 AM"},
//   {"sessionName": "Session 2", "time": "10:30 AM - 12:15 PM"},
//   // More speaker items...
// ];
//
// static final sponsorsData = [
//   "lib/assets/Sponsors1.png",
//   "lib/assets/Sponsors2.png",
// ];
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