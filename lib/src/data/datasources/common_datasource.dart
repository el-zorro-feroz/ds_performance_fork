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
      List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery("SELECT * FROM configs;");
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
      List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        "SELECT * FROM configs WHERE id = @id;",
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
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        "INSERT INTO configs (title) VALUES(@title);",
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
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        "DELETE FROM configs WHERE id = @id;",
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
      await PostgresModule.postgreSQLConnection.mappedResultsQuery(
        "UPDATE configs SET title = @title WHERE id = @id;",
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
