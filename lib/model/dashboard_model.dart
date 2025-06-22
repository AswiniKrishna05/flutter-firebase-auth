import 'package:flutter/material.dart';

class DashboardStatsModel {
  final int totalEmployees;
  final int presentToday;
  final int absentToday;
  final int onLeaveToday;
  final int lateToday;
  final double attendancePercentage;
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
  final int overdueTasks;
  final double taskCompletionRate;

  DashboardStatsModel({
    required this.totalEmployees,
    required this.presentToday,
    required this.absentToday,
    required this.onLeaveToday,
    required this.lateToday,
    required this.attendancePercentage,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.overdueTasks,
    required this.taskCompletionRate,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalEmployees': totalEmployees,
      'presentToday': presentToday,
      'absentToday': absentToday,
      'onLeaveToday': onLeaveToday,
      'lateToday': lateToday,
      'attendancePercentage': attendancePercentage,
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'pendingTasks': pendingTasks,
      'overdueTasks': overdueTasks,
      'taskCompletionRate': taskCompletionRate,
    };
  }

  factory DashboardStatsModel.fromMap(Map<String, dynamic> map) {
    return DashboardStatsModel(
      totalEmployees: map['totalEmployees'] ?? 0,
      presentToday: map['presentToday'] ?? 0,
      absentToday: map['absentToday'] ?? 0,
      onLeaveToday: map['onLeaveToday'] ?? 0,
      lateToday: map['lateToday'] ?? 0,
      attendancePercentage: (map['attendancePercentage'] ?? 0.0).toDouble(),
      totalTasks: map['totalTasks'] ?? 0,
      completedTasks: map['completedTasks'] ?? 0,
      pendingTasks: map['pendingTasks'] ?? 0,
      overdueTasks: map['overdueTasks'] ?? 0,
      taskCompletionRate: (map['taskCompletionRate'] ?? 0.0).toDouble(),
    );
  }

  int get totalPresent => presentToday + lateToday;
  int get totalAbsent => absentToday + onLeaveToday;
}

class LeaveSummaryModel {
  final int totalLeaveDays;
  final int leaveDaysTaken;
  final int remainingDays;
  final Map<String, int> leaveByType; // Leave type -> count
  final List<LeaveSummaryItem> upcomingLeaves;

  LeaveSummaryModel({
    required this.totalLeaveDays,
    required this.leaveDaysTaken,
    required this.remainingDays,
    required this.leaveByType,
    required this.upcomingLeaves,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalLeaveDays': totalLeaveDays,
      'leaveDaysTaken': leaveDaysTaken,
      'remainingDays': remainingDays,
      'leaveByType': leaveByType,
      'upcomingLeaves': upcomingLeaves.map((e) => e.toMap()).toList(),
    };
  }

  factory LeaveSummaryModel.fromMap(Map<String, dynamic> map) {
    return LeaveSummaryModel(
      totalLeaveDays: map['totalLeaveDays'] ?? 0,
      leaveDaysTaken: map['leaveDaysTaken'] ?? 0,
      remainingDays: map['remainingDays'] ?? 0,
      leaveByType: Map<String, int>.from(map['leaveByType'] ?? {}),
      upcomingLeaves: (map['upcomingLeaves'] as List?)
          ?.map((e) => LeaveSummaryItem.fromMap(e))
          .toList() ?? [],
    );
  }

  double get leaveUtilizationRate => totalLeaveDays > 0 ? leaveDaysTaken / totalLeaveDays : 0.0;
}

class LeaveSummaryItem {
  final String id;
  final String leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final int numberOfDays;
  final String status;

  LeaveSummaryItem({
    required this.id,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.numberOfDays,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'leaveType': leaveType,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'numberOfDays': numberOfDays,
      'status': status,
    };
  }

  factory LeaveSummaryItem.fromMap(Map<String, dynamic> map) {
    return LeaveSummaryItem(
      id: map['id'] ?? '',
      leaveType: map['leaveType'] ?? '',
      fromDate: DateTime.parse(map['fromDate']),
      toDate: DateTime.parse(map['toDate']),
      numberOfDays: map['numberOfDays'] ?? 0,
      status: map['status'] ?? '',
    );
  }

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
}

class WorkSummaryModel {
  final DateTime date;
  final Duration totalWorkingHours;
  final Duration averageWorkingHours;
  final int totalPunchIns;
  final int totalPunchOuts;
  final List<WorkSummaryItem> dailySummary;

  WorkSummaryModel({
    required this.date,
    required this.totalWorkingHours,
    required this.averageWorkingHours,
    required this.totalPunchIns,
    required this.totalPunchOuts,
    required this.dailySummary,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'totalWorkingHours': totalWorkingHours.inMinutes,
      'averageWorkingHours': averageWorkingHours.inMinutes,
      'totalPunchIns': totalPunchIns,
      'totalPunchOuts': totalPunchOuts,
      'dailySummary': dailySummary.map((e) => e.toMap()).toList(),
    };
  }

  factory WorkSummaryModel.fromMap(Map<String, dynamic> map) {
    return WorkSummaryModel(
      date: DateTime.parse(map['date']),
      totalWorkingHours: Duration(minutes: map['totalWorkingHours'] ?? 0),
      averageWorkingHours: Duration(minutes: map['averageWorkingHours'] ?? 0),
      totalPunchIns: map['totalPunchIns'] ?? 0,
      totalPunchOuts: map['totalPunchOuts'] ?? 0,
      dailySummary: (map['dailySummary'] as List?)
          ?.map((e) => WorkSummaryItem.fromMap(e))
          .toList() ?? [],
    );
  }
}

class WorkSummaryItem {
  final String employeeId;
  final String employeeName;
  final DateTime? punchInTime;
  final DateTime? punchOutTime;
  final Duration? workingHours;
  final String status;

  WorkSummaryItem({
    required this.employeeId,
    required this.employeeName,
    this.punchInTime,
    this.punchOutTime,
    this.workingHours,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'punchInTime': punchInTime?.toIso8601String(),
      'punchOutTime': punchOutTime?.toIso8601String(),
      'workingHours': workingHours?.inMinutes,
      'status': status,
    };
  }

  factory WorkSummaryItem.fromMap(Map<String, dynamic> map) {
    return WorkSummaryItem(
      employeeId: map['employeeId'] ?? '',
      employeeName: map['employeeName'] ?? '',
      punchInTime: map['punchInTime'] != null 
          ? DateTime.parse(map['punchInTime']) 
          : null,
      punchOutTime: map['punchOutTime'] != null 
          ? DateTime.parse(map['punchOutTime']) 
          : null,
      workingHours: map['workingHours'] != null 
          ? Duration(minutes: map['workingHours']) 
          : null,
      status: map['status'] ?? '',
    );
  }

  bool get isPresent => status == 'present';
  bool get isAbsent => status == 'absent';
  bool get isLate => status == 'late';
  bool get isOnLeave => status == 'leave';
} 