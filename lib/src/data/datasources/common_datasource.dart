import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/models/alerts_model.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/src/data/models/enum/alert_type.dart';
import 'package:sensors_monitoring/src/data/models/enum/graph_dependency.dart';
import 'package:sensors_monitoring/src/data/models/enum/graph_type.dart';
import 'package:sensors_monitoring/src/data/models/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/graph_sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/graphs_model.dart';
import 'package:sensors_monitoring/src/data/models/rules_model.dart';
import 'package:sensors_monitoring/src/data/models/sensor_history_model.dart';
import 'package:sensors_monitoring/src/data/models/sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/sensors_rules_model.dart';
import 'package:sensors_monitoring/src/data/models/tab_sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/tabs_model.dart';

part './configs_datasource.dart';
part './sensors_datasource.dart';
part './tabs_datasource.dart';
part './tab_sensors_datasource.dart';
part './sensor_history_datasource.dart';

@Injectable()
class CommonDatasource {
  final PostgresModule postgresModule;

  CommonDatasource({required this.postgresModule});

  //! -----Graphs-----
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

  //! -----Alerts-----
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

  Future<AlertsModel?> selectAlertByRuleId({required String ruleId}) async {
    try {
      final String query = await File('sql/model/alerts/select_alert_by_rule_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'rule_id': ruleId,
      });

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
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'sensor_id': sensorId,
      });

      if (request.isEmpty) {
        return null;
      }

      return AlertsModel.fromMap(request.first['alerts']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertAlerts({
    required String sensorId,
    required String ruleId,
    required String message,
    required AlertType type,
  }) async {
    try {
      final String query = await File('sql/model/alerts/insert_alerts.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'sensor_id': sensorId,
          'rule_id': ruleId,
          'message': message,
          'type': type.name,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateAlerts({
    required String id,
    String? sensorId,
    String? ruleId,
    String? message,
    AlertType? type,
  }) async {
    try {
      final String query = await File('sql/model/alerts/update_alerts.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'sensor_id': sensorId,
          'rule_id': ruleId,
          'message': message,
          'type': type?.name,
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

  //! -----Rules-----
  Future<List<RulesModel>?> selectAllRules() async {
    try {
      final String query = await File('sql/model/rules/select_all_rules.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<RulesModel> result = [];

      if (request.isEmpty) {
        return null;
      }

      for (var e in request) {
        result.add(RulesModel.fromMap(e['rules']!));
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<RulesModel?> selectOneRules({required String id}) async {
    try {
      final String query = await File('sql/model/rules/select_one_rules.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
        },
      );

      if (request.isEmpty) {
        return null;
      }

      return RulesModel.fromMap(request.first['rules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertRules({
    required String description,
  }) async {
    try {
      final String query = await File('sql/model/rules/insert_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'description': description,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateRules({
    required String id,
    String? description,
  }) async {
    try {
      final String query = await File('sql/model/rules/update_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'description': description,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> deleteRules({required String id}) async {
    try {
      final String query = await File('sql/model/rules/delete_rules.sql').readAsString();
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

  //! -----GraphsSensor-----
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

  //! -----SensorRules-----
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

  Future<SensorRulesModel?> selectOneSensorRules({required String id}) async {
    try {
      final String query = await File('sql/model/sensor_rules/select_one_sensor_rules.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'id': id,
      });

      if (request.isEmpty) {
        return null;
      }

      return SensorRulesModel.fromMap(request.first['sensorrules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<SensorRulesModel?> selectSensorRulesByRuleId({required String ruleId}) async {
    try {
      final String query = await File('sql/model/sensor_rules/select_sensor_rules_by_rule_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'rule_id': ruleId,
      });

      if (request.isEmpty) {
        return null;
      }

      return SensorRulesModel.fromMap(request.first['sensorrules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<SensorRulesModel?> selectSensorRulesBySensorId({required String sensorId}) async {
    try {
      final String query = await File('sql/model/sensor_rules/select_sensor_rules_by_sensor_id.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query, substitutionValues: {
        'sensor_id': sensorId,
      });

      if (request.isEmpty) {
        return null;
      }

      return SensorRulesModel.fromMap(request.first['sensorrules']!);
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> insertSensorRules({
    required double value,
    required String ruleId,
    required String sensorId,
  }) async {
    try {
      final String query = await File('sql/model/sensor_rules/insert_sensor_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'value': value,
          'sensor_id': sensorId,
          'rule_id': ruleId,
        },
      );

      return unit;
    } catch (_) {
      rethrow;
    }
  }

  Future<Unit> updateSensorRules({
    required String id,
    double? value,
    String? ruleId,
    String? sensorId,
  }) async {
    try {
      final String query = await File('sql/model/sensor_rules/udate_sensor_rules.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': id,
          'value': value,
          'sensor_id': sensorId,
          'rule_id': ruleId,
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
