import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/notification.dart';

class EditNotificationUsecase extends UseCase<Notification, EditNotificationUsecaseParams> {
  @override
  FutureOr<Either<Failure, Notification>> call(EditNotificationUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class EditNotificationUsecaseParams {}
