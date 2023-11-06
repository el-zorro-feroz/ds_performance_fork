import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_data.dart';

class TabSensor extends Equatable {
  final String id;
  final List<SensorData> data;

  @override
  List<Object?> get props => [id];

  const TabSensor({
    required this.id,
    required this.data,
  });
}
