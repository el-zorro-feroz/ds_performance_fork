part of './common_datasource.dart';

extension SensorRulesDatasource on CommonDatasource {
  Future<List<SensorRulesModel>?> selectAllSensorRules() async {
    try {
      final String query = await File('sql/model/sensor_rules/select_all_sensor_rules.sql').readAsString();
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

  Future<SensorRulesModel?> selectSensorRulesById({required String id}) async {
    try {
      final String query = await File('sql/model/sensor_rules/select_sensor_rules_by_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return SensorRulesModel.fromMap(request.first['sensorrules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<String> insertSensorRules({
    required double value,
    required RuleType ruleType,
  }) async {
    try {
      final String query = await File('sql/model/sensor_rules/insert_sensor_rules.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'value': value,
          'type': ruleType.name,
        },
      );

      return request[0]['sensorrules']!['id'];
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateSensorRules({
    required String id,
    double? value,
    RuleType? ruleType,
  }) async {
    try {
      final String query = await File('sql/model/sensor_rules/udate_sensor_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'value': value,
          'type': ruleType,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteSensorRules({required String id}) async {
    try {
      final String query = await File('sql/model/sensor_rules/delete_sensor_rules.sql').readAsString();
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
