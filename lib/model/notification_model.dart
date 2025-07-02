class NotificationModel {
  final String title;
  final String message;
  final String type; // e.g. 'error', 'info', 'success'

  NotificationModel({
    required this.title,
    required this.message,
    required this.type,
  });
}
