import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/usecases/sensors/add_sensor_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/sensors/edit_sensor_usecase.dart';

abstract class SensorRepository {
  Future<Either<Failure, Unit>> getSensorById({required String id});

  Future<Either<Failure, Unit>> getAllSensorsByConfigId({required String configId});

  Future<Either<Failure, Unit>> addSensor({required AddSensorUsecaseParams param});

  Future<Either<Failure, Unit>> editSensor({required EditSensorUsecaseParams param});

  Future<Either<Failure, Unit>> deleteSensorById({required String id});
}
