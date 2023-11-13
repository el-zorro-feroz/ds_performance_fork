part of './common_datasource.dart';

extension TabsDatasource on CommonDatasource {
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
        substitutionValues: {
          'config_id': configId,
        },
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
        substitutionValues: {
          'id': id,
        },
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
}
