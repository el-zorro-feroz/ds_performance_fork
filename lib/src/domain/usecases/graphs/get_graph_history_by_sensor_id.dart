import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/enum/graph_dependency.dart';
import 'package:sensors_monitoring/core/enum/graph_type.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_history.dart';

class GetGraphHitsoryBySensorId extends UseCase<Iterable<SensorHistory>, GetSensorHistoryParams> {
  @override
  FutureOr<Either<Failure, Iterable<SensorHistory>>> call(GetSensorHistoryParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetSensorHistoryParams {
  final String id;
  final GraphDependency graphDependency;
  final GraphType graphType;
  final DateTime dateTime;

  GetSensorHistoryParams({
    required this.graphType,
    required this.id,
    required this.graphDependency,
    required this.dateTime,
  });
}
