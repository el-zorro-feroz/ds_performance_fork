import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';

class DeleteSensorRuleByIdUsecase extends UseCase<Unit, String> {
  @override
  FutureOr<Either<Failure, Unit>> call(String param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
