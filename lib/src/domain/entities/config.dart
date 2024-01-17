import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';

class Config extends Equatable {
  final String id;
  final String title;
  final List<Tab> tabList;
  // final List<TabSensor> tabSensorList;
  final List<SensorInfo> sensorList;

  const Config({
    required this.id,
    required this.title,
    required this.tabList,
    // required this.tabSensorList,
    required this.sensorList,
  });

  @override
  List<Object?> get props => [id];
}
