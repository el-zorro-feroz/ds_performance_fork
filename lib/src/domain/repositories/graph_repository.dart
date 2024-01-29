import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_history.dart';
import 'package:sensors_monitoring/src/domain/usecases/graphs/get_graph_history_by_sensor_id.dart';

abstract class GraphRepository {
  Future<Either<Failure, Iterable<SensorHistory>>> getGraphHistoryBySensorId(GetSensorHistoryParams id);
}
