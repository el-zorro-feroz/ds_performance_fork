import 'package:equatable/equatable.dart';

class NotificationData extends Equatable {
  final NotificationType type;
  final String title;
  final String description;
  final DateTime datetime;

  const NotificationData({
    required this.type,
    required this.title,
    required this.description,
    required this.datetime,
  });

  @override
  List<Object?> get props => [datetime];
}

enum NotificationType { info, warning, error }
