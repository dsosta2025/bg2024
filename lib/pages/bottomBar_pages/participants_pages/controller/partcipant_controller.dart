import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/chat_section/chat_screen/dart/chatModel.dart';
import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/models/user_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParticipantsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isOverLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxString errorMessageForChat = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  // Method to fetch users, excluding the current user
  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      errorMessage('');

      // Get the current user's ID
      String currentUserId = auth.currentUser?.uid ?? '';

      if (currentUserId.isEmpty) {
        errorMessage('No user is currently signed in.');
        return;
      }

      // Fetch users from Firestore, excluding the current user
      final querySnapshot = await _firestore
          .collection('users')
          .where('uid', isNotEqualTo: currentUserId) // Exclude the current user
          .get();

      if (querySnapshot.docs.isEmpty) {
        errorMessage('No participants found.');
      } else {
        users.value = querySnapshot.docs
            .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (error) {
      errorMessage('Failed to fetch users: $error');
    } finally {
      isLoading(false);
    }
  }

  RxList<UserModel> userList = <UserModel>[].obs; // Only store UserModel

  Future<void> fetchChatUsersWithChatRoomIds() async {
    isOverLoading(true); // Start loading
    errorMessageForChat(''); // Clear previous error

    try {
      String currentUserId = auth.currentUser?.uid ?? '';
      if (currentUserId.isEmpty) {
        errorMessageForChat('User not signed in.');
        return;
      }

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot currentUserDoc =
          await firestore.collection('users').doc(currentUserId).get();

      if (!currentUserDoc.exists) {
        throw Exception("Current user not found.");
      }
      var chatRoomsData = currentUserDoc['chatRoomsIdList'];
      if (chatRoomsData is List) {
        List<String> chatRoomsIdList = List<String>.from(
          chatRoomsData.where((item) => item is String),
        );
        userList.clear();
        for (String chatRoomId in chatRoomsIdList) {
          DocumentSnapshot chatRoomDoc =
              await firestore.collection('chatRooms').doc(chatRoomId).get();

          if (!chatRoomDoc.exists) {
            continue;
          }

          ChatRoomModel chatRoom = ChatRoomModel.fromMap(
            chatRoomDoc.data() as Map<String, dynamic>,
          );
          Participant? otherParticipant =
              chatRoom.participants?.firstWhereOrNull(
            (participant) => participant.userId != currentUserId,
          );

          if (otherParticipant == null) {
            continue;
          }

          DocumentSnapshot userDoc = await firestore
              .collection('users')
              .doc(otherParticipant.userId)
              .get();

          if (userDoc.exists) {
            UserModel user = UserModel.fromMap(
              userDoc.data() as Map<String, dynamic>,
            );

            userList.add(user);
          }
        }
      } else {
        errorMessageForChat('Error: chatRoomsIdList is not a valid list.');
      }
    } catch (e) {
      errorMessageForChat('Failed to fetch chats: $e');
    } finally {
      isOverLoading(false); // Stop loading
    }
  }
}

