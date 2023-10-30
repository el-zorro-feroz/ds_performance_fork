import 'package:sensors_monitoring/src/data/models/enum/sensor_type.dart';

class SensorsModel {
  final String id;
  final String configId;
  final String title;
  final SensorType sensorType;

  const SensorsModel({
    required this.id,
    required this.configId,
    required this.title,
    required this.sensorType,
  });

  SensorsModel copyWith({
    String? id,
    String? configId,
    String? title,
    SensorType? sensorType,
  }) {
    return SensorsModel(
      id: id ?? this.id,
      configId: configId ?? this.configId,
      title: title ?? this.title,
      sensorType: sensorType ?? this.sensorType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'configId': configId,
      'title': title,
      'sensorType': sensorType.name,
    };
  }

  factory SensorsModel.fromMap(Map<String, dynamic> map) {
    return SensorsModel(
      id: map['id'] as String,
      configId: map['configId'] as String,
      title: map['title'] as String,
      sensorType: SensorType.values.where((element) => element == map['type']).first,
    );
  }

  @override
  String toString() {
    return 'SensorModel(id: $id, configId: $configId, title: $title, sensorType: $sensorType)';
  }
}
