class Event {
  final String id;
  final String name;
  final String location;
  final String year;
  final String pickupDate;

  Event({
    required this.id,
    required this.name,
    required this.location,
    required this.year,
    required this.pickupDate,
  });

  // Factory method to create an Event from a Firestore document
  factory Event.fromDocument(Map<String, dynamic> doc,) {
    return Event(
      id: doc['event_id'],
      name: doc['event_name'] ?? '',
      location: doc['event_location'] ?? '',
      year: doc['event_year'] ?? '',
      pickupDate: doc['pickup_date'] ?? '',
    );
  }
}
