import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart';

@Injectable()
class DeleteConfigByIdUsecase extends UseCase<Unit, String> {
  final ConfigRepository configRepository;

  DeleteConfigByIdUsecase({required this.configRepository});

  @override
  FutureOr<Either<Failure, Unit>> call(String id) async {
    return await configRepository.deleteConfigById(id);
  }
}

class DeleteConfigByIdUsecaseParams {}
