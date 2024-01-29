import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/entities/notification.dart';
import 'package:sensors_monitoring/src/domain/usecases/notification/add_notification_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/notification/edit_notification_usecase.dart';

abstract class NotificationRepository {
  Future<Either<Failure, Notification>> addNotification(AddNotificationUsecaseParams params);
  Future<Either<Failure, Unit>> deleteNotificationById(String id);
  Future<Either<Failure, Notification>> editNotification(EditNotificationUsecaseParams params);
}
