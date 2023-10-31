import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/src/data/models/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/tabs_model.dart';

@Injectable()
class CommonDatasource {
  final PostgresModule postgresModule;

  CommonDatasource({required this.postgresModule});

  //! -----Configs-----
  Future<List<ConfigModel>?> selectAllConfigs() async {
    try {
      final String query = await File('sql/model/configs/select_all_config.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<ConfigModel> result = [];

      if (request.isEmpty) {
        return null;
      }

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

  Future<Unit> insertConfigs({required String title}) async {
    try {
      final String query = await File('sql/model/configs/insert_configs.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'title': title,
        },
      );

      return unit;
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

  //! -----Tabs-----
  Future<List<TabsModel>?> selectAllTabs() async {
    try {
      final String query = await File('sql/model/tabs/select_all_tabs.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<TabsModel> result = [];

      if (request.isEmpty) {
        return null;
      }

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
        substitutionValues: {'config_id': configId},
      );
      final List<TabsModel> result = [];

      if (request.isEmpty) {
        return null;
      }

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
        substitutionValues: {'id': id},
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

  //! -----Sensors-----
  Future<List<SensorsModel>?> selectAllSensors() async {
    try {
      final String query = await File('sql/model/sensors/select_all_sensors.sql').readAsString();
      final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      final List<SensorsModel> result = [];

      if (request.isEmpty) {
        return null;
      }

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
      final List<SensorsModel> result = [];

      if (request.isEmpty) {
        return null;
      }

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

  Future<Unit> insertSensors({
    required String configId,
    required String title,
    required SensorType sensorType,
    required String details,
  }) async {
    try {
      final String query = await File('sql/model/sensors/insert_sensors.sql').readAsString();
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'config_id': configId,
          'title': title,
          'type': sensorType.name,
          'details': details,
        },
      );

      return unit;
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

  Future<Unit> deleteSensors({required String id}) async {
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
