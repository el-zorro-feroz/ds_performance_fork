import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/usecases/tab/add_tab_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/tab/edit_tab_usecase.dart';

abstract class TabRepository {
  Future<Either<Failure, Unit>> getTabById({required String id});

  Future<Either<Failure, Unit>> getAllTabsByConfigId({required String configId});

  Future<Either<Failure, Unit>> addTab({required AddTabUsecaseParams param});

  Future<Either<Failure, Unit>> editTab({required EditTabUsecaseParams param});

  Future<Either<Failure, Unit>> deleteTabById({required String id});
}
