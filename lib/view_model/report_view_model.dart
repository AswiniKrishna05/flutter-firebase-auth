import 'package:flutter/material.dart';
import '../model/report_model.dart';

class ReportViewModel extends ChangeNotifier {
  List<ReportData> reportSummary = [
    ReportData(title: 'Total Working Days', value: '22 days', icon: Icons.calendar_today),
    ReportData(title: 'Total Hours Worked', value: '145 hrs', icon: Icons.hourglass_bottom),
    ReportData(title: 'Tasks Completed', value: '35', icon: Icons.check_circle_outline),
    ReportData(title: 'Average Daily Hours', value: '6.6 hrs/day', icon: Icons.access_alarm),
  ];

  List<AttendanceLog> attendanceLogs = [
    AttendanceLog(date: 'June 21', checkIn: '09:15 AM', checkOut: '05:45 PM', totalHours: '8.5 hrs', status: 'Present'),
    AttendanceLog(date: 'June 22', checkIn: '--', checkOut: '--', totalHours: '0 hrs', status: 'Absent'),
    AttendanceLog(date: 'June 23', checkIn: '09:30 AM', checkOut: '04:00 PM', totalHours: '6.5 hrs', status: 'Half Day'),
  ];

  // ✅ Add these lists for chart data
  final List<double> _presentData = [6.8, 7.2, 7, 6.9, 7.1, 7, 7.3, 7.1, 7.2, 7, 7.1, 7];
  final List<double> _absentData = [5.5, 6, 6.5, 5.8, 6.2, 6, 6.3, 6.1, 6.4, 6, 6.2, 6.1];
  final List<double> _avgHoursData = [6.5, 7, 6, 7.5, 6.8, 7, 6.5, 7, 6, 7, 6.5, 7];


  // ✅ Public Getters
  List<double> get presentData => _presentData;
  List<double> get absentData => _absentData;
  List<double> get avgHoursData => _avgHoursData;

  get attendanceChartData => null;
}
