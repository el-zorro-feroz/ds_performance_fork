part of './common_datasource.dart';

extension RuleGroupsDatasource on CommonDatasource {
  Future<List<RuleGroupsModel>?> selectAllRuleGroups() async {
    try {
      final String query = await File('sql/model/rulegroups/select_all_rule_groups.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<RuleGroupsModel> result = [];

      if (request.isEmpty) {
        return null;
      }
      for (var e in request) {
        result.add(RuleGroupsModel.fromMap(e['rulegroups']!));
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<RuleGroupsModel?> selectRuleGroupsById({required String id}) async {
    try {
      final String query = await File('sql/model/rulegroups/select_rule_groups_by_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return RuleGroupsModel.fromMap(request.first['rulegroups']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<RuleGroupsModel?> selectRuleGroupsByAlertId({required String alertId}) async {
    try {
      final String query = await File('sql/model/rulegroups/select_all_rule_groups_by_alert_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'alert_id': alertId,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return RuleGroupsModel.fromMap(request.first['rulegroups']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<RuleGroupsModel?> selectRuleGroupsByRuleId({required String ruleId}) async {
    try {
      final String query = await File('sql/model/rulegroups/select_all_rule_groups_by_rule_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'rule_id': ruleId,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return RuleGroupsModel.fromMap(request.first['rulegroups']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertRuleGroups({
    required String alertId,
    required String ruleId,
  }) async {
    try {
      final String query = await File('sql/model/rulegroups/insert_rule_groups.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'alert_id': alertId,
          'rule_id': ruleId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateRuleGroups({
    required String id,
    String? alertId,
    String? ruleId,
  }) async {
    try {
      final String query = await File('sql/model/rulegroups/update_rule_groups.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'alert_id': alertId,
          'rule_id': ruleId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteRuleGroupsById(String id) async {
    try {
      final String query = await File('sql/model/rulegroups/delete_rule_groups_by_id.sql').readAsString();
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

  Future<Unit> deleteRuleGroupsByAlertIdAndRuleId({
    required String alertId,
    required String ruleId,
  }) async {
    try {
      final String query = await File('sql/model/rulegroups/delete_rule_groups_by_alert_id_and_rule_id.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'alert_id': alertId,
          'rule_id': ruleId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }
}
