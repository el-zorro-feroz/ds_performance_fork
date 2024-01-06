class NotificationData {
  final NotificationType type;
  final String title;
  final String description;

  const NotificationData({
    required this.type,
    required this.title,
    required this.description,
  });
}

enum NotificationType { info, warning, error }
