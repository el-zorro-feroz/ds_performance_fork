part of './common_datasource.dart';

extension SensorsDatasource on CommonDatasource {
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

  Future<String> insertSensors({
    required String configId,
    required String title,
    required SensorType sensorType,
    required String details,
  }) async {
    try {
      final String query = await File('sql/model/sensors/insert_sensors.sql').readAsString();
      final request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'config_id': configId,
          'title': title,
          'type': sensorType.name,
          'details': details,
        },
      );

      return request[0]['sensors']!['id'];
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

  Future<Unit> deleteSensorsById(String id) async {
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
}
