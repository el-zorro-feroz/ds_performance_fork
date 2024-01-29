import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';

class EditSensorRuleUsecase extends UseCase<SensorRule, EditSensorRuleUsecaseParams> {
  @override
  FutureOr<Either<Failure, SensorRule>> call(EditSensorRuleUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class EditSensorRuleUsecaseParams {}
