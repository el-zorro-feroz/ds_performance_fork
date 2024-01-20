import 'package:sensors_monitoring/core/enum/alert_type.dart';

class AlertsModel {
  final String id;
  final String sensorId;
  final String ruleId;
  final AlertType type;
  final String message;
  final String title;
  final String description;
  const AlertsModel({
    required this.id,
    required this.sensorId,
    required this.ruleId,
    required this.type,
    required this.message,
    required this.title,
    required this.description,
  });

  AlertsModel copyWith({
    String? id,
    String? sensorId,
    String? ruleId,
    AlertType? type,
    String? message,
    String? title,
    String? description,
  }) {
    return AlertsModel(
      id: id ?? this.id,
      sensorId: sensorId ?? this.sensorId,
      ruleId: ruleId ?? this.ruleId,
      type: type ?? this.type,
      message: message ?? this.message,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sensor_id': sensorId,
      'rule_id': ruleId,
      'type': type.name,
      'message': message,
    };
  }

  factory AlertsModel.fromMap(Map<String, dynamic> map) {
    return AlertsModel(
      id: map['id'] as String,
      sensorId: map['sensor_id'] as String,
      ruleId: map['rule_id'] as String,
      type: AlertType.values.byName(map['type']),
      message: map['message'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  @override
  String toString() {
    return 'AlertsModel(id: $id, sensorId: $sensorId, ruleId: $ruleId, message: $message), title: $title, description: $description';
  }
}
