import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor.dart';

class AddSensorUsecase extends UseCase<Sensor, AddSensorUsecaseParams> {
  @override
  FutureOr<Either<Failure, Sensor>> call(AddSensorUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddSensorUsecaseParams {
  final String configId;
  final String title;
  final SensorType sensorType;
  final String details;

  AddSensorUsecaseParams({
    required this.configId,
    required this.title,
    required this.sensorType,
    required this.details,
  });
}
