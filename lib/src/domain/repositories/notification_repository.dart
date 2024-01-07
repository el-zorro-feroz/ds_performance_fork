import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/entities/notification_data.dart';

/// Notifications managing respository
abstract class NotificationRepository {
  /// Method responsible for receiving the last {count} [NotificationData] from database or [Failure]
  Future<Either<Failure, Iterable<NotificationData>>> get({required int count});
}

@Injectable(as: NotificationRepository)
class UnimplementedNotificationRepository implements NotificationRepository {
  @override
  Future<Either<Failure, Iterable<NotificationData>>> get({required int count}) async {
    // Test Right Example
    return Right([
      NotificationData(type: NotificationType.error, title: 'Test Error', description: 'Test Error Description', datetime: DateTime.now()),
      NotificationData(type: NotificationType.info, title: 'Test Info', description: 'Test Info Description', datetime: DateTime.now()),
      NotificationData(type: NotificationType.warning, title: 'Test Warning', description: 'Test Warning Description', datetime: DateTime.now()),
    ]);

    return const Left(Failure(message: 'Unimplemented [NotificationRepository] logic'));
  }
}
