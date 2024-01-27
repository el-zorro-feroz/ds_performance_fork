part of './common_datasource.dart';

extension GraphsDatasource on CommonDatasource {
  Future<List<GraphsModel>?> selectAllGraphs() async {
    try {
      final String query = await File('sql/model/graphs/select_all_graphs.sql').readAsString();
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
      final String query = await File('sql/model/graphs/select_one_graphs.sql').readAsString();
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
      final String query = await File('sql/model/graphs/insert_graphs.sql').readAsString();
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
      final String query = await File('sql/model/graphs/delete_graphs.sql').readAsString();
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
      final String query = await File('sql/model/graphs/update_graphs.sql').readAsString();
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
}
