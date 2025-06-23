class AttendanceCalendarModel {
  final DateTime date;
  final String status; // 'Present', 'Absent', 'Leave', 'Late'
  final String? checkInTime;
  final String? checkOutTime;
  final String? workMode;
  final String? verification;
  final String? location;
  final String? notes;

  AttendanceCalendarModel({
    required this.date,
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    this.workMode,
    this.verification,
    this.location,
    this.notes,
  });
}
