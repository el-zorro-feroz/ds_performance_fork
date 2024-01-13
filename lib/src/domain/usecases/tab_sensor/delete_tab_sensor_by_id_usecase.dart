import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/tab_sensor.dart';

class DeleteTabSensorByIdUsecase extends UseCase<TabSensor, String> {
  @override
  FutureOr<Either<Failure, TabSensor>> call(String param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
