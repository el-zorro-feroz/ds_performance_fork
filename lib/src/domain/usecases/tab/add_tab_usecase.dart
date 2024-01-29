import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';
import 'package:sensors_monitoring/src/domain/repositories/tab_repository.dart';

@Injectable()
class AddTabUsecase extends UseCase<Unit, AddTabUsecaseParams> {
  final TabRepository tabRepository;

  AddTabUsecase({required this.tabRepository});

  @override
  FutureOr<Either<Failure, Unit>> call(AddTabUsecaseParams param) async {
    return await tabRepository.addTab(param: param);
  }
}

class AddTabUsecaseParams {
  final Config config;
  final Tab tab;

  AddTabUsecaseParams({
    required this.config,
    required this.tab,
  });
}
