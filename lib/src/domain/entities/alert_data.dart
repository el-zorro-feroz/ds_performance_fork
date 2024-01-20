import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';

class AlertData extends Equatable {
  final String title;
  final String message;
  final String description;
  final AlertType type;
  final List<SensorRule> sensorRuleList;

  const AlertData({
    required this.title,
    required this.message,
    required this.description,
    required this.type,
    required this.sensorRuleList,
  });

  @override
  List<Object?> get props => [];
}
