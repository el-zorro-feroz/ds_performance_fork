import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';

class EditTabUsecase extends UseCase<Tab, EditTabUsecaseParams> {
  @override
  FutureOr<Either<Failure, Tab>> call(EditTabUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class EditTabUsecaseParams {
  final String id;
  final String title;

  EditTabUsecaseParams({
    required this.id,
    required this.title,
  });
}