// Future<void> fetchChatUsersWithChatRoomIds() async {
//   String currentUserId = auth.currentUser!.uid;
//   try {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//     // Fetch current user's data
//     DocumentSnapshot currentUserDoc =
//     await firestore.collection('users').doc(currentUserId).get();
//
//     if (!currentUserDoc.exists) {
//       throw Exception("Current user not found.");
//     }
//
//     // Safely parse chatRoomsIdList as a List<String>
//     var chatRoomsData = currentUserDoc['chatRoomsIdList'];
//     if (chatRoomsData is List) {
//       List<String> chatRoomsIdList = List<String>.from(
//         chatRoomsData.where((item) => item is String),
//       );
//
//       // Clear the list before populating it
//       userList.clear();
//
//       for (String chatRoomId in chatRoomsIdList) {
//         // Fetch chat room data
//         DocumentSnapshot chatRoomDoc =
//         await firestore.collection('chatRooms').doc(chatRoomId).get();
//
//         if (!chatRoomDoc.exists) {
//           continue;
//         }
//
//         // Parse chat room data
//         ChatRoomModel chatRoom = ChatRoomModel.fromMap(
//           chatRoomDoc.data() as Map<String, dynamic>,
//         );
//
//         // Find the other participant
//         Participant? otherParticipant =
//         chatRoom.participants?.firstWhereOrNull(
//               (participant) => participant.userId != currentUserId,
//         );
//
//         if (otherParticipant == null) {
//           continue;
//         }
//
//         // Fetch user details for the other participant
//         DocumentSnapshot userDoc = await firestore
//             .collection('users')
//             .doc(otherParticipant.userId)
//             .get();
//
//         if (userDoc.exists) {
//           UserModel user = UserModel.fromMap(
//             userDoc.data() as Map<String, dynamic>,
//           );
//
//           // Add only the UserModel to the list
//           userList.add(user);
//         }
//       }
//     } else {
//       print("Error: chatRoomsIdList is not a list.");
//     }
//   } catch (e) {
//     print('Error fetching chat users with chat room IDs: $e');
//   }
// }
// Rx<ChatRoomModel> chatRoomDataa = ChatRoomModel().obs;
//
// Future<ChatRoomModel?> createChatRoom(String secondUserId) async {
//   try {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       throw Exception('No current user found.');
//     }
//     String currentUserId = currentUser.uid;
//     DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(currentUserId)
//         .get();
//     List<String> currentUserChatRooms =
//         List<String>.from(currentUserDoc['chatRoomsIdList'] ?? []);
//     for (String chatRoomId in currentUserChatRooms) {
//       DocumentSnapshot chatRoomDoc = await FirebaseFirestore.instance
//           .collection('chatRooms')
//           .doc(chatRoomId)
//           .get();
//       if (chatRoomDoc.exists) {
//         Map<String, dynamic> chatRoomData =
//             chatRoomDoc.data() as Map<String, dynamic>;
//         List<Map<String, dynamic>> participants =
//             List<Map<String, dynamic>>.from(chatRoomData['participants']);
//         bool isSecondUserInRoom = participants
//             .any((participant) => participant['userId'] == secondUserId);
//         bool isCurrentUserInRoom = participants
//             .any((participant) => participant['userId'] == currentUserId);
//         if (isSecondUserInRoom && isCurrentUserInRoom) {
//           chatRoomDataa.value = ChatRoomModel.fromMap(chatRoomData);
//           return ChatRoomModel.fromMap(chatRoomData);
//         }
//       }
//     }
//     DocumentReference docRef =
//         FirebaseFirestore.instance.collection('chatRooms').doc();
//     String chatRoomId = docRef.id;
//     ChatRoomModel newChatRoom = ChatRoomModel(
//       chatRoomId: chatRoomId,
//       participants: [
//         Participant(isUserBlock: false, userId: currentUserId),
//         Participant(isUserBlock: false, userId: secondUserId),
//       ],
//     );
//
//     await docRef.set(newChatRoom.toMap());
//
//     chatRoomDataa.value = newChatRoom;
//
//     // Step 4: Update both users' chatRoomsIdList
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(currentUserId)
//         .update({
//       'chatRoomsIdList': FieldValue.arrayUnion([chatRoomId])
//     });
//
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(secondUserId)
//         .update({
//       'chatRoomsIdList': FieldValue.arrayUnion([chatRoomId])
//     });
//     return newChatRoom;
//   } catch (e) {
//     print('Error creating chat room: $e');
//     return null;
//   }
// }
// RxList<UserModelWithChatRoomId> userListWithChatRoomId =
//     <UserModelWithChatRoomId>[].obs;
//
// Future<void> fetchChatUsersWithChatRoomIds() async {
//   String currentUserId = auth.currentUser!.uid;
//   try {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//     // Fetch current user's data
//     DocumentSnapshot currentUserDoc =
//         await firestore.collection('users').doc(currentUserId).get();
//
//     if (!currentUserDoc.exists) {
//       throw Exception("Current user not found.");
//     }
//
//     // Safely parse chatRoomsIdList as a List<String>
//     var chatRoomsData = currentUserDoc['chatRoomsIdList'];
//     if (chatRoomsData is List) {
//       List<String> chatRoomsIdList = List<String>.from(
//         chatRoomsData.where((item) => item is String),
//       );
//
//       // Clear the list before populating it
//       userListWithChatRoomId.clear();
//
//       for (String chatRoomId in chatRoomsIdList) {
//         // Fetch chat room data
//         DocumentSnapshot chatRoomDoc =
//             await firestore.collection('chatRooms').doc(chatRoomId).get();
//
//         if (!chatRoomDoc.exists) {
//           continue;
//         }
//         // Parse chat room data
//         ChatRoomModel chatRoom = ChatRoomModel.fromMap(
//           chatRoomDoc.data() as Map<String, dynamic>,
//         );
//         // Find the other participant
//         Participant? otherParticipant =
//             chatRoom.participants?.firstWhereOrNull(
//           (participant) => participant.userId != currentUserId,
//         );
//
//         if (otherParticipant == null) {
//           continue;
//         }
//         // Fetch user details for the other participant
//         DocumentSnapshot userDoc = await firestore
//             .collection('users')
//             .doc(otherParticipant.userId)
//             .get();
//
//         if (userDoc.exists) {
//           UserModel user = UserModel.fromMap(
//             userDoc.data() as Map<String, dynamic>,
//           );
//
//           // Add the user with the chat room ID to the observable list
//           userListWithChatRoomId.add(
//             UserModelWithChatRoomId(
//               user: user,
//               chatRoomId: chatRoomId,
//             ),
//           );
//         }
//       }
//     } else {
//       print("Error: chatRoomsIdList is not a list.");
//     }
//   } catch (e) {
//     print('Error fetching chat users with chat room IDs: $e');
//   }
// }
