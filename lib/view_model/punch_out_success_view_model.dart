import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PunchOutSuccessViewModel extends ChangeNotifier {
  String get punchOutTime => DateFormat('hh:mm a').format(DateTime.now());
} 