import 'package:bima_gyaan/pages/bottomBar_pages/participants_pages/models/user_model.dart';

class ChatRoomModel {
  String? chatRoomId;
  List<Participant>? participants;

  ChatRoomModel({
    this.chatRoomId,
    this.participants,
  });

  // Factory constructor to create a ChatRoomModel from Firestore data
  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatRoomId: map['chatRoomId'] ?? '',
      participants: List<Participant>.from(map['participants']?.map((x) => Participant.fromMap(x)) ?? []),
    );
  }


  // Method to convert a ChatRoomModel to a map
  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'participants': participants?.map((x) => x.toMap()).toList(),
    };
  }
}


class Participant {
  bool isUserBlock;
  String userId;

  Participant({
    required this.isUserBlock,
    required this.userId,
  });

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      isUserBlock: map['isUserBlock'] ?? false,
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isUserBlock': isUserBlock,
      'userId': userId,
    };
  }
}


class MessageModel {
  String messageId;
  String createdAt;
  String message;
  String senderID;
  MessageModel({
    required this.messageId,
    required this.createdAt,
    required this.message,
    required this.senderID,
  });

  // Factory constructor to create a MessageModel from a map (e.g., from Firestore)
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] ?? '',
      createdAt: map['createdAt'] ?? '',
      message: map['message'] ?? '',
      senderID: map['senderID'] ?? '',

    );
  }

  // Method to convert MessageModel to map (e.g., for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'createdAt': createdAt,
      'message': message,
      'senderID': senderID,

    };
  }

}

// class UserModelWithChatRoomId {
//   final UserModel user;
//   final String chatRoomId;
//
//   UserModelWithChatRoomId({
//     required this.user,
//     required this.chatRoomId,
//   });
//
//   factory UserModelWithChatRoomId.fromMap(
//       Map<String, dynamic> userMap, String chatRoomId) {
//     return UserModelWithChatRoomId(
//       user: UserModel.fromMap(userMap),
//       chatRoomId: chatRoomId,
//     );
//   }
// }


