part of './common_datasource.dart';

extension AlertsDatasource on CommonDatasource {
  Future<List<AlertsModel>?> selectAllAlerts() async {
    try {
      final String query = await File('sql/model/alerts/select_all_alerts.sql').readAsString();
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

  //TODO NOT TESTED
  Future<List<Map<String, Map<String, dynamic>>>?> selectAllAlertsBySensorId(String id) async {
    try {
      final String query = await File('sql/subquery/get_alerts.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {'sensor_id': id},
      );

      if (request.isEmpty) {
        return null;
      }

      return request;
    } catch (_) {
      rethrow;
    }
  }

  Future<AlertsModel?> selectOneAlerts({required String id}) async {
    try {
      final String query = await File('sql/model/alerts/select_one_alert.sql').readAsString();
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

  Future<AlertsModel?> selectAlertBySensorId({required String sensorId}) async {
    try {
      final String query = await File('sql/model/alerts/select_alert_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
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

  Future<String> insertAlerts({
    required String sensorId,
    required AlertType type,
    required String message,
    required String title,
    required String description,
  }) async {
    try {
      final String query = await File('sql/model/alerts/insert_alerts.sql').readAsString();
      final request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
          'message': message,
          'type': type.name,
          'title': title,
          'description': description,
        },
      );

      return request[0]['alerts']!['id'];
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateAlerts({
    required String id,
    String? sensorId,
    String? message,
    AlertType? type,
    String? title,
    String? description,
  }) async {
    try {
      final String query = await File('sql/model/alerts/update_alerts.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'sensor_id': sensorId,
          'message': message,
          'type': type?.name,
          'title': title,
          'description': description,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteAlerts({required String id}) async {
    try {
      final String query = await File('sql/model/alerts/delete_alerts.sql').readAsString();
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
