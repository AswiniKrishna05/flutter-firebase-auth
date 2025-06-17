class UserModel {
  final String fullName;
  final String email;
  final String phone;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
    };
  }
}
