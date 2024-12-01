import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/Participants_chat_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chat_screen.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/participants_widget.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/scgedule_section/schedule_screen.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipantsPage extends StatefulWidget {
  const ParticipantsPage({super.key});

  @override
  State<ParticipantsPage> createState() => _HomePageState();
}

class _HomePageState extends State<ParticipantsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final Participants = ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.03),
            child: ParticipantsWidget(
              email: 'dolores.chambers@example.com',
              imageUrl: '',
              name: 'Ralph Edwards',
              post: 'Dog Trainer',
              webAddress: 'Biffco Enterprises Ltd.',
              onPressedChat: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(),));

              },
              onPressedSchedule: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleScreen(),));

              },
            ));
      },
    );

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
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(),));

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
