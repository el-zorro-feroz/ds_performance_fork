import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_history.dart';

class SensorInfo extends Equatable {
  final String id;
  final String title;
  final String details;
  final List<SensorHistory> sensorHistoryList;

  const SensorInfo({
    required this.id,
    required this.title,
    required this.details,
    required this.sensorHistoryList,
  });

  @override
  List<Object?> get props => [id];
}
