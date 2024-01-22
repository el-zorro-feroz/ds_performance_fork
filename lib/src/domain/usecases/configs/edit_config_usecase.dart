import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart';

@Injectable()
class EditConfigUsecase extends UseCase<Config, EditConfigUsecaseParams> {
  final ConfigRepository repository;
  EditConfigUsecase({required this.repository});
  @override
  FutureOr<Either<Failure, Config>> call(EditConfigUsecaseParams param) async {
    return repository.editConfig(param);
  }
}

class EditConfigUsecaseParams {
  final String id;
  final String? title;
  final List<SensorInfo>? editedSensorsList;

  const EditConfigUsecaseParams({
    required this.id,
    this.title,
    this.editedSensorsList,
  });
}
