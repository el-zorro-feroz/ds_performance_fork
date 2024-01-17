import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/enum/graph_dependency.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_data.dart';

class GetSensorHistory extends UseCase<List<SensorData>, GetSensorHistoryParams> {
  @override
  FutureOr<Either<Failure, List<SensorData>>> call(GetSensorHistoryParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetSensorHistoryParams {
  final String id;
  final GraphDependency graphDependency;
  final DateTime dateTime;

  GetSensorHistoryParams({
    required this.id,
    required this.graphDependency,
    required this.dateTime,
  });
}
