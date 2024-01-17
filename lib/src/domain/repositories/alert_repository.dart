import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';

///Алерты это наши уведомления, Нотификейшоны сущнности которые нужны для создания алертов
/// Notifications managing respository
abstract class AlertRepository {
  /// Method responsible for receiving the last {count} [AlertData] from database or [Failure]
  Future<Either<Failure, Iterable<AlertData>>> get({required int count});
}

@Injectable(as: AlertRepository)
class UnimplementedNotificationRepository implements AlertRepository {
  @override
  Future<Either<Failure, Iterable<AlertData>>> get({required int count}) async {
    // Test Right Example
    return Right([
      AlertData(type: AlertType.error, title: 'Test Error', description: 'Test Error Description', datetime: DateTime.now()),
      AlertData(type: AlertType.info, title: 'Test Info', description: 'Test Info Description', datetime: DateTime.now()),
      AlertData(type: AlertType.warning, title: 'Test Warning', description: 'Test Warning Description', datetime: DateTime.now()),
    ]);

    return const Left(Failure(message: 'Unimplemented [NotificationRepository] logic'));
  }
}
