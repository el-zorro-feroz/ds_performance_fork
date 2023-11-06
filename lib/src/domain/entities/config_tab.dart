import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_data.dart';

class ConfigTab extends Equatable {
  final String id;
  final String title;
  final List<SensorData> data;

  @override
  List<Object?> get props => [id];

  const ConfigTab({
    required this.id,
    required this.title,
    required this.data,
  });
}
