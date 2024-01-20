import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/add_config_usecase.dart';

abstract class ConfigRepository {
  Future<Either<Failure, Config>> addConfig(AddConfigUsecaseParams params);
  Future<Either<Failure, Unit>> deleteConfig(String id);
  Future<Either<Failure, List<Config>>> getAllConfigs();
}
