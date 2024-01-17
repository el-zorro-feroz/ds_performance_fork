import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';

class AlertData extends Equatable {
  final AlertType type;
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
