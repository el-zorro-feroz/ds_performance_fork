import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/repositories/alert_repository.dart';

class AlertRepositoryImpl implements AlertRepository {
  @override
  Future<Either<Failure, Iterable<AlertData>>> get({required int count}) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
