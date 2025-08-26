import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PunchInSuccessViewModel extends ChangeNotifier {
  bool _isPunchedIn = false;
  DateTime? _punchInTime;

  bool get isPunchedIn => _isPunchedIn;
  DateTime? get punchInTime => _punchInTime;

  String get punchInTimeFormatted {
    if (_punchInTime == null) return '';
    return DateFormat('hh:mm a').format(_punchInTime!);
  }

  // Load punch state from SharedPreferences
  Future<void> loadPunchState() async {
    final prefs = await SharedPreferences.getInstance();
    _isPunchedIn = prefs.getBool('isPunchedIn') ?? false;
    final storedTime = prefs.getString('punchInTime');
    if (storedTime != null) {
      _punchInTime = DateTime.tryParse(storedTime);
    }
    notifyListeners();
  }

  // Save punch state to SharedPreferences
  Future<void> savePunchState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPunchedIn', _isPunchedIn);
    if (_punchInTime != null) {
      await prefs.setString('punchInTime', _punchInTime!.toIso8601String());
    }
  }

  void punchIn() {
    _isPunchedIn = true;
    _punchInTime = DateTime.now();
    savePunchState();
    notifyListeners();
  }

  void punchOut() {
    _isPunchedIn = false;
    _punchInTime = null;
    savePunchState();
    notifyListeners();
  }

  // Format time for display
  String formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final suffix = hour >= 12 ? 'pm' : 'am';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12:$minute $suffix';
  }

  // Format date for display
  String formatDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    return '$day-$month-$year';
  }
}
