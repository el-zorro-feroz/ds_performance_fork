import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';

class AddConfigUsecase extends UseCase<Config, AddConfigUsecaseParams> {
  @override
  FutureOr<Either<Failure, Config>> call(AddConfigUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddConfigUsecaseParams {}
