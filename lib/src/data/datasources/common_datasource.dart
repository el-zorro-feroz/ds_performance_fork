import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/models/alerts_model.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/src/data/models/enum/alert_type.dart';
import 'package:sensors_monitoring/src/data/models/enum/graph_dependency.dart';
import 'package:sensors_monitoring/src/data/models/enum/graph_type.dart';
import 'package:sensors_monitoring/src/data/models/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/graph_sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/graphs_model.dart';
import 'package:sensors_monitoring/src/data/models/rules_model.dart';
import 'package:sensors_monitoring/src/data/models/sensor_history_model.dart';
import 'package:sensors_monitoring/src/data/models/sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/sensors_rules_model.dart';
import 'package:sensors_monitoring/src/data/models/tab_sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/tabs_model.dart';

@Injectable()
class CommonDatasource {
  final PostgresModule postgresModule;

  CommonDatasource({required this.postgresModule});

  //! -----Configs-----
  Future<List<ConfigModel>?> selectAllConfigs() async {
    try {
      final String query = await File('sql/model/configs/select_all_config.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);

      if (request.isEmpty) {
        return null;
      }

      final List<ConfigModel> result = [];
      for (var e in request) {
        result.add(ConfigModel.fromMap(e['configs']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<ConfigModel?> selectOneConfigsById({required String id}) async {
    try {
      final String query = await File('sql/model/configs/select_one_config.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return ConfigModel.fromMap(request.first['configs']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertConfigs({required String title}) async {
    try {
      final String query = await File('sql/model/configs/insert_configs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'title': title,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateConfigs({required String id, required String title}) async {
    try {
      final String query = await File('sql/model/configs/update_configs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'title': title,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteConfigs({required String id}) async {
    try {
      final String query = await File('sql/model/configs/delete_configs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----Tabs-----
  Future<List<TabsModel>?> selectAllTabs() async {
    try {
      final String query = await File('sql/model/tabs/select_all_tabs.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);

      if (request.isEmpty) {
        return null;
      }

      final List<TabsModel> result = [];
      for (var e in request) {
        result.add(TabsModel.fromMap(e['tabs']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<TabsModel>?> selectAllTabsByConfigId({required String configId}) async {
    try {
      final String query = await File('sql/model/tabs/select_all_tabs_by_config_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {'config_id': configId},
      );

      if (request.isEmpty) {
        return null;
      }

      final List<TabsModel> result = [];
      for (var e in request) {
        result.add(TabsModel.fromMap(e['tabs']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<TabsModel?> selectOneTabsById({required String id}) async {
    try {
      final String query = await File('sql/model/tabs/select_one_tabs.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {'id': id},
      );

      if (request.isEmpty) {
        return null;
      }

      return TabsModel.fromMap(request.first['tabs']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertTabs({
    required String configId,
    required String title,
  }) async {
    try {
      final String query = await File('sql/model/tabs/insert_tabs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'config_id': configId,
          'title': title,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateTabs({
    required String id,
    required String title,
  }) async {
    try {
      final String query = await File('sql/model/tabs/update_tabs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'title': title,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteTabs({required String id}) async {
    try {
      final String query = await File('sql/model/tabs/delete_tabs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----Sensors-----
  Future<List<SensorsModel>?> selectAllSensors() async {
    try {
      final String query = await File('sql/model/sensors/select_all_sensors.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);

      if (request.isEmpty) {
        return null;
      }

      final List<SensorsModel> result = [];
      for (var e in request) {
        result.add(SensorsModel.fromMap(e['sensors']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<SensorsModel>?> selectAllSensorsByConfigId({required String configId}) async {
    try {
      final String query = await File('sql/model/sensors/select_all_sensors_by_config_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'config_id': configId,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      final List<SensorsModel> result = [];
      for (var e in request) {
        result.add(SensorsModel.fromMap(e['sensors']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<SensorsModel?> selectOneSensorsById({required String id}) async {
    try {
      final String query = await File('sql/model/sensors/select_one_sensors.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return SensorsModel.fromMap(request.first['sensors']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertSensors({
    required String configId,
    required String title,
    required SensorType sensorType,
    required String details,
  }) async {
    try {
      final String query = await File('sql/model/sensors/insert_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'config_id': configId,
          'title': title,
          'type': sensorType.name,
          'details': details,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateSensors({
    required String id,
    String? title,
    SensorType? sensorType,
    String? details,
  }) async {
    try {
      final String query = await File('sql/model/sensors/update_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'title': title,
          'type': sensorType?.name,
          'details': details,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteSensors({required String id}) async {
    try {
      final String query = await File('sql/model/sensors/delete_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----TabSensors-----
  Future<List<TabSensorsModel>?> selectAllTabSensors() async {
    try {
      final String query = await File('sql/model/tab_sensors/select_all_tab_sensors.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);

      if (request.isEmpty) {
        return null;
      }

      final List<TabSensorsModel> result = [];
      for (var e in request) {
        result.add(TabSensorsModel.fromMap(e['tabsensors']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<TabSensorsModel>?> selectAllTabSensorsBySensorId({required String sensorId}) async {
    try {
      final String query = await File('sql/model/tab_sensors/select_all_tab_sensors_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'sensor_id': sensorId,
      });

      if (request.isEmpty) {
        return null;
      }

      final List<TabSensorsModel> result = [];
      for (var e in request) {
        result.add(TabSensorsModel.fromMap(e['tabsensors']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<TabSensorsModel>?> selectAllTabSensorsByTabId({required String tabId}) async {
    try {
      final String query = await File('sql/model/tab_sensors/select_all_tab_sensors_by_tab_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'tab_id': tabId,
      });

      if (request.isEmpty) {
        return null;
      }

      final List<TabSensorsModel> result = [];
      for (var e in request) {
        result.add(TabSensorsModel.fromMap(e['tabsensors']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<TabSensorsModel?> selectOneTabSensorsById({required String id}) async {
    try {
      final String query = await File('sql/model/tab_sensors/select_one_tab_sensors.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return TabSensorsModel.fromMap(request.first['tabsensors']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertTabSensors({
    required String sensorId,
    required String tabId,
  }) async {
    try {
      final String query = await File('sql/model/tab_sensors/insert_tab_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'sensor_id': sensorId,
        'tab_id': tabId,
      });

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //? Need update query for TabSensors table?
  Future<Unit> updateTabSensors({
    required String id,
    String? sensorId,
    String? tabId,
  }) async {
    try {
      final String query = await File('sql/model/tab_sensors/update_tab_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
        'sensor_id': sensorId,
        'tab_id': tabId,
      });

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteTabSensors({required String id}) async {
    try {
      final String query = await File('sql/model/tab_sensors/delete_tab_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----SensorHistory-----
  Future<List<SensorHistoryModel>?> selectAllSensorHistory() async {
    try {
      final String query = await File('sql/model/sensor_history/select_all_sensor_history.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);

      if (request.isEmpty) {
        return null;
      }

      final List<SensorHistoryModel> result = [];
      for (var e in request) {
        result.add(SensorHistoryModel.fromMap(e['sensorhistory']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<SensorHistoryModel>?> selectAllSensorHistoryBySensorId({required String sensorId}) async {
    try {
      final String query = await File('sql/model/sensor_history/select_all_sensor_history_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'sensor_id': sensorId,
      });

      if (request.isEmpty) {
        return null;
      }

      final List<SensorHistoryModel> result = [];
      for (var e in request) {
        result.add(SensorHistoryModel.fromMap(e['sensorhistory']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<SensorHistoryModel>?> selectAllSensorHistoryBySensorIdAndPeriod({
    required String sensorId,
    required DateTime beginningPeriod,
    required DateTime endingPeriod,
  }) async {
    try {
      final String query = await File('sql/model/sensor_history/select_all_sensor_history_by_id_and_period.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'sensor_id': sensorId,
        'beginning_period': beginningPeriod.toIso8601String(),
        'ending_period': endingPeriod.toIso8601String(),
      });

      if (request.isEmpty) {
        return null;
      }

      final List<SensorHistoryModel> result = [];
      for (var e in request) {
        result.add(SensorHistoryModel.fromMap(e['sensorhistory']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<SensorHistoryModel?> selectOneSensorHistoryById({required String id}) async {
    try {
      final String query = await File('sql/model/sensor_history/select_one_sensor_history.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return SensorHistoryModel.fromMap(request.first['sensorhistory']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertSensorHistory({
    required String sensorId,
    required DateTime date,
    required double value,
  }) async {
    try {
      final String query = await File('sql/model/sensor_history/insert_sensor_history.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'sensor_id': sensorId,
        'date': date.toIso8601String(),
        'value': value,
      });

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //? Need update query for SensorHistory table?
  Future<Unit> updateSensorHistory({
    required String id,
    String? sensorId,
    DateTime? date,
    double? value,
  }) async {
    try {
      final String query = await File('sql/model/sensor_history/update_sensor_history.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
        'sensor_id': sensorId,
        'date': date?.toIso8601String(),
        'value': value,
      });

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //? Need delete query for SensorHistory table?
  Future<Unit> deleteSensorHistory({
    required String id,
  }) async {
    try {
      final String query = await File('sql/model/sensor_history/delete_sensor_history.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----Graphs-----
  Future<List<GraphsModel>?> selectAllGraphs() async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/select_all_graphs.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<GraphsModel> result = [];

      if (request.isEmpty) {
        return null;
      }
      for (var e in request) {
        result.add(GraphsModel.fromMap(e['graphs']!));
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<GraphsModel?> selectOneGraphs({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/select_one_graphs.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return GraphsModel.fromMap(request.first['graphs']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertGraphs({
    required GraphDependency dependency,
    required GraphType type,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/insert_graphs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'type': type.name,
          'dependency': dependency.name,
        },
      );
      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteGraphs({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/delete_graphs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );
      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateGraphs({
    required String id,
    GraphDependency? dependency,
    GraphType? type,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/update_graphs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'type': type?.name,
          'dependency': dependency?.name,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----Alerts-----
  Future<List<AlertsModel>?> selectAllAlerts() async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/select_all_graphs.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<AlertsModel> result = [];

      if (request.isEmpty) {
        return null;
      }
      for (var e in request) {
        result.add(AlertsModel.fromMap(e['alerts']!));
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<AlertsModel?> selectOneAlerts({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/alerts/select_one_alert.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return AlertsModel.fromMap(request.first['alerts']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<AlertsModel?> selectAlertByRuleId({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/alerts/select_alert_by_rule_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return AlertsModel.fromMap(request.first['alerts']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<AlertsModel?> selectAlertBySensorId({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/alerts/select_alert_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return AlertsModel.fromMap(request.first['alerts']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertAlerts({
    required String sensorId,
    required String ruleId,
    required String message,
    required AlertType type,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/alerts/insert_alerts.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
          'rule_id': ruleId,
          'message': message,
          'type': type.name,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateAlerts({
    required String id,
    String? sensorId,
    String? ruleId,
    String? message,
    AlertType? type,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/alerts/update_alerts.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'sensor_id': sensorId,
          'rule_id': ruleId,
          'message': message,
          'type': type?.name,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteAlerts({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/alerts/delete_alerts.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----Rules-----
  Future<List<RulesModel>?> selectAllRules() async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/select_all_rules.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<RulesModel> result = [];

      if (request.isEmpty) {
        return null;
      }

      for (var e in request) {
        result.add(RulesModel.fromMap(e['rules']!));
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<RulesModel?> selectOneRules({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/select_one_rules.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return RulesModel.fromMap(request.first['rules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertRules({
    required String description,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs/insert_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'description': description,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateRules({
    required String id,
    String? description,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/rules/update_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'description': description,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteRules({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/rules/delete_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----GraphsSensor-----
  Future<List<GraphSensorsModel>?> selectAllGraphSensors() async {
    try {
      final String query = await File('C:/fac/sql/model/graphs_sensors/select_all_graph_sensors.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<GraphSensorsModel> result = [];

      if (request.isEmpty) {
        return null;
      }
      for (var e in request) {
        result.add(GraphSensorsModel.fromMap(e['graphssensors']!));
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<GraphSensorsModel?> selectGraphSensorsByGraphsId({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs_sensors/select_graph_sensors_by_graphs_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return GraphSensorsModel.fromMap(request.first['graphssensor']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<GraphSensorsModel?> selectGraphSensorsBySensorId({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs_sensors/select_graph_sensors_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return GraphSensorsModel.fromMap(request.first['graphssensor']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertGraphSensors({
    required String sensorId,
    required String graphsId,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs_sensors/insert_graph_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
          'graphs_id': graphsId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateGraphSensors({
    required String id,
    String? sensorId,
    String? graphsId,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs_sensors/update_graph_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'sensor_id': sensorId,
          'graphs_id': graphsId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteGraphSensors({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/graphs_sensors/delete_graph_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  //! -----SensorRules-----
  Future<List<SensorRulesModel>?> selectAllSensorRules() async {
    try {
      final String query = await File('C/fac/sql/model/sensor_rules/select_all_sensor_rules.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<SensorRulesModel> result = [];

      if (request.isEmpty) {
        return null;
      }
      for (var e in request) {
        result.add(SensorRulesModel.fromMap(e['sensorrules']!));
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<SensorRulesModel?> selectOneSensorRules({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/sensor_rules/select_one_sensor_rules.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return SensorRulesModel.fromMap(request.first['sensorrules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<SensorRulesModel?> selectSensorRulesByRuleId({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/sensor_rules/select_sensor_rules_by_rule_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return SensorRulesModel.fromMap(request.first['sensorrules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<SensorRulesModel?> selectSensorRulesBySensorId({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/sensor_rules/select_sensor_rules_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return SensorRulesModel.fromMap(request.first['sensorrules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertSensorRules({
    required double value,
    required String ruleId,
    required String sensorId,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/sensor_rules/insert_sensor_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'value': value,
          'sensor_id': sensorId,
          'rule_id': ruleId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateSensorRules({
    required String id,
    double? value,
    String? ruleId,
    String? sensorId,
  }) async {
    try {
      final String query = await File('C:/fac/sql/model/sensor_rules/udate_sensor_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'value': value,
          'sensor_id': sensorId,
          'rule_id': ruleId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteSensorRules({required String id}) async {
    try {
      final String query = await File('C:/fac/sql/model/sensor_rules/delete_sensor_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }
}
