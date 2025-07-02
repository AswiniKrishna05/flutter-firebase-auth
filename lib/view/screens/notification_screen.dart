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
      body: Stack(
        children: [
          // Close Icon at maximum top-right
          Positioned(
            top: 28, // Safe distance from status bar
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 20),
              onPressed: () {
                Navigator.pop(context); // Closes the current screen
              },
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.only(top: 60.0), // Space for the close icon
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Notification",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: notificationVM.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notificationVM.notifications[index];
                      return NotificationTile(notification: notification);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
