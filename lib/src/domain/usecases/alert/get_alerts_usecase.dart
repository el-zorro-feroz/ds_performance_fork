import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/repositories/alert_repository.dart';

@Injectable()
class GetAlertsUseCase extends UseCase<Iterable<AlertData>, GetNotificationsUseCaseParam> {
  final AlertRepository alertRepository;

  GetAlertsUseCase({
    required this.alertRepository,
  });

  @override
  FutureOr<Either<Failure, Iterable<AlertData>>> call(GetNotificationsUseCaseParam param) {
    return alertRepository.get(count: param.count);
  }
}

final class GetNotificationsUseCaseParam {
  final int count;

  const GetNotificationsUseCaseParam({
    this.count = 15,
  });
}
