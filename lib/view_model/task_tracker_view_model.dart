import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTrackerViewModel extends ChangeNotifier {
  String getRemainingDays(String dueDate) {
    final due = DateFormat('dd-MM-yyyy').parse(dueDate);
    final today = DateTime.now();
    final difference = due.difference(today).inDays;
    return '$difference days\nremaining';
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'not started':
        return Colors.grey;
      case 'in progress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void onStartPressed() {
    // Implement start logic
    notifyListeners();
  }

  void onUpdatePressed() {
    // Implement update logic
    notifyListeners();
  }

  void onCompletePressed() {
    // Implement complete logic
    notifyListeners();
  }
} 