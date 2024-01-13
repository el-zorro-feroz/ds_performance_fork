// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor.dart';

class GetSensorByIdUsecase extends UseCase<Sensor, String> {
  @override
  FutureOr<Either<Failure, Sensor>> call(String param) {
    throw UnimplementedError();
  }
}
