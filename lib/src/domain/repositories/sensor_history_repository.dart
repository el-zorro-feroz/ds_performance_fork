import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_data.dart';
import 'package:sensors_monitoring/src/domain/usecases/graphs/get_graph_history_by_sensor_id.dart';

abstract class SensorHistoryRepository {
  Future<Either<Failure, List<SensorHistory>>> getSensorHistory({required GetSensorHistoryParams param});
}
