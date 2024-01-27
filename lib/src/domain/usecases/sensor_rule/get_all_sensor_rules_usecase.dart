import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';

class GetAllSensorRulesUsecase extends UseCase<List<SensorRule>, Unit> {
  @override
  FutureOr<Either<Failure, List<SensorRule>>> call(Unit param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
