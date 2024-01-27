import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';

class GetTabByIdUsecase extends UseCase<Tab, String> {
  @override
  FutureOr<Either<Failure, Tab>> call(String param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
