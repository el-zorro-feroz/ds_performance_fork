// ignore_for_file: prefer_function_declarations_over_variables
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';

void main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM configs;');

  group('Common datasource', () {
    group('configs', () {
      test('insert configs correct call test', () async {
        // Act
        await clearTables();
        final CommonDatasource commonDatasource = services<CommonDatasource>();
        final Future<Unit?> Function() insertConfigs = () async {
          try {
            return await commonDatasource.insertConfigs(title: 'test_call');
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await insertConfigs();
        print(resultOrNull);
        // Assert
        expect(resultOrNull, unit);
      });
      group('select all configs', () {
        test('correct call test with empty request', () async {
          // Act
          await clearTables();
          final CommonDatasource commonDatasource = services<CommonDatasource>();
          // Arrange
          final List<ConfigModel>? resultOrNull = await commonDatasource.selectAllConfigs();
          // Assert
          expect(resultOrNull, null);
        });
        test('correct call test', () async {
          // Act
          await clearTables();
          final CommonDatasource commonDatasource = services<CommonDatasource>();
          final List<String> correctResultTitles = ['test call 1', 'test call 2'];
          // Arrange
          await commonDatasource.insertConfigs(title: correctResultTitles.first);
          await commonDatasource.insertConfigs(title: correctResultTitles.last);
          final List<String>? resultTitlesOrNull = (await commonDatasource.selectAllConfigs())?.map((e) => e.title).toList();
          // Assert
          expect(resultTitlesOrNull, correctResultTitles);
        });
      });
      group('select one configs by id', () {
        test('call test with empty request', () async {
          // Act
          await clearTables();
          final CommonDatasource commonDatasource = services<CommonDatasource>();
          // Arrange
          final ConfigModel? resultOrNull = await commonDatasource.selectOneConfigsById(id: 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee');
          // Assert
          expect(resultOrNull, null);
        });
        test('call test', () async {
          // Act
          await clearTables();
          final CommonDatasource commonDatasource = services<CommonDatasource>();
          final String correctTitle = 'test call';
          await commonDatasource.insertConfigs(title: correctTitle);
          // Arrange
          final String? id = (await commonDatasource.selectAllConfigs())?.first.id;
          final ConfigModel? resultOrNull = await commonDatasource.selectOneConfigsById(id: id!);
          // Assert
          expect(resultOrNull?.title, correctTitle);
        });
      });
      test('update configs correct call test', () async {
        // Act
        await clearTables();
        final String correctTitle = 'test call';
        final CommonDatasource commonDatasource = services<CommonDatasource>();
        await commonDatasource.insertConfigs(title: 'test');
        final Future<Unit?> Function() updateConfigs = () async {
          try {
            final String? id = (await commonDatasource.selectAllConfigs())?.first.id;
            return await commonDatasource.updateConfigs(id: id!, title: correctTitle);
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await updateConfigs();
        final String? resultTitleOrNull = (await commonDatasource.selectAllConfigs())?.first.title;
        // Assert
        expect(resultOrNull, unit);
        expect(resultTitleOrNull, correctTitle);
      });
      test('delete configs correct call test', () async {
        // Act
        await clearTables();
        final CommonDatasource commonDatasource = services<CommonDatasource>();
        await commonDatasource.insertConfigs(title: 'test');
        final Future<Unit?> Function() deleteConfigs = () async {
          try {
            final String? id = (await commonDatasource.selectAllConfigs())?.first.id;
            return await commonDatasource.deleteConfigs(id: id!);
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await deleteConfigs();
        // Assert
        expect(resultOrNull, unit);
      });
    });
  });
}
