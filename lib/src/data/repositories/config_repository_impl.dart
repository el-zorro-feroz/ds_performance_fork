import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/enum/rule_type.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/tabs_model.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_history.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/add_config_usecase.dart';

@Injectable(as: ConfigRepository)
class ConfigRepositoryImpl implements ConfigRepository {
  final CommonDatasource datasource;

  const ConfigRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, Config>> addConfig(AddConfigUsecaseParams params) async {
    try {
      final String configId = await datasource.insertConfigs(title: params.title);

      final TabsModel tabModel = await datasource.insertTabs(configId: configId, title: 'Tab 1');

      params.sensorList.forEach((sensor) async {
        final String sensorId = await datasource.insertSensors(
          configId: configId,
          title: sensor.title,
          sensorType: sensor.sensorType,
          details: sensor.details,
        );

        await datasource.insertTabSensors(sensorId: sensorId, tabId: tabModel.id);

        sensor.alerts.first.sensorRuleList.forEach((sensorRule) async {
          await datasource.insertSensorRules(
            value: sensorRule.value,
            ruleType: sensorRule.ruleType,
          );
        });

        sensor.alerts.forEach((alertData) async {
          final String alertId = await datasource.insertAlerts(
            sensorId: sensor.id,
            type: alertData.type,
            message: alertData.message,
            title: alertData.title,
            description: alertData.description,
          );

          alertData.sensorRuleList.forEach((sensorRule) async {
            await datasource.insertRuleGroups(alertId: alertId, ruleId: sensorRule.id);
          });
        });
      });

      return Right(
        Config(
          id: configId,
          title: params.title,
          tabList: [Tab(sensorInfoList: params.sensorList, id: tabModel.id, title: tabModel.title)],
          sensorList: params.sensorList,
        ),
      );
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
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
        final List<SensorInfo> sensorList = [];
        sensorModelList?.map((sensor) async {
          final List<Map<String, Map<String, dynamic>>>? alertModelList = await datasource.selectAllAlertsBySensorId(sensor.id);
          final Map<String, AlertData> alertDataMap = {};
          alertModelList?.map((alertModel) {
            final Map<String, dynamic> alertRequestMap = alertModel['alerts']!;
            final Map<String, dynamic> rulesRequestMap = alertModel['sensorrules']!;
            final String alertId = alertRequestMap['alert_id'];
            if (alertDataMap.containsKey(alertId)) {
              alertDataMap[alertId]!.sensorRuleList.add(
                    SensorRule(
                      id: rulesRequestMap['sensor_rule_id'],
                      ruleType: RuleType.values.byName(rulesRequestMap['type']),
                      value: rulesRequestMap['value'],
                    ),
                  );
            } else {
              alertDataMap[alertId] = AlertData(
                id: alertRequestMap['alert_id'],
                title: alertRequestMap['title'],
                message: alertRequestMap['message'],
                description: alertRequestMap['description'],
                type: AlertType.values.byName(alertRequestMap['alert_type']),
                sensorRuleList: [
                  SensorRule(
                    id: rulesRequestMap['sensor_rule_id'],
                    ruleType: RuleType.values.byName(rulesRequestMap['type']),
                    value: rulesRequestMap['value'],
                  ),
                ],
              );
            }
          });

          final List<SensorHistory> sensorHistoryList = (await datasource.selectAllSensorHistoryBySensorId(sensor.id))!
              .map(
                (sensorHistoryModel) => SensorHistory(
                  id: sensorHistoryModel.id,
                  date: sensorHistoryModel.date,
                  value: sensorHistoryModel.value,
                ),
              )
              .toList();

          sensorList.add(SensorInfo(
            id: sensor.id,
            details: sensor.details,
            title: sensor.title,
            sensorType: sensor.sensorType,
            sensorHistoryList: sensorHistoryList,
            alerts: alertDataMap.values.toList(),
          ));
        });

        final List<Tab> tabList = [];

        (await datasource.selectAllTabsByConfigId(configId: config.id))!.map((tabModel) async {
          final List<SensorInfo> sensorInfoList = [];
          (await datasource.selectAllTabSensorsByTabId(tabId: tabModel.id))!.map((tabSensorModel) {
            sensorInfoList.add(sensorList.where((element) => element.id == tabSensorModel.sensorId).first);
          });
          tabList.add(Tab(sensorInfoList: sensorInfoList, id: tabModel.id, title: tabModel.title));
        });

        resList.add(Config(
          id: config.id,
          title: config.title,
          sensorList: sensorList,
          tabList: tabList,
        ));
      });

      return Right(resList);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }
}
