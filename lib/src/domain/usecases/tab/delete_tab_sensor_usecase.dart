import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/tab_sensor.dart';

class DeleteTabSensor extends UseCase<TabSensor, DeleteTabSensorParams> {
  @override
  FutureOr<Either<Failure, TabSensor>> call(DeleteTabSensorParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class DeleteTabSensorParams {}
