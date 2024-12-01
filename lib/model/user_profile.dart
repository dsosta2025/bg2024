class UserProfile {
  String? id;
  String fullName;
  String email;
  String mobileNumber;
  String countryCode;
  String password;
  String organization;
  String designation;

  UserProfile({
    this.id,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.countryCode,
    required this.password,
    required this.organization,
    required this.designation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'mobileNumber': mobileNumber,
      'countryCode': countryCode,
      'password': password,
      'organization': organization,
      'designation': designation,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String?,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      mobileNumber: map['mobileNumber'] as String,
      countryCode: map['countryCode'] as String,
      password: map['password'] as String,
      organization: map['organization'] as String,
      designation: map['designation'] as String,
    );
  }
}
