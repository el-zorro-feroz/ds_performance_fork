part of './common_datasource.dart';

extension ConfigsDatasource on CommonDatasource {
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

  Future<String> insertConfigs({required String title}) async {
    try {
      final String query = await File('sql/model/configs/insert_configs.sql').readAsString();
      final request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'title': title,
        },
      );

      return request[0]['configs']!['id'];
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
}
