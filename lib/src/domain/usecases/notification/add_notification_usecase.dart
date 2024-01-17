import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/notification.dart';

class AddNotificationUsecase extends UseCase<Notification, AddNotificationUsecaseParams> {
  @override
  FutureOr<Either<Failure, Notification>> call(AddNotificationUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddNotificationUsecaseParams {}
