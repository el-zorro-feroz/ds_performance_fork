import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/usecase/usecase.dart';
import 'package:sensors_monitoring/src/domain/entities/notification_data.dart';

class EditNotificationUsecase extends UseCase<AlertData, EditNotificationUsecaseParams> {
  @override
  FutureOr<Either<Failure, AlertData>> call(EditNotificationUsecaseParams param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class EditNotificationUsecaseParams {
  final String id;
  final String? sensorId;
  final String? ruleId;
  final String? message;
  final AlertType? type;

  EditNotificationUsecaseParams({
    required this.id,
    this.sensorId,
    this.ruleId,
    this.message,
    this.type,
  });
}
