import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<MessageModel> messages =
      <MessageModel>[].obs; // For storing and updating messages

  Rx<ChatRoomModel> chatRoomDataa = ChatRoomModel().obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<ChatRoomModel?> createChatRoom(String secondUserId) async {
    try {
      isLoading.value = true;
      chatRoomDataa.value = ChatRoomModel();
      chatRoomDataa.refresh();
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No current user found.');
      }
      String currentUserId = currentUser.uid;

      // Fetch current user's document
      DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      List<String> currentUserChatRooms = List<String>.from(
        currentUserDoc['chatRoomsIdList'] ?? [],
      );

      // Parallel check for existing chat rooms
      var chatRoomCheckFutures = currentUserChatRooms.map((chatRoomId) async {
        DocumentSnapshot chatRoomDoc = await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(chatRoomId)
            .get();

        if (chatRoomDoc.exists) {
          Map<String, dynamic> chatRoomData =
              chatRoomDoc.data() as Map<String, dynamic>;
          List<Map<String, dynamic>> participants =
              List<Map<String, dynamic>>.from(chatRoomData['participants']);

          bool isSecondUserInRoom =
              _isUserInChatRoom(participants, secondUserId);
          bool isCurrentUserInRoom =
              _isUserInChatRoom(participants, currentUserId);

          if (isSecondUserInRoom && isCurrentUserInRoom) {
            fetchMessages(chatRoomId);
            chatRoomDataa.value = ChatRoomModel.fromMap(chatRoomData);
            await Future.delayed(const Duration(seconds: 1), () {
              // Set a value or perform any action here
              print("2 seconds delay completed.");
              isLoading.value = false;
            });

            return ChatRoomModel.fromMap(chatRoomData);
          }
        }
      });

      ChatRoomModel? existingChatRoom =
          (await Future.wait(chatRoomCheckFutures))
              .firstWhere((room) => room != null, orElse: () => null);

      if (existingChatRoom != null) {
        isLoading.value = false;
        return existingChatRoom;
      }

      // Create a new chat room
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('chatRooms').doc();
      String chatRoomId = docRef.id;

      ChatRoomModel newChatRoom = ChatRoomModel(
        chatRoomId: chatRoomId,
        participants: [
          Participant(isUserBlock: false, userId: currentUserId),
          Participant(isUserBlock: false, userId: secondUserId),
        ],
      );

      await docRef.set(newChatRoom.toMap());
      fetchMessages(chatRoomId);
      chatRoomDataa.value = newChatRoom;

      // Update users' chatRoomsIdList
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'chatRoomsIdList': FieldValue.arrayUnion([chatRoomId])
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(secondUserId)
          .update({
        'chatRoomsIdList': FieldValue.arrayUnion([chatRoomId])
      });
      isLoading.value = false;

      return newChatRoom;
    } catch (e) {
      print('Error creating chat room: $e');
      isLoading.value = false;

      return null;
    }
  }

  bool _isUserInChatRoom(
      List<Map<String, dynamic>> participants, String userId) {
    return participants.any((participant) => participant['userId'] == userId);
  }

  Future<void> sendMessage({
    required String chatRoomId,
    required String textMessage,
  }) async {
    try {
      // Get current user
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No current user found.');
      }
      String currentUserId = currentUser.uid;

      // Fetch participants of the chat room
      DocumentSnapshot chatRoomSnapshot = await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .get();

      List<dynamic> participants = chatRoomSnapshot['participants'];
      List<String> participantIds =
          participants.map((p) => p['userId'].toString()).toList();

      // Ensure the current user is part of the participants
      if (!participantIds.contains(currentUserId)) {
        throw Exception('User is not a participant of the chat room.');
      }

      // Get a reference to the messages collection and create a new message
      DocumentReference messageRef = FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(); // Auto-generate message ID

      // Create the message object
      MessageModel message = MessageModel(
        messageId: messageRef.id,
        createdAt: DateTime.now().toIso8601String(),
        message: textMessage,
        senderID: currentUserId,
      );

      // Add the message to the Firestore collection
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(messageRef, message.toMap());
      });

      print('Message sent successfully');
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Stream<List<MessageModel>> getMessages(String chatRoomId) {
    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList());
  }

  void fetchMessages(String chatRoomId) {
    getMessages(chatRoomId).listen((fetchedMessages) {
      messages.assignAll(fetchedMessages);
    });
  }
}
// Future<void> sendMessage({
//   required String chatRoomId,
//   required String textMessage,
// }) async {
//   try {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       throw Exception('No current user found.');
//     }
//     String currentUserId = currentUser.uid;
//
//     // Fetch participants
//     DocumentSnapshot chatRoomSnapshot = await FirebaseFirestore.instance
//         .collection('chatRooms')
//         .doc(chatRoomId)
//         .get();
//     List<dynamic> participants = chatRoomSnapshot['participants'];
//     List<String> participantIds = participants.map((p) => p['userId'].toString()).toList();
//
//
//     DocumentReference messageRef = FirebaseFirestore.instance
//         .collection('chatRooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .doc(); // Auto-generate message ID
//
//     // Create the messagep
//     MessageModel message = MessageModel(
//       messageId: messageRef.id,
//       createdAt: DateTime.now().toIso8601String(),
//       message: textMessage,
//       senderID: currentUserId,
//     );
//
//
//
//   } catch (e) {
//     print('Error sending message: $e');
//   }
// }
