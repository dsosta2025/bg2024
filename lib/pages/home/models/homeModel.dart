class Schedule {
  final String eventId;
  final String scheduleTime;
  final String scheduleTitle;

  Schedule({
    required this.eventId,
    required this.scheduleTime,
    required this.scheduleTitle,
  });

  // Factory method to create an instance from a Firestore document
  factory Schedule.fromMap(Map<String, dynamic> data) {
    return Schedule(
      eventId: data['event_id'] ?? '',
      scheduleTime: data['schedule_time'] ?? '',
      scheduleTitle: data['schedule_title'] ?? '',
    );
  }
}
