enum UserRole {
  employee,
  manager,
  admin,
  hr,
}

enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
  error,
}

class UserSessionModel {
  final String userId;
  final String email;
  final String fullName;
  final String phone;
  final UserRole role;
  final String? profileImage;
  final String? employeeId;
  final String? department;
  final String? designation;
  final DateTime? lastLoginTime;
  final bool isActive;
  final AuthStatus authStatus;
  final String? errorMessage;

  UserSessionModel({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.role,
    this.profileImage,
    this.employeeId,
    this.department,
    this.designation,
    this.lastLoginTime,
    this.isActive = true,
    this.authStatus = AuthStatus.unauthenticated,
    this.errorMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'role': role.name,
      'profileImage': profileImage,
      'employeeId': employeeId,
      'department': department,
      'designation': designation,
      'lastLoginTime': lastLoginTime?.toIso8601String(),
      'isActive': isActive,
      'authStatus': authStatus.name,
      'errorMessage': errorMessage,
    };
  }

  factory UserSessionModel.fromMap(Map<String, dynamic> map) {
    return UserSessionModel(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => UserRole.employee,
      ),
      profileImage: map['profileImage'],
      employeeId: map['employeeId'],
      department: map['department'],
      designation: map['designation'],
      lastLoginTime: map['lastLoginTime'] != null 
          ? DateTime.parse(map['lastLoginTime']) 
          : null,
      isActive: map['isActive'] ?? true,
      authStatus: AuthStatus.values.firstWhere(
        (e) => e.name == map['authStatus'],
        orElse: () => AuthStatus.unauthenticated,
      ),
      errorMessage: map['errorMessage'],
    );
  }

  UserSessionModel copyWith({
    String? userId,
    String? email,
    String? fullName,
    String? phone,
    UserRole? role,
    String? profileImage,
    String? employeeId,
    String? department,
    String? designation,
    DateTime? lastLoginTime,
    bool? isActive,
    AuthStatus? authStatus,
    String? errorMessage,
  }) {
    return UserSessionModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      employeeId: employeeId ?? this.employeeId,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      isActive: isActive ?? this.isActive,
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Computed properties
  bool get isAuthenticated => authStatus == AuthStatus.authenticated;
  bool get isLoading => authStatus == AuthStatus.loading;
  bool get hasError => authStatus == AuthStatus.error;
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
}

class AuthCredentials {
  final String email;
  final String password;
  final String? phone;

  AuthCredentials({
    required this.email,
    required this.password,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  factory AuthCredentials.fromMap(Map<String, dynamic> map) {
    return AuthCredentials(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'],
    );
  }
}

class PasswordResetRequest {
  final String email;
  final DateTime requestedAt;
  final bool isProcessed;

  PasswordResetRequest({
    required this.email,
    required this.requestedAt,
    this.isProcessed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'requestedAt': requestedAt.toIso8601String(),
      'isProcessed': isProcessed,
    };
  }

  factory PasswordResetRequest.fromMap(Map<String, dynamic> map) {
    return PasswordResetRequest(
      email: map['email'] ?? '',
      requestedAt: DateTime.parse(map['requestedAt']),
      isProcessed: map['isProcessed'] ?? false,
    );
  }
} 