import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';
import 'package:dartz/dartz.dart';

@Injectable()
class CommonDatasource {
  final PostgresModule postgresModule;

  CommonDatasource({required this.postgresModule});

  Future<List<ConfigModel>> selectAllConfigs() async {
    try {
      final String query = await File('sql/model/configs/select_all_config.sql').readAsString();
      List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
      List<ConfigModel> result = [];
      for (var e in request) {
        result.add(ConfigModel.fromMap(e['configs']!));
      }

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<ConfigModel> selectOneConfigsById({required String configId}) async {
    try {
      final String query = await File('sql/model/configs/select_one_config.sql').readAsString();
      List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        query,
        substitutionValues: {
          'id': configId,
        },
      );

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
}
