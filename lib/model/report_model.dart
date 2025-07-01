class ReportData {
  final String title;
  final String value;
  final String? subtitle;
  final dynamic icon;

  ReportData({
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
  });
}

class AttendanceLog {
  final String date;
  final String checkIn;
  final String checkOut;
  final String totalHours;
  final String status;

  AttendanceLog({
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.totalHours,
    required this.status,
  });
}

