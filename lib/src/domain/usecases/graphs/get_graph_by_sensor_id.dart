import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_data.dart';

class GetGraphBySensorId extends UseCase<Iterable<SensorData>, String> {
  @override
  FutureOr<Either<Failure, Iterable<SensorData>>> call(String param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
