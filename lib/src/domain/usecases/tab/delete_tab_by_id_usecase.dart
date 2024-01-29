import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/repositories/tab_repository.dart';

@Injectable()
class DeleteTabByIdUsecase extends UseCase<Unit, String> {
  final TabRepository tabRepository;

  DeleteTabByIdUsecase({required this.tabRepository});

  @override
  FutureOr<Either<Failure, Unit>> call(String param) async {
    return await tabRepository.deleteTabById(id: param);
  }
}
