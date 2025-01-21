class Session {
  final String companyDetails;
  final String imageUrl;
  final String name;
  final String time;
  final String topic;
  final String pdf_url;
  final String description;

  Session({
    required this.companyDetails,
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.topic,
    required this.pdf_url,
    required this.description,
  });

  // Factory method to create a Session object from a Map
  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      companyDetails: map['company_details'] as String,
      imageUrl: map['image_url'] as String,
      name: map['name'] as String,
      time: map['time'] as String,
      topic: map['topic'] as String,
      pdf_url: map['pdf_url'] as String,
      description: map['description'] as String,
    );
  }
}
