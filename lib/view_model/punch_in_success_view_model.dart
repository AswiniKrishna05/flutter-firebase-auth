import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PunchInSuccessViewModel extends ChangeNotifier {
  String get currentTime => DateFormat('hh:mm a').format(DateTime.now());
} 