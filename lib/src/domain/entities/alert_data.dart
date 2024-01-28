import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';

class AlertData extends Equatable {
  final String id;
  final String title;
  final String message;
  final String description;
  final AlertType type;
  final List<SensorRule> sensorRuleList;

  const AlertData({
    required this.id,
    required this.title,
    required this.message,
    required this.description,
    required this.type,
    required this.sensorRuleList,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        message,
        description,
        type,
        sensorRuleList,
      ];

  AlertData copyWith({
    String? id,
    String? title,
    String? message,
    String? description,
    AlertType? type,
    List<SensorRule>? sensorRuleList,
  }) {
    return AlertData(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      description: description ?? this.description,
      type: type ?? this.type,
      sensorRuleList: sensorRuleList ?? this.sensorRuleList,
    );
  }
}
