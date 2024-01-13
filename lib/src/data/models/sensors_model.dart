import 'package:sensors_monitoring/core/enum/sensor_type.dart';

class SensorsModel {
  final String id;
  final String configId;
  final String title;
  final SensorType sensorType;
  final String details;

  const SensorsModel({
    required this.id,
    required this.configId,
    required this.title,
    required this.sensorType,
    required this.details,
  });

  SensorsModel copyWith({
    String? id,
    String? configId,
    String? title,
    SensorType? sensorType,
    String? details,
  }) {
    return SensorsModel(
      id: id ?? this.id,
      configId: configId ?? this.configId,
      title: title ?? this.title,
      sensorType: sensorType ?? this.sensorType,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'configId': configId,
      'title': title,
      'sensorType': sensorType.name,
      'details': details,
    };
  }

  factory SensorsModel.fromMap(Map<String, dynamic> map) {
    return SensorsModel(
      id: map['id'] as String,
      configId: map['config_id'] as String,
      title: map['title'] as String,
      sensorType: SensorType.values.byName(map['type']),
      details: map['details'] as String,
    );
  }

  @override
  String toString() {
    return 'SensorModel(id: $id, configId: $configId, title: $title, sensorType: $sensorType, details: $details)';
  }
}
