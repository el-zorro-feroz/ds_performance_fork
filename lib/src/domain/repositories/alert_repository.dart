import 'dart:math';

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

//TODO: create correct implementation
@Injectable(as: AlertRepository)
class UnimplementedNotificationRepository implements AlertRepository {
  @override
  Future<Either<Failure, Iterable<AlertData>>> get({required int count}) async {
    final Random rndModule = Random.secure();
    final Iterator<AlertType> alertTypeIter = AlertType.values.iterator;

    return Right(
      List<String>.generate(4, (index) => (rndModule.nextInt(4096) << 2).toString()).map((e) {
        final alertData = AlertData(
          id: e,
          title: e,
          message: 'TEST_MESSAGE',
          description: 'TEST_DESCRIPTION',
          type: AlertType.info, //TODO
          sensorRuleList: [],
        );

        alertTypeIter.moveNext();
        return alertData;
      }),
    );

    // return Right([
    //   AlertData(id: (rndModule.nextInt(4096) << 2).toString(), title: title, message: message, description: description, type: type, sensorRuleList: sensorRuleList)
    //   // AlertData(type: AlertType.error, title: 'Test Error', description: 'Test Error Description', datetime: DateTime.now()),
    //   // AlertData(type: AlertType.info, title: 'Test Info', description: 'Test Info Description', datetime: DateTime.now()),
    //   // AlertData(type: AlertType.warning, title: 'Test Warning', description: 'Test Warning Description', datetime: DateTime.now()),
    // ]);

    // return const Left(Failure(message: 'Unimplemented [NotificationRepository] logic'));
  }
}
