import 'dart:ffi';

import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chatControler.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chatModel.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class ChatDetailScreen extends StatelessWidget {
  final String currentUserId;
  final String secondUserId;
  final String senderName;
  final String senderImageUel;

  final ChatController _chatController = Get.put(ChatController());
  final TextEditingController _messageController = TextEditingController();

  ChatDetailScreen({
    super.key,
    required this.currentUserId,
    required this.secondUserId,
    required this.senderImageUel,
    required this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    _chatController.chatRoomDataa.value = ChatRoomModel();
    // Reset chat room data and create a new chat room
    _chatController.chatRoomDataa.value = ChatRoomModel();
    _chatController.createChatRoom(secondUserId);

    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    double borderRadius = width * 0.1;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        leadingWidth: width * 0.08,
        title: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: senderImageUel ?? '',
                placeholder: (context, url) =>
                    Icon(Icons.person, size: width*0.1, color: Colors.black),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, size: width*0.1, color: Colors.black),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: width * 0.05,
            ),
            Text(
              senderName,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: width * 0.05),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(borderRadius),
              //   topRight: Radius.circular(borderRadius),
              // ),
              color: Colors.black.withOpacity(0.7),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'lib/assets/Appoinment BG Image.png',
                    width: width,
                    fit: BoxFit.cover,
                    height: height,
                  ),
                ),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      if (_chatController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      if (_chatController.messages.isEmpty) {
                        return Center(
                          child: Text(
                            'No messages yet. Start the conversation!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.04,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.all(width * 0.04),
                        itemCount: _chatController.messages.length,
                        itemBuilder: (context, index) {
                          final message = _chatController.messages[index];
                          return ChatBubble(
                            message: message.message,
                            time: message.createdAt,
                            isSender: message.senderID == currentUserId,
                          );
                        },
                      );
                    }),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.03,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border:
                          Border(top: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: "Type a message ...",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.04,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        GestureDetector(
                          onTap: () {
                            final text = _messageController.text.trim();
                            if (text.isNotEmpty) {
                              _chatController.sendMessage(
                                chatRoomId: _chatController
                                    .chatRoomDataa.value.chatRoomId!,
                                textMessage: text,
                              );
                              _messageController.clear();
                            }
                          },
                          child: Container(
                            height: width * 0.1,
                            width: width * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade400,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.send, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //   backgroundColor: AppColors.white,
    //   appBar: AppBar(
    //     title: Text(
    //       "Chat",
    //       style: TextStyle(
    //         fontFamily: 'Poppins',
    //         fontSize: width * 0.05,
    //         fontWeight: FontWeight.w600,
    //       ),
    //     ),
    //     centerTitle: true,
    //     backgroundColor: AppColors.white,
    //     elevation: 0,
    //     leading: IconButton(
    //       icon: Icon(Icons.arrow_back, color: Colors.black, size: width * 0.05),
    //       onPressed: () => Navigator.pop(context),
    //     ),
    //   ),
    //   body: Stack(
    //     children: [
    //       Column(
    //         children: [
    //           SizedBox(height: height * 0.1),
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
    //                   SizedBox(
    //                     height: height*0.65,
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.end,
    //                       children: [
    //                         Obx(() {
    //                           if (_chatController.isLoading.value) {
    //                             return SizedBox(
    //                                 height: height * 0.65,
    //                                 child: Center(
    //                                     child: CircularProgressIndicator(
    //                                   color: Colors.white,
    //                                 )));
    //                             // return ListView.builder(
    //                             //   itemCount: 5,
    //                             //   // Number of shimmer placeholders
    //                             //   reverse: true,
    //                             //   shrinkWrap: true,
    //                             //   padding: EdgeInsets.all(width * 0.04),
    //                             //   itemBuilder: (context, index) {
    //                             //     return ChatBubbleShimmer(
    //                             //       isSender: index % 2 ==
    //                             //           0, // Alternate shimmer bubbles for sender/receiver
    //                             //     );
    //                             //   },
    //                             // );
    //                           }
    //                           return Padding(
    //                             padding: EdgeInsets.all(width * 0.04),
    //                             child: ListView.builder(
    //                               reverse: true,
    //                               shrinkWrap: true,
    //                               itemCount: _chatController.messages.length,
    //                               itemBuilder: (context, index) {
    //                                 final message = _chatController.messages[index];
    //                                 return ChatBubble(
    //                                   message: message.message,
    //                                   time: message.createdAt,
    //                                   isSender: message.senderID == currentUserId,
    //                                 );
    //                               },
    //                             ),
    //                           );
    //                         }),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //
    //         ],
    //       ),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: Container(
    //           padding: EdgeInsets.symmetric(
    //             horizontal: width * 0.02,
    //             vertical: height * 0.03,
    //           ),
    //           decoration: BoxDecoration(
    //             color: Colors.transparent,
    //             border: Border(top: BorderSide(color: Colors.grey.shade300)),
    //           ),
    //           child: Row(
    //             children: [
    //               // Container(
    //               //   margin: EdgeInsets.only(right: width * 0.02),
    //               //   height: width * 0.1,
    //               //   width: width * 0.1,
    //               //   decoration: BoxDecoration(
    //               //     color: Colors.orange.shade400,
    //               //     shape: BoxShape.circle,
    //               //   ),
    //               //   child: const Icon(Icons.add, color: Colors.white),
    //               // ),
    //               Expanded(
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey.shade200,
    //                     borderRadius: BorderRadius.circular(width * 0.05),
    //                   ),
    //                   child: TextField(
    //                     controller: _messageController,
    //                     decoration: InputDecoration(
    //                       hintText: "Type a message ...",
    //                       hintStyle: TextStyle(
    //                         color: Colors.grey,
    //                         fontSize: width * 0.04,
    //                       ),
    //                       border: InputBorder.none,
    //                       contentPadding:
    //                       EdgeInsets.symmetric(horizontal: width * 0.04),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(width: width * 0.02),
    //               GestureDetector(
    //                 onTap: () {
    //                   final text = _messageController.text.trim();
    //                   if (text.isNotEmpty) {
    //                     _chatController.sendMessage(
    //                       chatRoomId:
    //                       _chatController.chatRoomDataa.value.chatRoomId!,
    //                       textMessage: text,
    //                     );
    //                     _messageController.clear();
    //                   }
    //                 },
    //                 child: Container(
    //                   height: width * 0.1,
    //                   width: width * 0.1,
    //                   decoration: BoxDecoration(
    //                     color: Colors.orange.shade400,
    //                     shape: BoxShape.circle,
    //                   ),
    //                   child: const Icon(Icons.send, color: Colors.white),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

// class ChatDetailScreen extends StatelessWidget {
//   final String currentUserId;
//   final String secondUserId;
//   final ChatController _chatController = Get.put(ChatController());
//   final TextEditingController _messageController = TextEditingController();
//
//   ChatDetailScreen({
//     super.key,
//     required this.currentUserId,
//     required this.secondUserId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     _chatController.createChatRoom(secondUserId);
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     double borderRadius = width * 0.1;
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         title: Text(
//           "secondUser", // Display second user's name
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
//                         padding: EdgeInsets.all(width * 0.04),
//                         child: Obx(() {
//                           return ListView.builder(
//                             reverse: true,
//                             itemCount: _chatController.messages.length,
//                             itemBuilder: (context, index) {
//                               final message = _chatController.messages[index];
//                               return ChatBubble(
//                                 message: message.message,
//                                 time: message.createdAt,
//                                 isSender: message.senderID == currentUserId,
//                               );
//                             },
//                           );
//                         }),
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
//                 horizontal: width * 0.02,
//                 vertical: height * 0.03,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 border: Border(top: BorderSide(color: Colors.grey.shade300)),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(right: width * 0.02),
//                     height: width * 0.1,
//                     width: width * 0.1,
//                     decoration: BoxDecoration(
//                       color: Colors.orange.shade400,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.add, color: Colors.white),
//                   ),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(width * 0.05),
//                       ),
//                       child: TextField(
//                         controller: _messageController,
//                         decoration: InputDecoration(
//                           hintText: "Type a message ...",
//                           hintStyle: TextStyle(
//                             color: Colors.grey,
//                             fontSize: width * 0.04,
//                           ),
//                           border: InputBorder.none,
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: width * 0.04),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: width * 0.02),
//                   GestureDetector(
//                     onTap: () {
//                       final text = _messageController.text.trim();
//                       print(_chatController.chatRoomDataa.value.chatRoomId);
//                       _chatController.sendMessage(
//                           chatRoomId:
//                               _chatController.chatRoomDataa.value.chatRoomId!,
//                           textMessage: text);
//                       // if (text.isNotEmpty) {
//                       //   final message = ChatMessage(
//                       //     id: '',
//                       //     sender: currentUser,
//                       //     text: text,
//                       //     timestamp: DateTime.now(),
//                       //   );
//                       //   _chatController.sendMessage(message);
//                       //   _messageController.clear();
//                       // }
//                     },
//                     child: Container(
//                       height: width * 0.1,
//                       width: width * 0.1,
//                       decoration: BoxDecoration(
//                         color: Colors.orange.shade400,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(Icons.send, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: width * 0.05,
//             right: width * 0.05,
//             top: height * 0.06,
//             child: CircleAvatar(
//               backgroundColor: Colors.red,
//               radius: width * 0.1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
    print(time);
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: width * 0.02),
            // Adjust margin based on width
            padding: EdgeInsets.all(width * 0.04),
            // Adjust padding
            constraints: BoxConstraints(maxWidth: width * 0.75),
            // Adjust max width based on screen size
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: isSender ? Colors.white : Colors.black87,
                    fontSize: width * 0.04, // Adjust font size
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: width * 0.01,
                    left: width * 0.02,
                  ),
                  // Adjust padding
                  child: Text(
                    formatTime(time),
                    style: TextStyle(
                      fontSize: width * 0.03, // Adjust font size
                      color: isSender ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(String timestamp) {
    // Parse the timestamp
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the time
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }
}

class ChatBubbleShimmer extends StatelessWidget {
  final bool isSender;

  const ChatBubbleShimmer({
    Key? key,
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
          Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade500,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: width * 0.02),
              padding: EdgeInsets.all(width * 0.04),
              constraints: BoxConstraints(maxWidth: width * 0.75),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12.0),
                  topRight: const Radius.circular(12.0),
                  bottomLeft: Radius.circular(isSender ? 12.0 : 0.0),
                  bottomRight: Radius.circular(isSender ? 0.0 : 12.0),
                ),
              ),
              child: SizedBox(
                height: width * 0.05,
                width: width * 0.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: width * 0.01, left: width * 0.02, right: width * 0.02),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: width * 0.03,
                width: width * 0.2,
                color: Colors.grey.shade300,
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
