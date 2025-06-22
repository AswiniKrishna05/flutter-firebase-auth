enum LeaveType {
  sick,
  casual,
  emergency,
  annual,
}

enum LeaveStatus {
  pending,
  approved,
  rejected,
  cancelled,
}

enum LeaveDuration {
  fullDay,
  halfDay,
  shortLeave,
}

class LeaveModel {
  final String id;
  final String employeeId;
  final String employeeName;
  final DateTime fromDate;
  final DateTime toDate;
  final LeaveType leaveType;
  final LeaveDuration duration;
  final String reason;
  final String? attachment;
  final LeaveStatus status;
  final DateTime appliedDate;
  final DateTime? approvedDate;
  final String? approvedBy;
  final String? rejectionReason;

  LeaveModel({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
    required this.duration,
    required this.reason,
    this.attachment,
    this.status = LeaveStatus.pending,
    required this.appliedDate,
    this.approvedDate,
    this.approvedBy,
    this.rejectionReason,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'leaveType': leaveType.name,
      'duration': duration.name,
      'reason': reason,
      'attachment': attachment,
      'status': status.name,
      'appliedDate': appliedDate.toIso8601String(),
      'approvedDate': approvedDate?.toIso8601String(),
      'approvedBy': approvedBy,
      'rejectionReason': rejectionReason,
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
      id: map['id'] ?? '',
      employeeId: map['employeeId'] ?? '',
      employeeName: map['employeeName'] ?? '',
      fromDate: DateTime.parse(map['fromDate']),
      toDate: DateTime.parse(map['toDate']),
      leaveType: LeaveType.values.firstWhere(
        (e) => e.name == map['leaveType'],
        orElse: () => LeaveType.casual,
      ),
      duration: LeaveDuration.values.firstWhere(
        (e) => e.name == map['duration'],
        orElse: () => LeaveDuration.fullDay,
      ),
      reason: map['reason'] ?? '',
      attachment: map['attachment'],
      status: LeaveStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => LeaveStatus.pending,
      ),
      appliedDate: DateTime.parse(map['appliedDate']),
      approvedDate: map['approvedDate'] != null 
          ? DateTime.parse(map['approvedDate']) 
          : null,
      approvedBy: map['approvedBy'],
      rejectionReason: map['rejectionReason'],
    );
  }

  LeaveModel copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    DateTime? fromDate,
    DateTime? toDate,
    LeaveType? leaveType,
    LeaveDuration? duration,
    String? reason,
    String? attachment,
    LeaveStatus? status,
    DateTime? appliedDate,
    DateTime? approvedDate,
    String? approvedBy,
    String? rejectionReason,
  }) {
    return LeaveModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      leaveType: leaveType ?? this.leaveType,
      duration: duration ?? this.duration,
      reason: reason ?? this.reason,
      attachment: attachment ?? this.attachment,
      status: status ?? this.status,
      appliedDate: appliedDate ?? this.appliedDate,
      approvedDate: approvedDate ?? this.approvedDate,
      approvedBy: approvedBy ?? this.approvedBy,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  int get numberOfDays {
    return toDate.difference(fromDate).inDays + 1;
  }

  bool get isPending => status == LeaveStatus.pending;
  bool get isApproved => status == LeaveStatus.approved;
  bool get isRejected => status == LeaveStatus.rejected;
  bool get isCancelled => status == LeaveStatus.cancelled;
} 