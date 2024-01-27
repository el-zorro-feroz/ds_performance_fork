import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';

class TabSensor {
  final String id;
  final List<SensorInfo> sensorList;

  TabSensor({
    required this.id,
    required this.sensorList,
  });
}
