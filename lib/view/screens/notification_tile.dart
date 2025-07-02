import 'package:flutter/material.dart';
import '../../model/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({super.key, required this.notification});

  Color _getColor(String type) {
    switch (type) {
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'success':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'error':
        return Icons.close;
      case 'warning':
        return Icons.access_time;
      case 'success':
        return Icons.check;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(notification.type);
    final icon = _getIcon(notification.type);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // <-- You can change this value
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns top of icon and text
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12), // Space between icon and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      color: color,fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(notification.message),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
