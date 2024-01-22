import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart';

@Injectable()
class AddConfigUsecase extends UseCase<Config, AddConfigUsecaseParams> {
  final ConfigRepository configRepository;

  AddConfigUsecase({required this.configRepository});

  @override
  FutureOr<Either<Failure, Config>> call(AddConfigUsecaseParams param) async {
    return await configRepository.addConfig(param);
  }
}

class AddConfigUsecaseParams {
  final String title;
  final List<SensorInfo> sensorList;

  AddConfigUsecaseParams({required this.title, required this.sensorList});
}
