// ignore_for_file: prefer_function_declarations_over_variables
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/rules_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM rules;');

  final CommonDatasource commonDatasource = services<CommonDatasource>();

  group('relus', () async {
    test('insert_rules call test', () async {
      // Act
      await clearTables();
      // Arrange
      final Unit resultOrNull = await commonDatasource.insertRules(description: 'test');
      // Assert
      expect(resultOrNull, unit);
    });
    group('select all relus', () {
      test('call select_all empty result test', () async {
        // Act
        await clearTables();
        // Arrange
        List<RulesModel>? resultOrNull = await commonDatasource.selectAllRules();
        // Assert
        expect(resultOrNull, null);
      });
      test('call select_all result test', () async {
        // Act
        final Future<List<RulesModel>?> Function() selectAll = () async {
          await clearTables();
          try {
            return await commonDatasource.selectAllRules();
          } catch (e) {
            return null;
          }
        };
        // Arrange
        final List<RulesModel>? resultOrNull = await selectAll();
        // Assert
        expect(resultOrNull, unit);
      });
    });

    group('select one rules by id', () {
      test('call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final RulesModel? resultOrNull = await commonDatasource.selectOneRules(id: 'ds-43f-fefsd-fsd-f-s-f-s-f-s-f--df-s-df-s-df--sd-fs-df-sd');
        // Assert
        expect(resultOrNull, null);
      });
      test('call test correct result', () async {
        // Act
        await clearTables();
        String descriptionCorrect = 'test';
        await commonDatasource.insertRules(description: descriptionCorrect);
        // Arrange
        final String? id = (await commonDatasource.selectAllRules())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectOneRules(id: id!))?.description;
        // Assert
        expect(resultOrNull, descriptionCorrect);
      });
    });
    test('update rules correct call test', () async {
      // Act
      await clearTables();
      String descriptionCorrect = 'test';
      await commonDatasource.insertRules(description: 'testing');

      final Future<Unit?> Function() updateRules = () async {
        try {
          final String? id = (await commonDatasource.selectAllRules())?.first.id;
          return await commonDatasource.updateRules(
            id: id!,
            description: descriptionCorrect,
          );
        } catch (_) {
          return null;
        }
      };
      // Arrange
      final Unit? resultOrNull = await updateRules();
      final String? resultDispOrNull = (await commonDatasource.selectAllRules())?.first.description;
      // Assert
      expect(resultOrNull, unit);
      expect(resultDispOrNull, descriptionCorrect);
    });

    test('delete_graphs correct call test', () async {
      // Act
      await clearTables();
      final Future<Unit?> Function() deleteRules = () async {
        try {
          final String? id = (await commonDatasource.selectAllRules())?.first.id;
          if (id == null) {
            return null;
          }
          return await commonDatasource.deleteRules(id: id);
        } catch (e) {
          return null;
        }
      };
      // Arrange
      final Unit? resultOrNull = await deleteRules();
      // Assert
      expect(resultOrNull, unit);
    });
  });
}
