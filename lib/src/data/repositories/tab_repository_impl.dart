import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/tabs_model.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';
import 'package:sensors_monitoring/src/domain/repositories/tab_repository.dart';
import 'package:sensors_monitoring/src/domain/usecases/tab/add_tab_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/tab/edit_tab_usecase.dart';

@Injectable(as: TabRepository)
class TabRepositoryImpl implements TabRepository {
  final CommonDatasource datasource;

  TabRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, Unit>> addTab({required AddTabUsecaseParams param}) async {
    try {
      final TabsModel tabsModel = await datasource.insertTabs(
        configId: param.config.id,
        title: param.tab.title,
      );

      for (final sensorInfo in param.tab.sensorInfoList) {
        await datasource.insertTabSensors(
          sensorId: sensorInfo.id,
          tabId: tabsModel.id,
        );
      }

      param.config.tabList.add(
        Tab(
          id: tabsModel.id,
          sensorInfoList: param.tab.sensorInfoList,
          title: tabsModel.title,
        ),
      );

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTabById({required String id}) async {
    try {
      await datasource.deleteTabsById(id);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> editTab({required EditTabUsecaseParams param}) async {
    try {
      // await datasource.updateTabs(
      //   id: param.id,
      //   title: param.title,
      // );
      await datasource.deleteTabsById(param.tab.id);

      final TabsModel tabsModel = await datasource.insertTabs(
        configId: param.config.id,
        title: param.tab.title,
      );

      for (final sensorInfo in param.tab.sensorInfoList) {
        await datasource.insertTabSensors(
          sensorId: sensorInfo.id,
          tabId: tabsModel.id,
        );
      }

      param.config.tabList.add(
        Tab(
          sensorInfoList: param.tab.sensorInfoList,
          id: tabsModel.id,
          title: tabsModel.title,
        ),
      );

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> getAllTabsByConfigId({required String configId}) async {
    try {
      await datasource.selectAllTabsByConfigId(configId);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> getTabById({required String id}) async {
    try {
      await datasource.selectOneTabsById(id: id);

      return const Right(unit);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }
}
