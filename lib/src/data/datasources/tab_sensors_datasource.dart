part of './common_datasource.dart';

extension TabsensorsDatasource on CommonDatasource {
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
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
        },
      );

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
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'tab_id': tabId,
        },
      );

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
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

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
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
          'tab_id': tabId,
        },
      );

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
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'sensor_id': sensorId,
          'tab_id': tabId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteTabSensors({required String id}) async {
    try {
      final String query = await File('sql/model/tab_sensors/delete_tab_sensors.sql').readAsString();
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
