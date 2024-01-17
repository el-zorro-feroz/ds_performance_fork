import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';

class DeleteConfigByIdUsecase extends UseCase<Unit, String> {
  @override
  FutureOr<Either<Failure, Unit>> call(String id) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class DeleteConfigByIdUsecaseParams {}
