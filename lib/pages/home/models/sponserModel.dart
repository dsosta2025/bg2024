class Sponsor {
  final String eventId;
  final String sponsorLogoPath;
  final String sponsorName;
  final String sponsorType;

  Sponsor({
    required this.eventId,
    required this.sponsorLogoPath,
    required this.sponsorName,
    required this.sponsorType,
  });

  // Convert Firebase document data to a Sponsor object
  factory Sponsor.fromMap(Map<String, dynamic> data) {
    return Sponsor(
      eventId: data['event_id'] as String,
      sponsorLogoPath: data['sponsor_logo_path'] as String,
      sponsorName: data['sponsor_name'] as String,
      sponsorType: data['sponsor_type'] as String,
    );
  }
}
