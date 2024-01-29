// ignore_for_file: avoid_function_literals_in_foreach_calls

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
            late final String sensorRuleId;
            if (sensorRule.id.isEmpty) {
              sensorRuleId = await datasource.insertSensorRules(
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
            } else {
              sensorRuleId = sensorRule.id;
              resultSensorRuleList.add(sensorRule);
            }

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
          if (sensorModelList != null) {
            for (final sensor in sensorModelList) {
              final List<Map<String, Map<String, dynamic>>>? alertModelList = await datasource.selectAllAlertsBySensorId(sensor.id);
              final Map<String, AlertData> alertDataMap = {};
              if (alertModelList != null) {
                for (final alertModel in alertModelList) {
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
          }

          final List<Tab> tabList = [];
          final tabsModelList = await datasource.selectAllTabsByConfigId(config.id) ?? [];
          for (var tabModel in tabsModelList) {
            final List<SensorInfo> sensorInfoList = [];
            final tabSensorsModelList = await datasource.selectAllTabSensorsByTabId(tabModel.id) ?? [];
            for (var tabSensorModel in tabSensorsModelList) {
              sensorInfoList.add(sensorList.where((element) => element.id == tabSensorModel.sensorId).first);
            }
            tabList.add(Tab(sensorInfoList: sensorInfoList, id: tabModel.id, title: tabModel.title));
          }

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
      final Config config = params.config;
      final String configId = config.id;
      late final String configTitle;

      if (params.title != null && params.title != '' && params.config.title != params.title) {
        await datasource.updateConfigs(id: configId, title: params.title!);
        configTitle = params.title!;
      } else {
        configTitle = config.title;
      }

      // // Проверяем были ли внесены изменения
      // if (config.sensorList == params.editedSensorsList) {
      //   return Right(config); //? Можно дропать ошибку
      // } else

      // Если после изменения в конфигурации отсутствует содержимое, то удаляем все сенсоры,
      // которые были до изменения (каскадно удалаются все записи, связанные с ними).
      // Возвращаем конфигурацию без сенсоров и с пустыми вкладками.
      if (params.editedSensorsList.isEmpty) {
        for (SensorInfo sensor in params.config.sensorList) {
          await datasource.deleteSensorsById(sensor.id);
        }
        final List<Tab> correctTabList = [];
        for (Tab tab in config.tabList) {
          correctTabList.add(
            Tab(
              sensorInfoList: const [],
              id: tab.id,
              title: tab.title,
            ),
          );
        }

        return Right(
          Config(
            id: configId,
            title: config.title,
            tabList: correctTabList,
            sensorList: const [],
          ),
        );
        // Если список изменений не пуст, начинаем изменение конфига
      } else {
        final List<SensorInfo> sensorList = [];
        final List<Tab> tabList = [...config.tabList];
        final List<SensorInfo> toInsertSensorList = [...params.editedSensorsList];
        for (SensorInfo oldSensor in config.sensorList) {
          bool sensorFlag = false;
          for (SensorInfo newSensor in params.editedSensorsList) {
            // Ищем несовпадения (по id), чтобы удалить ненужные сенсоры
            if (newSensor.id == oldSensor.id) {
              toInsertSensorList.remove(newSensor);
              sensorFlag = true;
              // Если сенсор не изменился, то ничего с ним не делаем
              if (newSensor == oldSensor) {
                sensorList.add(oldSensor);
                // Если сенсор изменился, то обновляем нужные записи в БД
              } else {
                // Если хоть одно из полей (title, details, sensorType) было изменено, то обновляем запись в БД
                if (newSensor.title != oldSensor.title || newSensor.details != oldSensor.details || newSensor.sensorType != oldSensor.sensorType) {
                  await datasource.updateSensors(
                    id: newSensor.id,
                    title: newSensor.title,
                    details: newSensor.details,
                    sensorType: newSensor.sensorType,
                  );
                }
                // Если был обновлен список уведомлений сенсора, то отправляем соответствующие запросы в БД
                if (newSensor.alerts != oldSensor.alerts) {
                  final List<AlertData> alertList = [];
                  final List<AlertData> toInsertAlertList = [...newSensor.alerts];
                  for (AlertData oldAlert in oldSensor.alerts) {
                    bool alertFlag = false;
                    for (AlertData newAlert in newSensor.alerts) {
                      // Ищем несовпадения (по id), чтобы удалить ненужные уведомления
                      if (newAlert.id == oldAlert.id) {
                        alertFlag = true;
                        toInsertAlertList.remove(newAlert);
                        // Если уведомление сенсора не изменилось, то ничего с ним не делаем
                        if (newAlert == oldAlert) {
                          alertList.add(oldAlert);
                          // Если уведомление изменилось, то обновляем нужные записи в БД
                        } else {
                          // Если хоть одно из полей (title, description, message, type) было изменено, то обновляем запись в БД
                          if (newAlert.title != oldAlert.title || newAlert.description != oldAlert.description || newAlert.message != oldAlert.message || newAlert.type != oldAlert.type) {
                            await datasource.updateAlerts(
                              id: newAlert.id,
                              title: newAlert.title,
                              description: newAlert.description,
                              message: newAlert.message,
                              type: newAlert.type,
                            );
                          }
                          // Если был обновлен список правил уведомления, то отправляем соответствующие запросы в БД
                          if (newAlert.sensorRuleList != oldAlert.sensorRuleList) {
                            final List<SensorRule> ruleList = [];
                            final List<SensorRule> toInsertRuleList = [...newAlert.sensorRuleList];
                            for (SensorRule oldRule in oldAlert.sensorRuleList) {
                              bool ruleFlag = false;
                              for (SensorRule newRule in newAlert.sensorRuleList) {
                                // Ищем несовпадения (по id), чтобы удалить ненужные группы правил
                                if (newRule.id == oldRule.id) {
                                  toInsertRuleList.remove(newRule);
                                  ruleFlag = true;
                                  // Если правило уведомления не изменилось, то ничего с ним не делаем
                                  if (newRule == oldRule) {
                                    ruleList.add(oldRule);
                                    // Если правило изменилось, то обновляем нужные записи в БД
                                  } else {
                                    await datasource.updateSensorRules(
                                      id: newRule.id,
                                      value: newRule.value,
                                      ruleType: newRule.ruleType,
                                    );

                                    ruleList.add(
                                      SensorRule(
                                        id: newRule.id,
                                        value: newRule.value,
                                        ruleType: newRule.ruleType,
                                      ),
                                    );
                                  }
                                }
                              }
                              // Удаляем группу правил с несовпавшим правилом
                              if (!ruleFlag) {
                                await datasource.deleteRuleGroupsByAlertIdAndRuleId(
                                  alertId: oldAlert.id,
                                  ruleId: oldAlert.id,
                                );
                              }
                            }
                            for (SensorRule rule in toInsertRuleList) {
                              late final String ruleId;
                              if (rule.id.isEmpty) {
                                ruleId = await datasource.insertSensorRules(value: rule.value, ruleType: rule.ruleType);
                                ruleList.add(SensorRule(id: ruleId, ruleType: rule.ruleType, value: rule.value));
                              } else {
                                ruleId = rule.id;
                                ruleList.add(rule);
                              }
                              await datasource.insertRuleGroups(alertId: newAlert.id, ruleId: ruleId);
                            }
                            // Возвращаем уведомление с измененным списком правил
                            alertList.add(
                              AlertData(
                                id: newAlert.id,
                                title: newAlert.title,
                                message: newAlert.message,
                                description: newAlert.description,
                                type: newAlert.type,
                                sensorRuleList: ruleList,
                              ),
                            );
                            // Если список правил уведомления не изменился, то возвращаем уведомление
                          } else {
                            alertList.add(
                              AlertData(
                                id: newAlert.id,
                                title: newAlert.title,
                                message: newAlert.message,
                                description: newAlert.description,
                                type: newAlert.type,
                                sensorRuleList: newAlert.sensorRuleList,
                              ),
                            );
                          }
                        }
                      }
                    }
                    // Удаляем несовпавшие уведомления
                    if (!alertFlag) {
                      await datasource.deleteAlertsById(oldAlert.id);
                    }
                  }
                  for (AlertData alert in toInsertAlertList) {
                    final String alertId = await datasource.insertAlerts(
                      sensorId: newSensor.id,
                      type: alert.type,
                      message: alert.message,
                      title: alert.title,
                      description: alert.description,
                    );
                    final List<SensorRule> ruleList = [];
                    for (SensorRule rule in alert.sensorRuleList) {
                      late final String ruleId;
                      if (rule.id.isEmpty) {
                        ruleId = await datasource.insertSensorRules(
                          value: rule.value,
                          ruleType: rule.ruleType,
                        );

                        ruleList.add(
                          SensorRule(
                            id: ruleId,
                            ruleType: rule.ruleType,
                            value: rule.value,
                          ),
                        );
                      } else {
                        ruleId = rule.id;
                        ruleList.add(rule);
                      }
                      await datasource.insertRuleGroups(alertId: alertId, ruleId: ruleId);
                    }
                    alertList.add(
                      AlertData(
                        id: alertId,
                        title: alert.title,
                        message: alert.message,
                        description: alert.description,
                        type: alert.type,
                        sensorRuleList: ruleList,
                      ),
                    );
                  }
                  // Возвращаем сенсор с измененным списком уведомлений
                  final sensor = SensorInfo(
                    id: newSensor.id,
                    title: newSensor.title,
                    details: newSensor.details,
                    sensorType: newSensor.sensorType,
                    sensorHistoryList: const [],
                    alerts: newSensor.alerts,
                  );
                  sensorList.add(sensor);
                  for (var tab in tabList) {
                    for (var tabSensor in tab.sensorInfoList) {
                      if (tabSensor.id == sensor.id) {
                        tab.sensorInfoList.removeWhere((tabSensor) => tabSensor.id == sensor.id);
                        tab.sensorInfoList.add(sensor);
                      }
                    }
                  }

                  // Если список уведомлений сенсора не изменился, то возвращаем сенсор
                } else {
                  final sensor = SensorInfo(
                    id: newSensor.id,
                    title: newSensor.title,
                    details: newSensor.details,
                    sensorType: newSensor.sensorType,
                    sensorHistoryList: const [],
                    alerts: newSensor.alerts,
                  );
                  sensorList.add(sensor);
                  for (var tab in tabList) {
                    for (var tabSensor in tab.sensorInfoList) {
                      if (tabSensor.id == sensor.id) {
                        tab.sensorInfoList.removeWhere((tabSensor) => tabSensor.id == sensor.id);
                        tab.sensorInfoList.add(sensor);
                      }
                    }
                  }
                }
              }
            }
          }
          // Удаляем несовпавшие сенсоры
          if (!sensorFlag) {
            await datasource.deleteSensorsById(oldSensor.id);
            for (Tab tab in tabList) {
              tab.sensorInfoList.removeWhere((sensor) => sensor.id == oldSensor.id);
            }
          }
        }

        // Добавляем новые сенсоры в конфиг
        for (SensorInfo sensor in toInsertSensorList) {
          final String sensorId = await datasource.insertSensors(
            configId: configId,
            title: sensor.title,
            sensorType: sensor.sensorType,
            details: sensor.details,
          );
          final List<AlertData> alertList = [];
          for (AlertData alert in sensor.alerts) {
            final String alertId = await datasource.insertAlerts(
              sensorId: sensorId,
              type: alert.type,
              message: alert.message,
              title: alert.title,
              description: alert.description,
            );
            final List<SensorRule> ruleList = [];
            for (SensorRule rule in alert.sensorRuleList) {
              final String ruleId;
              // если правило уже существует в бд, то у него есть id, иначе оно новое
              if (rule.id.isEmpty) {
                ruleId = await datasource.insertSensorRules(
                  value: rule.value,
                  ruleType: rule.ruleType,
                );
                ruleList.add(
                  SensorRule(
                    id: ruleId,
                    ruleType: rule.ruleType,
                    value: rule.value,
                  ),
                );
              } else {
                ruleId = rule.id;
                ruleList.add(rule);
              }

              await datasource.insertRuleGroups(alertId: alertId, ruleId: ruleId);
            }
            alertList.add(
              AlertData(
                id: alertId,
                title: alert.title,
                message: alert.message,
                description: alert.description,
                type: alert.type,
                sensorRuleList: ruleList,
              ),
            );
          }
          sensorList.add(
            SensorInfo(
              id: sensorId,
              title: sensor.title,
              details: sensor.details,
              sensorType: sensor.sensorType,
              sensorHistoryList: const [],
              alerts: alertList,
            ),
          );
        }

        //!

        return Right(
          Config(
            id: configId,
            title: configTitle,
            tabList: tabList,
            sensorList: sensorList,
          ),
        );
      }
    } catch (e, s) {
      return Left(Failure(message: s.toString()));
    }
  }
}
