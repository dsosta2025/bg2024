
// Model for Speaker
class Speaker {
  final String eventId;
  final String sessionId;
  final String sessionName;
  final String time;

  Speaker({
    required this.eventId,
    required this.sessionId,
    required this.sessionName,
    required this.time,
  });

  // Factory method to create a Speaker object from a Map
  factory Speaker.fromMap(Map<String, dynamic> map) {
    return Speaker(
      eventId: map['event_id'] as String,
      sessionId: map['session_id'] as String,
      sessionName: map['session_name'] as String,
      time: map['time'] as String,
    );
  }
}
