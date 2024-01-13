import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor.dart';

class EditSensorUsecase extends UseCase<Sensor, EditSensorUsecaseParams> {
  @override
  FutureOr<Either<Failure, Sensor>> call(EditSensorUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class EditSensorUsecaseParams {
  final String id;
  final String? title;
  final SensorType? sensorType;
  final String? details;

  EditSensorUsecaseParams({
    required this.id,
    this.title,
    this.sensorType,
    this.details,
  });
}
