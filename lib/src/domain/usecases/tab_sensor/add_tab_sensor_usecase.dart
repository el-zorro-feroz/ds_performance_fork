import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';

class AddTabSensorUsecase extends UseCase<Unit, AddTabSensorUsecaseParams> {
  @override
  FutureOr<Either<Failure, Unit>> call(AddTabSensorUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddTabSensorUsecaseParams {}
