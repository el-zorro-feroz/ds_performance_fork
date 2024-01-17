import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';

class GetAllConfigSensorUsecase extends UseCase<List<SensorInfo>, String> {
  @override
  FutureOr<Either<Failure, List<SensorInfo>>> call(String param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
