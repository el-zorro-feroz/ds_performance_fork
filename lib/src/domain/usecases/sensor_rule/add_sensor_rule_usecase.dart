import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';

class AddSensorRuleUsecase extends UseCase<SensorRule, AddSensorRuleUsecaseParams> {
  @override
  FutureOr<Either<Failure, SensorRule>> call(AddSensorRuleUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddSensorRuleUsecaseParams {}
