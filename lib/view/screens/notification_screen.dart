import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/notification_view_model.dart';
import 'notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notificationVM.notifications.length,
        itemBuilder: (context, index) {
          final notification = notificationVM.notifications[index];
          return NotificationTile(notification: notification);
        },
      ),
    );
  }
}
