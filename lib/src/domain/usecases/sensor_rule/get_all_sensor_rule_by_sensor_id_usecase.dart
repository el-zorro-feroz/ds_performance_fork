import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';

class GetAllSensorRulesBySensorIdUsecase extends UseCase<List<SensorRule>, String> {
  @override
  FutureOr<Either<Failure, List<SensorRule>>> call(String param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
