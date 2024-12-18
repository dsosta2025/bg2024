import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chatModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  final messages = <ChatMessage>[].obs;
  final messageController = TextEditingController();

  final CollectionReference _chatCollection =
  FirebaseFirestore.instance.collection('chats');

  // Listen to real-time messages
  void listenToMessages(String userId, String otherUserId) {
    _chatCollection
        .where('senderId', whereIn: [userId, otherUserId])
        .where('receiverId', whereIn: [userId, otherUserId])
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs
          .map((doc) => ChatMessage.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // Send a message
  Future<void> sendMessage(String senderId, String receiverId, String message) async {
    if (message.isEmpty) return;

    final chatMessage = ChatMessage(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      timestamp: Timestamp.now(),
    );

    try {
      await _chatCollection.add(chatMessage.toFirestore());
      messageController.clear();
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
