import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/model/holiday_model.dart';

class HolidayListViewModel extends ChangeNotifier {
  final List<Holiday> _holidays = [
    Holiday(date: DateTime(2025, 6, 2), title: 'Holiday 1', type: 'Public'),
    Holiday(date: DateTime(2025, 6, 10), title: 'Holiday 2', type: 'Optional'),
    Holiday(date: DateTime(2025, 6, 17), title: 'Holiday 3', type: 'Company'),
    Holiday(date: DateTime(2025, 6, 25), title: 'Holiday 4', type: 'Company'),
  ];

  DateTime _focusedDay = DateTime.now();

  List<Holiday> get holidays => _holidays;
  DateTime get focusedDay => _focusedDay;

  List<Holiday> holidaysForDay(DateTime day) {
    return _holidays.where((h) =>
    h.date.day == day.day &&
        h.date.month == day.month &&
        h.date.year == day.year
    ).toList();
  }

  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  int get totalHolidays => _holidays.length;

  List<Holiday> get upcomingHolidays {
    return _holidays.where((h) => h.date.isAfter(DateTime.now())).toList();
  }
}
