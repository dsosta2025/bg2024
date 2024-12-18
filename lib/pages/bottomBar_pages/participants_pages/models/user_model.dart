class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String designation;
  final String organization;
  final String phone;
  final String imageUrl;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.designation,
    required this.organization,
    required this.phone,
    required this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      designation: map['designation'] ?? '',
      organization: map['organization'] ?? '',
      phone: map['phone'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
