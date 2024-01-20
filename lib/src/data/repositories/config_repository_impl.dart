import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/add_config_usecase.dart';

@Injectable(as: ConfigRepository)
class ConfigRepositoryImpl implements ConfigRepository {
  final CommonDatasource datasource;

  const ConfigRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, Config>> addConfig(AddConfigUsecaseParams params) {
    // datasource.insertConfigs(title: params.title);
    // datasource.insertSensors(
    //   configId: configId,
    //   title: title,
    //   sensorType: sensorType,
    //   details: details,
    // );
    // datasource.insertAlerts(
    //   sensorId: sensorId,
    //   ruleId: ruleId,
    //   message: message,
    //   type: type,
    // );
    // datasource.insertRules(description: description);
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteConfig(String id) async {
    try {
      await datasource.deleteConfigs(id: id);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
    return const Right(unit);
  }

  @override
  Future<Either<Failure, List<Config>>> getAllConfigs() async {
    try {
      final configList = await datasource.selectAllConfigs();
      final List<Config> resList = [];

      configList?.forEach((config) async {
        final sensorModelList = await datasource.selectAllSensorsByConfigId(configId: config.id);
        final sensorList = sensorModelList?.map((sensor) async {
          final sensorRuleModelList = await datasource.selectAllSensorRulesBySensorId(sensor.id);

          // final ruleModel = await datasource.selectOneRules(id: sensor.id);

          final sensorRuleList = sensorRuleModelList?.map((sensorRule) => SensorRule(
                decription: ruleModel!.description,
              ));

          final alertModelList = await datasource.selectAllAlertsBySensorId(sensor.id);

          final alertList = alertModelList?.map((alert) => AlertData(
                title: alert.title,
                message: alert.message,
                description: alert.description,
                type: alert.type,
                sensorRuleList: [],
              ));

          final sensorHistoryList = await datasource.selectAllSensorHistoryBySensorId(sensor.id)
            ?..map((e) => null);

          return SensorInfo(
            id: sensor.id,
            details: sensor.details,
            title: sensor.title,
            sensorHistoryList: [],
            alerts: [],
          );
        });

        resList.add(Config(
          id: config.id,
          title: config.title,
          sensorList: [],
          tabList: [],
        ));
      });
    } catch (e) {
      rethrow;
    }
    // return Right(res);
  }
}
