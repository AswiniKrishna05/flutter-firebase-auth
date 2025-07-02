import 'package:flutter/material.dart';
import '../model/notification_model.dart';

class NotificationViewModel extends ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: 'Missed Punch',
      message: 'Missed Clock-in Detected. Please update your attendance or contact HR.',
      type: 'error',
    ),
    NotificationModel(
      title: 'Late Attendance',
      message: 'You’re running late! Your clock-in time is beyond the scheduled shift start.',
      type: 'warning',
    ),
    NotificationModel(
      title: 'Daily Summary',
      message: 'Your attendance today: Clock-in at 9:12 AM, Clock-out at 6:05 PM. Total hours: 8.53',
      type: 'info',
    ),
    NotificationModel(
      title: 'Leave Approved',
      message: 'Your leave request for June 15 has been approved. Enjoy your day off!',
      type: 'success',
    ),
    NotificationModel(
      title: 'Leave Rejection',
      message: 'Leave request declined. Please check with your manager for details.',
      type: 'error',
    ),
    NotificationModel(
      title: 'Shift Update',
      message: 'Shift updated: New shift time is 10:00 AM – 7:00 PM, effective from June 14.',
      type: 'info',
    ),
  ];

  List<NotificationModel> get notifications => _notifications;
}
