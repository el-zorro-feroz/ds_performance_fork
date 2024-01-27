import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/rules_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM rules;');

  String description1 = 'test1';
  String description2 = 'test2';
  final CommonDatasource commonDatasource = services<CommonDatasource>();
  group('rules', () {
    test('insert_rules call test', () async {
      //!Act
      await clearTables();
      //!Arrange
      final Unit resultOrNull = await commonDatasource.insertRules(description: description1);
      //!Assert
      expect(resultOrNull, unit);
    });
    group('select all rules', () {
      test('call select_all empty result test', () async {
        //!Act
        await clearTables();
        //!Arrange
        final List<RulesModel>? resultOrNull = await commonDatasource.selectAllRules();
        //!Assert
        expect(resultOrNull, null);
      });
      test('call select_all result test', () async {
        //!Act
        await clearTables();

        //!Arrange
        await commonDatasource.insertRules(description: description1);
        await commonDatasource.insertRules(description: description2);
        List<String>? correctResult = [description1, description2];

        final List<String>? resultOrNull = (await commonDatasource.selectAllRules())?.map((e) => e.description).toList();
        //!Assert
        expect(resultOrNull, correctResult);
      });
    });

    group('select one rules by id', () {
      test('call test with empty request', () async {
        //!Act
        await clearTables();
        //!Arrange
        final RulesModel? resultOrNull = await commonDatasource.selectOneRules(id: '87f0a680-815d-11ee-b962-0242ac120002');
        //!Assert
        expect(resultOrNull, null);
      });
      test('call test', () async {
        //!Act
        await clearTables();
        await commonDatasource.insertRules(description: description1);

        //!Arrange
        final String? id = (await commonDatasource.selectAllRules())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectOneRules(id: id!))?.description;
        //!Assert
        expect(resultOrNull, description1);
      });
    });
    test('update rules correct call test', () async {
      //!Act
      await clearTables();

      await commonDatasource.insertRules(description: description1);
      final String? id = (await commonDatasource.selectAllRules())?.first.id;
      final Unit resultOrNull = (await commonDatasource.updateRules(id: id!, description: description2));
      //!Arrange
      final String? resultDepTypeOrNull = (await commonDatasource.selectAllRules())?.first.description;
      //!Assert
      expect(resultOrNull, unit);
      expect(resultDepTypeOrNull, description2);
    });

    test('delete_rules correct call test', () async {
      //!Act
      await clearTables();
      await commonDatasource.insertRules(description: description1);
      //!Arrange
      final String? id = (await commonDatasource.selectAllRules())?.first.id;
      final Unit resultOrNull = await commonDatasource.deleteRules(id: id!);
      //!Assert
      expect(resultOrNull, unit);
    });
  });
}
