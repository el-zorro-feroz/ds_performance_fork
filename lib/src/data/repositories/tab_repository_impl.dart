import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/domain/repositories/tab_repository.dart';
import 'package:sensors_monitoring/src/domain/usecases/tab/add_tab_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/tab/edit_tab_usecase.dart';

@Injectable(as: TabRepository)
class TabRepositoryImpl implements TabRepository {
  final CommonDatasource commonDatasource = services<CommonDatasource>();
  @override
  Future<Either<Failure, Unit>> addTab({required AddTabUsecaseParams param}) async {
    try {
      await commonDatasource.insertTabs(
        configId: param.configId,
        title: param.title,
      );

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTabById({required String id}) async {
    try {
      await commonDatasource.deleteTabs(id: id);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> editTab({required EditTabUsecaseParams param}) async {
    try {
      await commonDatasource.updateTabs(
        id: param.id,
        title: param.title,
      );

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> getAllTabsByConfigId({required String configId}) async {
    try {
      await commonDatasource.selectAllTabsByConfigId(configId);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> getTabById({required String id}) async {
    try {
      await commonDatasource.selectOneTabsById(id: id);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }
}
