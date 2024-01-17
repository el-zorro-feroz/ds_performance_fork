import 'package:equatable/equatable.dart';

class AlertData extends Equatable {
  final NotificationType type;
  final String title;
  final String description;
  final DateTime datetime;

  const AlertData({
    required this.type,
    required this.title,
    required this.description,
    required this.datetime,
  });

  @override
  List<Object?> get props => [datetime];
}

enum NotificationType { info, warning, error }
