import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';
import 'package:sensors_monitoring/src/domain/repositories/tab_repository.dart';

@Injectable()
class EditTabUsecase extends UseCase<Unit, EditTabUsecaseParams> {
  final TabRepository tabRepository;

  EditTabUsecase({required this.tabRepository});

  @override
  FutureOr<Either<Failure, Unit>> call(EditTabUsecaseParams param) async {
    return await tabRepository.editTab(param: param);
  }
}

class EditTabUsecaseParams {
  final Config config;
  final Tab tab;

  EditTabUsecaseParams({
    required this.config,
    required this.tab,
  });
}
