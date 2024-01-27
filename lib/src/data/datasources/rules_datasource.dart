// part of './common_datasource.dart';

// extension RulesDatasource on CommonDatasource {
//   Future<List<RulesModel>?> selectAllRules() async {
//     try {
//       final String query = await File('sql/model/rules/select_all_rules.sql').readAsString();
//       final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(query);
//       final List<RulesModel> result = [];

//       if (request.isEmpty) {
//         return null;
//       }

//       for (var e in request) {
//         result.add(RulesModel.fromMap(e['rules']!));
//       }
//       return result;
//     } catch (_) {
//       rethrow;
//     }
//   }

//   Future<RulesModel?> selectOneRules({required String id}) async {
//     try {
//       final String query = await File('sql/model/rules/select_one_rules.sql').readAsString();
//       final List<Map<String, Map<String, dynamic>>> request = await PostgresModule.postgreSQLConnection.mappedResultsQuery(
//         query,
//         substitutionValues: {
//           'id': id,
//         },
//       );

//       if (request.isEmpty) {
//         return null;
//       }

//       return RulesModel.fromMap(request.first['rules']!);
//     } catch (_) {
//       rethrow;
//     }
//   }

//   Future<Unit> insertRules({
//     required String description,
//   }) async {
//     try {
//       final String query = await File('sql/model/rules/insert_rules.sql').readAsString();
//       await PostgresModule.postgreSQLConnection.mappedResultsQuery(
//         query,
//         substitutionValues: {
//           'description': description,
//         },
//       );

//       return unit;
//     } catch (_) {
//       rethrow;
//     }
//   }

//   Future<Unit> updateRules({
//     required String id,
//     String? description,
//   }) async {
//     try {
//       final String query = await File('sql/model/rules/update_rules.sql').readAsString();
//       await PostgresModule.postgreSQLConnection.mappedResultsQuery(
//         query,
//         substitutionValues: {
//           'id': id,
//           'description': description,
//         },
//       );

//       return unit;
//     } catch (_) {
//       rethrow;
//     }
//   }

//   Future<Unit> deleteRules({required String id}) async {
//     try {
//       final String query = await File('sql/model/rules/delete_rules.sql').readAsString();
//       await PostgresModule.postgreSQLConnection.mappedResultsQuery(
//         query,
//         substitutionValues: {
//           'id': id,
//         },
//       );

//       return unit;
//     } catch (_) {
//       rethrow;
//     }
//   }
// }
