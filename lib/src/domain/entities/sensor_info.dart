import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_history.dart';

class SensorInfo extends Equatable {
  final String id;
  final String title;
  final String details;
  final SensorType sensorType;
  final List<SensorHistory> sensorHistoryList;
  final List<AlertData> alerts;

  const SensorInfo({
    required this.id,
    required this.title,
    required this.details,
    required this.sensorType,
    required this.sensorHistoryList,
    required this.alerts,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        details,
        sensorType,
        alerts,
      ];
}
