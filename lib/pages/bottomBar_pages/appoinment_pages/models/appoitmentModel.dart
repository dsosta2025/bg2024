import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String createdBy;
  final String date;
  final String description;
  final String? meetingLink;
  final String? meetingVenue;
  final List<String> participants;
  final String status;
  final String subject;
  final DateTime createdAt;
  final String? oppositeUserName;
  final String? oppositeUserImage;
  AppointmentModel({
    required this.id,
    required this.createdBy,
    required this.date,
    required this.description,
    this.meetingLink,
    this.meetingVenue,
    required this.participants,
    required this.status,
    required this.subject,
    required this.createdAt,
    this.oppositeUserName,
    this.oppositeUserImage,
  });
  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] ?? '',
      createdBy: map['createdBy'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? '',
      meetingLink: map['meetingLink'],
      meetingVenue: map['meetingVenue'],
      participants: List<String>.from(map['participants'] ?? []),
      status: map['status'] ?? '',
      subject: map['subject'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      oppositeUserName: map['oppositeUserName'],
      oppositeUserImage: map['oppositeUserImage'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdBy': createdBy,
      'date': date,
      'description': description,
      'meetingLink': meetingLink,
      'meetingVenue': meetingVenue,
      'participants': participants,
      'status': status,
      'subject': subject,
      'createdAt': createdAt,
      'oppositeUserName': oppositeUserName,
      'oppositeUserImage': oppositeUserImage,
    };
  }

  AppointmentModel copyWith({
    String? id,
    String? createdBy,
    String? date,
    String? description,
    String? meetingLink,
    String? meetingVenue,
    List<String>? participants,
    String? status,
    String? subject,
    DateTime? createdAt,
    String? oppositeUserName,
    String? oppositeUserImage,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      date: date ?? this.date,
      description: description ?? this.description,
      meetingLink: meetingLink ?? this.meetingLink,
      meetingVenue: meetingVenue ?? this.meetingVenue,
      participants: participants ?? this.participants,
      status: status ?? this.status,
      subject: subject ?? this.subject,
      createdAt: createdAt ?? this.createdAt,
      oppositeUserName: oppositeUserName ?? this.oppositeUserName,
      oppositeUserImage: oppositeUserImage ?? this.oppositeUserImage,
    );
  }
}
