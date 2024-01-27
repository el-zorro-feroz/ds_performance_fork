import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';

class AddTabUsecase extends UseCase<Tab, AddTabUsecaseParams> {
  @override
  FutureOr<Either<Failure, Tab>> call(AddTabUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddTabUsecaseParams {
  final String configId;
  final String title;

  AddTabUsecaseParams({
    required this.configId,
    required this.title,
  });
}
