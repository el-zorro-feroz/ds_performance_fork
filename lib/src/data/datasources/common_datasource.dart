import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/src/data/models/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/sensor_history_model.dart';
import 'package:sensors_monitoring/src/data/models/sensors_model.dart';
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
}
