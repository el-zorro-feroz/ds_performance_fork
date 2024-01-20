import 'package:equatable/equatable.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_history.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';

class SensorInfo extends Equatable {
  final String id;
  final String title;
  final String details;
  final List<SensorHistory> sensorHistoryList;
  final List<Notification> notification;

  const SensorInfo({
    required this.notification,
    required this.id,
    required this.title,
    required this.details,
    required this.sensorHistoryList,
  });

  @override
  List<Object?> get props => [id];
}
