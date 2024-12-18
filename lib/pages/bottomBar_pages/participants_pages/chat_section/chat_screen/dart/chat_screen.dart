
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chatControler.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailScreen extends StatelessWidget {
  final String userId;
  final String otherUserId;
  final String userName;

  ChatDetailScreen({
    required this.userId,
    required this.otherUserId,
    required this.userName,
  });

  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    // Start listening to messages
    chatController.listenToMessages(userId, otherUserId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          userName,
          style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: width * 0.05),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Obx(
                () => ListView.builder(
              padding: EdgeInsets.all(width * 0.04),
              itemCount: chatController.messages.length,
              itemBuilder: (context, index) {
                final message = chatController.messages[index];
                final isSender = message.senderId == userId;

                return ChatBubble(
                  message: message.message,
                  time: message.timestamp.toDate().toString(),
                  isSender: isSender,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.03),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatController.messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message ...",
                        hintStyle: TextStyle(fontSize: width * 0.04),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.orange),
                    onPressed: () {
                      chatController.sendMessage(
                        userId,
                        otherUserId,
                        chatController.messageController.text.trim(),
                      );
                    },
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

// class ChatDetailScreen extends StatelessWidget {
//   const ChatDetailScreen({super.key});
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
//         title: Text(
//           " Ralph Edwards",
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             fontSize: width * 0.05, // Adjust font size based on screen width
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black, size: width * 0.05),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               SizedBox(height: height * 0.1), // Adjusting height based on screen size
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(borderRadius),
//                       topRight: Radius.circular(borderRadius),
//                     ),
//                     color: Colors.black.withOpacity(0.7),
//                   ),
//                   child: Stack(
//                     children: [
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(borderRadius),
//                             topLeft: Radius.circular(borderRadius),
//                           ),
//                           child: Image.asset(
//                             'lib/assets/Appoinment BG Image.png',
//                             width: width,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: width,
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.7),
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(borderRadius),
//                             topLeft: Radius.circular(borderRadius),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(width * 0.04), // Adjust padding
//                         child: ListView(
//                           children: const [
//                             ChatBubble(
//                               message: "Hi!",
//                               time: "10:10",
//                               isSender: true,
//                             ),
//                             ChatBubble(
//                               message:
//                               "Awesome, thanks for letting me know! Can't wait for my delivery. 🎉",
//                               time: "10:11",
//                               isSender: true,
//                             ),
//                             ChatBubble(
//                               message:
//                               "No problem at all!\nI'll be there in about 15 minutes.\nI'll text you when I arrive.",
//                               time: "10:11",
//                               isSender: false,
//                             ),
//                             ChatBubble(
//                               message: "Great! 😊",
//                               time: "10:12",
//                               isSender: true,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: width * 0.02, vertical: height * 0.03), // Adjust padding based on screen size
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 border: Border(top: BorderSide(color: Colors.grey.shade300)),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(right: width * 0.02), // Margin for button
//                     height: width * 0.1, // Adjust height
//                     width: width * 0.1, // Adjust width
//                     decoration: BoxDecoration(
//                       color: Colors.orange.shade400,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.add, color: Colors.white),
//                   ),
//                   // TextField for Message Input
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(width * 0.05), // Border radius based on width
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: "Type a message ...",
//                           hintStyle: TextStyle(
//                               color: Colors.grey, fontSize: width * 0.04), // Adjust hint text size
//                           border: InputBorder.none,
//                           contentPadding:
//                           EdgeInsets.symmetric(horizontal: width * 0.04), // Adjust padding
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Send Button
//                   SizedBox(width: width * 0.02), // Adjust spacing between buttons
//                   Container(
//                     height: width * 0.1, // Adjust height
//                     width: width * 0.1, // Adjust width
//                     decoration: BoxDecoration(
//                       color: Colors.orange.shade400,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.send, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: width * 0.05, // Adjust the position of avatar
//             right: width * 0.05, // Adjust the position of avatar
//             top: height * 0.06, // Adjust the top position of avatar
//             child: CircleAvatar(
//               backgroundColor: Colors.red,
//               radius: width * 0.1, // Adjust radius based on width
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSender;
  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: width * 0.02), // Adjust margin based on width
            padding: EdgeInsets.all(width * 0.04), // Adjust padding
            constraints: BoxConstraints(
                maxWidth: width * 0.75), // Adjust max width based on screen size
            decoration: BoxDecoration(
              color: isSender ? null : Colors.grey.shade200,
              gradient: isSender ? AppColors.getOrangeGradient() : null,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12.0),
                topRight: const Radius.circular(12.0),
                bottomLeft: Radius.circular(isSender ? 12.0 : 0.0),
                bottomRight: Radius.circular(isSender ? 0.0 : 12.0),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isSender ? Colors.white : Colors.black87,
                fontSize: width * 0.04, // Adjust font size
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: width * 0.01, left: width * 0.02, right: width * 0.02), // Adjust padding
            child: Text(
              time,
              style: TextStyle(
                fontSize: width * 0.03, // Adjust font size
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:bima_gyaan/utils/colors.dart';
// import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
// import 'package:flutter/material.dart';
//
// class ChatDetailScreen extends StatelessWidget {
//   const ChatDetailScreen({super.key});
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
//         title: Text(
//           " Ralph Edwards",
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             fontSize: width * 0.05,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black, size: width * 0.05),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               SizedBox(height: height * 0.1),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(borderRadius),
//                       topRight: Radius.circular(borderRadius),
//                     ),
//                     color: Colors.black.withOpacity(0.7),
//                   ),
//                   child: Stack(
//                     children: [
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(borderRadius),
//                             topLeft: Radius.circular(borderRadius),
//                           ),
//                           child: Image.asset(
//                             'lib/assets/Appoinment BG Image.png',
//                             width: width,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: width,
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.7),
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(borderRadius),
//                             topLeft: Radius.circular(borderRadius),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: ListView(
//                           children: const [
//                             ChatBubble(
//                               message: "Hi!",
//                               time: "10:10",
//                               isSender: true,
//                             ),
//                             ChatBubble(
//                               message:
//                                   "Awesome, thanks for letting me know! Can't wait for my delivery. 🎉",
//                               time: "10:11",
//                               isSender: true,
//                             ),
//                             ChatBubble(
//                               message:
//                                   "No problem at all!\nI'll be there in about 15 minutes.\nI'll text you when I arrive.",
//                               time: "10:11",
//                               isSender: false,
//                             ),
//                             ChatBubble(
//                               message: "Great! 😊",
//                               time: "10:12",
//                               isSender: true,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 border: Border(top: BorderSide(color: Colors.grey.shade300)),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(right: 8.0),
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.orange.shade400,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.add, color: Colors.white),
//                   ),
//                   // TextField for Message Input
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: "Type a message ...",
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           border: InputBorder.none,
//                           contentPadding:
//                               const EdgeInsets.symmetric(horizontal: 16.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Send Button
//                   const SizedBox(width: 8.0),
//                   Container(
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.orange.shade400,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.send, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             top: height * 0.06,
//             child: CircleAvatar(
//               backgroundColor: Colors.red,
//               radius: width * 0.1,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class ChatBubble extends StatelessWidget {
//   final String message;
//   final String time;
//   final bool isSender;
//
//   const ChatBubble({
//     Key? key,
//     required this.message,
//     required this.time,
//     required this.isSender,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment:
//             isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 4.0),
//             padding: const EdgeInsets.all(12.0),
//             constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.75),
//             decoration: BoxDecoration(
//               color: isSender ? null : Colors.grey.shade200,
//               gradient: isSender ? AppColors.getOrangeGradient() : null,
//               borderRadius: BorderRadius.only(
//                 topLeft: const Radius.circular(12.0),
//                 topRight: const Radius.circular(12.0),
//                 bottomLeft: Radius.circular(isSender ? 12.0 : 0.0),
//                 bottomRight: Radius.circular(isSender ? 0.0 : 12.0),
//               ),
//             ),
//             child: Text(
//               message,
//               style: TextStyle(
//                 color: isSender ? Colors.white : Colors.black87,
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
//             child: Text(
//               time,
//               style: TextStyle(
//                 fontSize: 12.0,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
