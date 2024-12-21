class ChatRoom {
  final String id;
  final String name;
  final List<String> participants;

  ChatRoom({
    required this.id,
    required this.name,
    required this.participants,
  });

  factory ChatRoom.fromFirestore(Map<String, dynamic> data, String id) {
    return ChatRoom(
      id: id,
      name: data['name'] ?? 'Unnamed Room',
      participants: List<String>.from(data['participants'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'participants': participants,
    };
  }
}
