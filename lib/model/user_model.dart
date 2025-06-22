import 'user_session_model.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final UserRole role;
  final String? employeeId;
  final String? department;
  final String? designation;
  final String? profileImage;
  final DateTime? dateOfJoining;
  final DateTime? dateOfBirth;
  final String? address;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.role = UserRole.employee,
    this.employeeId,
    this.department,
    this.designation,
    this.profileImage,
    this.dateOfJoining,
    this.dateOfBirth,
    this.address,
    this.isActive = true,
    required this.createdAt,
    this.lastLoginAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role.name,
      'employeeId': employeeId,
      'department': department,
      'designation': designation,
      'profileImage': profileImage,
      'dateOfJoining': dateOfJoining?.toIso8601String(),
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'address': address,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => UserRole.employee,
      ),
      employeeId: map['employeeId'],
      department: map['department'],
      designation: map['designation'],
      profileImage: map['profileImage'],
      dateOfJoining: map['dateOfJoining'] != null 
          ? DateTime.parse(map['dateOfJoining']) 
          : null,
      dateOfBirth: map['dateOfBirth'] != null 
          ? DateTime.parse(map['dateOfBirth']) 
          : null,
      address: map['address'],
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.parse(map['createdAt']),
      lastLoginAt: map['lastLoginAt'] != null 
          ? DateTime.parse(map['lastLoginAt']) 
          : null,
    );
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    UserRole? role,
    String? employeeId,
    String? department,
    String? designation,
    String? profileImage,
    DateTime? dateOfJoining,
    DateTime? dateOfBirth,
    String? address,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      employeeId: employeeId ?? this.employeeId,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      profileImage: profileImage ?? this.profileImage,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  // Computed properties
  bool get isEmployee => role == UserRole.employee;
  bool get isManager => role == UserRole.manager;
  bool get isAdmin => role == UserRole.admin;
  bool get isHR => role == UserRole.hr;

  bool get canManageLeaves => isManager || isAdmin || isHR;
  bool get canViewAllEmployees => isManager || isAdmin || isHR;
  bool get canManageTasks => isManager || isAdmin;
  bool get canManageUsers => isAdmin || isHR;

  String get displayName => fullName.isNotEmpty ? fullName : email;
  String get roleDisplayName {
    switch (role) {
      case UserRole.employee:
        return 'Employee';
      case UserRole.manager:
        return 'Manager';
      case UserRole.admin:
        return 'Administrator';
      case UserRole.hr:
        return 'HR Manager';
    }
  }

  int? get age {
    if (dateOfBirth != null) {
      final now = DateTime.now();
      int age = now.year - dateOfBirth!.year;
      if (now.month < dateOfBirth!.month || 
          (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
        age--;
      }
      return age;
    }
    return null;
  }

  int? get yearsOfService {
    if (dateOfJoining != null) {
      final now = DateTime.now();
      int years = now.year - dateOfJoining!.year;
      if (now.month < dateOfJoining!.month || 
          (now.month == dateOfJoining!.month && now.day < dateOfJoining!.day)) {
        years--;
      }
      return years;
    }
    return null;
  }

  // Convert to UserSessionModel
  UserSessionModel toUserSessionModel({AuthStatus authStatus = AuthStatus.authenticated}) {
    return UserSessionModel(
      userId: id,
      email: email,
      fullName: fullName,
      phone: phone,
      role: role,
      profileImage: profileImage,
      employeeId: employeeId,
      department: department,
      designation: designation,
      lastLoginTime: lastLoginAt,
      isActive: isActive,
      authStatus: authStatus,
    );
  }
}
