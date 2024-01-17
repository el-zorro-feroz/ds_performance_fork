import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/usecases/sensor_history/get_sensor_history.dart';

abstract class SensorHistoryRepository {
  Future<Either<Failure, List<SensorHistoryRepository>>> getSensorHistory({required GetSensorHistoryParams param});
}
