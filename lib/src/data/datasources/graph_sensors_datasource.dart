part of './common_datasource.dart';

extension GraphSensorsDatasource on CommonDatasource {
  Future<List<GraphSensorsModel>?> selectAllGraphSensors() async {
    try {
      final String query = await File('sql/model/graphs_sensors/select_all_graph_sensors.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<GraphSensorsModel> result = [];

      if (request.isEmpty) {
        return null;
      }
      for (var e in request) {
        result.add(GraphSensorsModel.fromMap(e['graphsensors']!));
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<GraphSensorsModel?> selectGraphSensorsByGraphsId({required String graphsId}) async {
    try {
      final String query = await File('sql/model/graphs_sensors/select_graph_sensors_by_graphs_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'graphs_id': graphsId,
      });

      if (request.isEmpty) {
        return null;
      }

      return GraphSensorsModel.fromMap(request.first['graphsensors']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<GraphSensorsModel?> selectGraphSensorsBySensorId({required String sensorId}) async {
    try {
      final String query = await File('sql/model/graphs_sensors/select_graph_sensors_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'sensor_id': sensorId,
      });

      if (request.isEmpty) {
        return null;
      }

      return GraphSensorsModel.fromMap(request.first['graphsensors']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertGraphSensors({
    required String sensorId,
    required String graphsId,
  }) async {
    try {
      final String query = await File('sql/model/graphs_sensors/insert_graph_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
          'graphs_id': graphsId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateGraphSensors({
    required String id,
    String? sensorId,
    String? graphsId,
  }) async {
    try {
      final String query = await File('sql/model/graphs_sensors/update_graph_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'graphs_id': graphsId,
          'sensor_id': sensorId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteGraphSensors({required String id}) async {
    try {
      final String query = await File('sql/model/graphs_sensors/delete_graph_sensors.sql').readAsString();
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
