// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';

class GetSensorByIdUsecase extends UseCase<SensorInfo, String> {
  @override
  FutureOr<Either<Failure, SensorInfo>> call(String param) {
    throw UnimplementedError();
  }
}
