import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_data.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';

class Tab extends Equatable {
  final String id;
  final String title;
  final List<SensorInfo> sensorInfoList;
  final List<SensorHistory> sensorDataList;
  const Tab({
    required this.sensorDataList,
    required this.sensorInfoList,
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
