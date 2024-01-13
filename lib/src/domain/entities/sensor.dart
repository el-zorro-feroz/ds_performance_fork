import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';

class Sensor extends Equatable {
  final String id;
  final String configId;
  final String title;
  final SensorType sensorType;
  final String details;

  const Sensor({
    required this.id,
    required this.configId,
    required this.title,
    required this.sensorType,
    required this.details,
  });

  @override
  List<Object?> get props => [id];
}
