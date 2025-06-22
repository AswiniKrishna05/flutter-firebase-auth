enum PunchType {
  punchIn,
  punchOut,
}

enum AttendanceStatus {
  present,
  absent,
  late,
  halfDay,
  leave,
}

class AttendanceModel {
  final String id;
  final String employeeId;
  final String employeeName;
  final DateTime date;
  final DateTime? punchInTime;
  final DateTime? punchOutTime;
  final AttendanceStatus status;
  final String? location;
  final String? deviceId;
  final String? notes;
  final bool isVerified;

  AttendanceModel({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.date,
    this.punchInTime,
    this.punchOutTime,
    this.status = AttendanceStatus.absent,
    this.location,
    this.deviceId,
    this.notes,
    this.isVerified = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'date': date.toIso8601String(),
      'punchInTime': punchInTime?.toIso8601String(),
      'punchOutTime': punchOutTime?.toIso8601String(),
      'status': status.name,
      'location': location,
      'deviceId': deviceId,
      'notes': notes,
      'isVerified': isVerified,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] ?? '',
      employeeId: map['employeeId'] ?? '',
      employeeName: map['employeeName'] ?? '',
      date: DateTime.parse(map['date']),
      punchInTime: map['punchInTime'] != null 
          ? DateTime.parse(map['punchInTime']) 
          : null,
      punchOutTime: map['punchOutTime'] != null 
          ? DateTime.parse(map['punchOutTime']) 
          : null,
      status: AttendanceStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => AttendanceStatus.absent,
      ),
      location: map['location'],
      deviceId: map['deviceId'],
      notes: map['notes'],
      isVerified: map['isVerified'] ?? false,
    );
  }

  AttendanceModel copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    DateTime? date,
    DateTime? punchInTime,
    DateTime? punchOutTime,
    AttendanceStatus? status,
    String? location,
    String? deviceId,
    String? notes,
    bool? isVerified,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      date: date ?? this.date,
      punchInTime: punchInTime ?? this.punchInTime,
      punchOutTime: punchOutTime ?? this.punchOutTime,
      status: status ?? this.status,
      location: location ?? this.location,
      deviceId: deviceId ?? this.deviceId,
      notes: notes ?? this.notes,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  // Computed properties
  Duration? get workingHours {
    if (punchInTime != null && punchOutTime != null) {
      return punchOutTime!.difference(punchInTime!);
    }
    return null;
  }

  bool get isPresent => status == AttendanceStatus.present;
  bool get isAbsent => status == AttendanceStatus.absent;
  bool get isLate => status == AttendanceStatus.late;
  bool get isHalfDay => status == AttendanceStatus.halfDay;
  bool get isOnLeave => status == AttendanceStatus.leave;

  bool get hasPunchedIn => punchInTime != null;
  bool get hasPunchedOut => punchOutTime != null;
  bool get isCurrentlyWorking => hasPunchedIn && !hasPunchedOut;
}

class PunchRecordModel {
  final String id;
  final String employeeId;
  final PunchType punchType;
  final DateTime timestamp;
  final String? location;
  final String? deviceId;
  final String? verificationMethod; // QR, Face, Manual
  final bool isVerified;

  PunchRecordModel({
    required this.id,
    required this.employeeId,
    required this.punchType,
    required this.timestamp,
    this.location,
    this.deviceId,
    this.verificationMethod,
    this.isVerified = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId,
      'punchType': punchType.name,
      'timestamp': timestamp.toIso8601String(),
      'location': location,
      'deviceId': deviceId,
      'verificationMethod': verificationMethod,
      'isVerified': isVerified,
    };
  }

  factory PunchRecordModel.fromMap(Map<String, dynamic> map) {
    return PunchRecordModel(
      id: map['id'] ?? '',
      employeeId: map['employeeId'] ?? '',
      punchType: PunchType.values.firstWhere(
        (e) => e.name == map['punchType'],
        orElse: () => PunchType.punchIn,
      ),
      timestamp: DateTime.parse(map['timestamp']),
      location: map['location'],
      deviceId: map['deviceId'],
      verificationMethod: map['verificationMethod'],
      isVerified: map['isVerified'] ?? false,
    );
  }

  bool get isPunchIn => punchType == PunchType.punchIn;
  bool get isPunchOut => punchType == PunchType.punchOut;
} 