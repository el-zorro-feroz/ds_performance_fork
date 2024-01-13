import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';

class GetAllConfigsUsecase extends UseCase<List<Config>, Unit> {
  @override
  FutureOr<Either<Failure, List<Config>>> call(Unit param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
