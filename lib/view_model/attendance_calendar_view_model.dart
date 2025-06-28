import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/attendance_calendar_model.dart';

class AttendanceCalendarViewModel extends ChangeNotifier {
  List<AttendanceCalendarModel> attendanceList = [];

  int presentCount = 0;
  int absentCount = 0;
  int leaveCount = 0;
  int lateCount = 0;

  AttendanceCalendarModel? selected;

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  CalendarFormat calendarFormat = CalendarFormat.month;

  AttendanceCalendarViewModel() {
    _loadDummyData();
    selectedDay = DateTime.now();
  }

  void _loadDummyData() {
    attendanceList = [
      AttendanceCalendarModel(
        date: DateTime(2025, 6, 18),
        status: 'Present',
        checkInTime: '9:30 AM',
        checkOutTime: '06:00 PM',
        workMode: 'Office',
        verification: 'Selfie',
        location: 'Lat: 13.05, Long: 80.24',
        notes: 'Worked On UI Bug Fixing',
      ),
      AttendanceCalendarModel(
        date: DateTime(2025, 6, 20),
        status: 'Absent',
        checkInTime: null,
        checkOutTime: null,
        workMode: null,
        verification: null,
        location: null,
        notes: null,
      ),
    ];
    _calculateStats();
    selected = attendanceList.first;
  }

  void _calculateStats() {
    presentCount = attendanceList.where((e) => e.status == 'Present').length;
    absentCount = attendanceList.where((e) => e.status == 'Absent').length;
    leaveCount = attendanceList.where((e) => e.status == 'Leave').length;
    lateCount = attendanceList.where((e) => e.status == 'Late').length;
    notifyListeners();
  }

  void selectDay(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;
    selectDate(selectedDay);
  }

  void selectDate(DateTime date) {
    try {
      selected = attendanceList.firstWhere(
        (e) =>
            e.date.year == date.year &&
            e.date.month == date.month &&
            e.date.day == date.day,
      );
    } catch (e) {
      selected = null;
    }
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat = format;
    notifyListeners();
  }

  void onPageChanged(DateTime date) {
    focusedDay = date;
    notifyListeners();
  }

  void previousMonth() {
    focusedDay = DateTime(focusedDay.year, focusedDay.month - 1, 1);
    notifyListeners();
  }

  void nextMonth() {
    focusedDay = DateTime(focusedDay.year, focusedDay.month + 1, 1);
    notifyListeners();
  }

  List<String> getEventsForDay(DateTime day) {
    final match = attendanceList.firstWhere(
      (e) =>
          e.date.year == day.year &&
          e.date.month == day.month &&
          e.date.day == day.day,
      orElse: () => AttendanceCalendarModel(
        date: day,
        status: '',
        checkInTime: null,
        checkOutTime: null,
        workMode: null,
        verification: null,
        location: null,
        notes: null,
      ),
    );
    return match.status.isNotEmpty ? [match.status] : [];
  }

  String? getStatusForDate(DateTime date) {
    try {
      return attendanceList
          .firstWhere(
            (e) =>
                e.date.year == date.year &&
                e.date.month == date.month &&
                e.date.day == date.day,
          )
          .status;
    } catch (e) {
      return null;
    }
  }
}
