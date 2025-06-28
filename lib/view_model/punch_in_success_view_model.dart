import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PunchInSuccessViewModel extends ChangeNotifier {
  bool _isPunchedIn = false;
  DateTime? _punchInTime;

  bool get isPunchedIn => _isPunchedIn;

  String get punchInTimeFormatted {
    if (_punchInTime == null) return '';
    return DateFormat('hh:mm a').format(_punchInTime!);
  }

  void punchIn() {
    _isPunchedIn = true;
    _punchInTime = DateTime.now();
    notifyListeners();
  }

  void punchOut() {
    _isPunchedIn = false;
    _punchInTime = null;
    notifyListeners();
  }
}
