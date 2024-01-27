part of './common_datasource.dart';

extension SensorHistoryDatasource on CommonDatasource {
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

  Future<List<SensorHistoryModel>?> selectAllSensorHistoryBySensorId(String sensorId) async {
    try {
      final String query = await File('sql/model/sensor_history/select_all_sensor_history_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
        },
      );

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
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
          'beginning_period': beginningPeriod.toIso8601String(),
          'ending_period': endingPeriod.toIso8601String(),
        },
      );

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
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

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
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'sensor_id': sensorId,
          'date': date?.toIso8601String(),
          'value': value,
        },
      );

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
