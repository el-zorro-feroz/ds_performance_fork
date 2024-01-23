// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/enum/rule_type.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';
import 'package:sensors_monitoring/src/data/models/sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/tab_sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/tabs_model.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_history.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/add_config_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/edit_config_usecase.dart';

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

      final List<SensorInfo> resultSensorList = [];

      for (SensorInfo sensor in params.sensorList) {
        final String sensorId = await datasource.insertSensors(
          configId: configId,
          title: sensor.title,
          sensorType: sensor.sensorType,
          details: sensor.details,
        );

        await datasource.insertTabSensors(sensorId: sensorId, tabId: tabModel.id);

        final List<AlertData> resultAlertList = [];

        for (AlertData alertData in sensor.alerts) {
          final String alertId = await datasource.insertAlerts(
            sensorId: sensorId,
            type: alertData.type,
            message: alertData.message,
            title: alertData.title,
            description: alertData.description,
          );
          final List<SensorRule> resultSensorRuleList = [];

          for (SensorRule sensorRule in alertData.sensorRuleList) {
            final sensorRuleId = await datasource.insertSensorRules(
              value: sensorRule.value,
              ruleType: sensorRule.ruleType,
            );

            resultSensorRuleList.add(
              SensorRule(
                id: sensorRuleId,
                ruleType: sensorRule.ruleType,
                value: sensorRule.value,
              ),
            );

            await datasource.insertRuleGroups(alertId: alertId, ruleId: sensorRuleId);
          }

          resultAlertList.add(
            AlertData(
              id: alertId,
              title: alertData.title,
              message: alertData.message,
              description: alertData.description,
              type: alertData.type,
              sensorRuleList: resultSensorRuleList,
            ),
          );
        }

        resultSensorList.add(
          SensorInfo(
            id: sensorId,
            title: sensor.title,
            details: sensor.details,
            sensorType: sensor.sensorType,
            sensorHistoryList: [],
            alerts: resultAlertList,
          ),
        );
      }

      return Right(
        Config(
          id: configId,
          title: params.title,
          tabList: [
            Tab(
              sensorInfoList: resultSensorList,
              id: tabModel.id,
              title: tabModel.title,
            ),
          ],
          sensorList: resultSensorList,
        ),
      );
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteConfigById(String id) async {
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
      if (configList != null) {
        for (final config in configList) {
          final sensorModelList = await datasource.selectAllSensorsByConfigId(configId: config.id);
          final List<SensorInfo> sensorList = [];
          for (final sensor in sensorModelList ?? []) {
            final List<Map<String, Map<String, dynamic>>>? alertModelList = await datasource.selectAllAlertsBySensorId(sensor.id);
            final Map<String, AlertData> alertDataMap = {};
            for (final alertModel in alertModelList ?? []) {
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
            }

            final List<SensorHistory> sensorHistoryList = ((await datasource.selectAllSensorHistoryBySensorId(sensor.id)) ?? [])
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
          }

          final List<Tab> tabList = [];

          (await datasource.selectAllTabsByConfigId(configId: config.id))!.map((tabModel) async {
            final List<SensorInfo> sensorInfoList = [];
            (await datasource.selectAllTabSensorsByTabId(tabModel.id))!.map((tabSensorModel) {
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
        }
      }

      return Right(resList);
    } catch (_) {
      return Left(Failure(message: _.toString()));
    }
  }

  @override
  Future<Either<Failure, Config>> editConfig(EditConfigUsecaseParams params) async {
    try {
      if (params.title != null || params.title != '') {
        await datasource.updateConfigs(id: params.id, title: params.title!);
      }

      if (params.editedSensorsList != null) {
        final Map<String, List<TabSensorsModel>> allTabSensorsMap = {};

        final allTabs = await datasource.selectAllTabsByConfigId(configId: params.id);

        for (final tab in allTabs ?? []) {
          final listTabSensors = await datasource.selectAllTabSensorsByTabId(tab.id);
          allTabSensorsMap[tab.id] = listTabSensors ?? [];
        }

        final List<TabSensorsModel> correctTabSensorsList = [];

        if (params.editedSensorsList!.isNotEmpty) {
          for (final tabSensorsList in allTabSensorsMap.values) {
            for (final tabSensorModel in tabSensorsList) {
              for (final sensor in params.editedSensorsList!) {
                if (tabSensorModel.sensorId == sensor.id) {
                  correctTabSensorsList.add(tabSensorModel);
                }
              }
            }
          }
        }

        for (final sensor in params.allSensors) {
          await datasource.deleteSensors(id: sensor.id);
        }

        if (params.editedSensorsList != null) {
          for (final sensor in params.editedSensorsList!) {
            await datasource.insertSensors(
              configId: params.id,
              title: sensor.title,
              sensorType: sensor.sensorType,
              details: sensor.details,
            );
            if (sensor.alerts.isNotEmpty) {
              sensor.alerts.first.sensorRuleList.forEach((sensorRule) async {
                await datasource.insertSensorRules(
                  value: sensorRule.value,
                  ruleType: sensorRule.ruleType,
                );
              });

              for (final alertData in sensor.alerts) {
                final String alertId = await datasource.insertAlerts(
                  sensorId: sensor.id,
                  type: alertData.type,
                  message: alertData.message,
                  title: alertData.title,
                  description: alertData.description,
                );

                for (final sensorRule in alertData.sensorRuleList) {
                  await datasource.insertRuleGroups(alertId: alertId, ruleId: sensorRule.id);
                }
              }
            }
          }
        }

        final List<Tab> tabList = [];
        for (final key in allTabSensorsMap.keys) {
          for (final tabSensorModel in correctTabSensorsList) {
            await datasource.insertTabSensors(sensorId: tabSensorModel.sensorId, tabId: key);
            final sensorList = params.editedSensorsList!.where((element) => element.id == tabSensorModel.sensorId).toList();
            tabList.add(
              Tab(sensorInfoList: sensorList, id: tabSensorModel.id, title: allTabs!.firstWhere((tab) => tab.id == key).title),
            );
          }
        }

        return Right(Config(id: params.id, title: params.title!, tabList: tabList, sensorList: params.editedSensorsList!));
      }
      return Left(Failure(message: 'Ничего не изменили'));
    } catch (e, s) {
      return Left(Failure(message: s.toString()));
    }
  }
}
