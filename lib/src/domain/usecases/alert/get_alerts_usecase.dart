import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/notification_data.dart';
import 'package:sensors_monitoring/src/domain/repositories/notification_repository.dart';

@Injectable()
class GetAlertsUseCase extends UseCase<Iterable<NotificationData>, GetNotificationsUseCaseParam> {
  final NotificationRepository notificationRepository;

  GetAlertsUseCase({
    required this.notificationRepository,
  });

  @override
  FutureOr<Either<Failure, Iterable<NotificationData>>> call(GetNotificationsUseCaseParam param) {
    return notificationRepository.get(count: param.count);
  }
}

final class GetNotificationsUseCaseParam {
  final int count;

  const GetNotificationsUseCaseParam({
    this.count = 15,
  });
}
