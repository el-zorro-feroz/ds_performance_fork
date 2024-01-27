import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart';

@Injectable()
class GetAllConfigsUseCase extends UseCase<List<Config>, Unit> {
  final ConfigRepository configRepository;

  GetAllConfigsUseCase({required this.configRepository});

  @override
  Future<Either<Failure, List<Config>>> call(Unit param) async {
    return await configRepository.getAllConfigs();
  }
}
