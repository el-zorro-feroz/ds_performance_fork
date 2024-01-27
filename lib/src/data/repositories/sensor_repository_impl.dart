import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/domain/repositories/sensor_repository.dart';
import 'package:sensors_monitoring/src/domain/usecases/sensors/add_sensor_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/sensors/edit_sensor_usecase.dart';

@Injectable(as: SensorRepository)
class SensorRepositoryImpl implements SensorRepository {
  final CommonDatasource commonDatasource = services<CommonDatasource>();
  @override
  Future<Either<Failure, Unit>> addSensor({required AddSensorUsecaseParams param}) async {
    try {
      await commonDatasource.insertSensors(
        configId: param.configId,
        title: param.title,
        sensorType: param.sensorType,
        details: param.details,
      );

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSensorById({required String id}) async {
    try {
      await commonDatasource.deleteSensorsById(id);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> editSensor({required EditSensorUsecaseParams param}) async {
    try {
      await commonDatasource.updateSensors(
        id: param.id,
        title: param.title,
        sensorType: param.sensorType,
        details: param.details,
      );

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> getAllSensorsByConfigId({required String configId}) async {
    try {
      await commonDatasource.selectAllSensorsByConfigId(configId: configId);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> getSensorById({required String id}) async {
    try {
      await commonDatasource.selectOneSensorsById(id: id);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }
}
