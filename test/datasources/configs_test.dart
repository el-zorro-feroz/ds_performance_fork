// ignore_for_file: prefer_function_declarations_over_variables, unnecessary_non_null_assertion

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM configs;');

  final CommonDatasource commonDatasource = services<CommonDatasource>();

  group('Common datasource configs:', () {
    test('insert config correct call test', () async {
      // Act
      await clearTables();
      final Future<Unit?> Function() insertConfigs = () async {
        try {
          return await commonDatasource.insertConfigs(title: 'test_call');
        } catch (_) {
          return null;
        }
      };
      // Arrange
      final Unit? resultOrNull = await insertConfigs();
      // Assert
      expect(resultOrNull, unit);
    });
    group('select all configs', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final List<ConfigModel>? resultOrNull = await commonDatasource.selectAllConfigs();
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        final List<String> correctResultTitles = [
          'test call 1',
          'test call 2',
        ];
        // Arrange
        await commonDatasource.insertConfigs(title: correctResultTitles.first);
        await commonDatasource.insertConfigs(title: correctResultTitles.last);
        final List<String>? resultTitlesOrNull = (await commonDatasource.selectAllConfigs())?.map((e) => e.title).toList();
        // Assert
        expect(resultTitlesOrNull, correctResultTitles);
      });
    });
    group('select one config by id', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final ConfigModel? resultOrNull = await commonDatasource.selectOneConfigsById(id: 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee');
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();

        final String correctTitle = 'test call';
        await commonDatasource.insertConfigs(title: correctTitle);
        // Arrange
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        final ConfigModel? resultOrNull = await commonDatasource.selectOneConfigsById(id: configId!);
        // Assert
        expect(resultOrNull?.title, correctTitle);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, ConfigModel?>> Function() selectOneConfigById = () async {
          try {
            return Right(await commonDatasource.selectOneConfigsById(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, ConfigModel?> resultOrLeft = await selectOneConfigById();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });

    group('update config', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final String correctTitle = 'test call';
        await commonDatasource.insertConfigs(title: 'test');
        final Future<Unit?> Function() updateConfigs = () async {
          try {
            final String? id = (await commonDatasource.selectAllConfigs())?.first.id;
            return await commonDatasource.updateConfigs(
              id: id!,
              title: correctTitle,
            );
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
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, Unit?>> Function() updateConfig = () async {
          try {
            return Right(await commonDatasource.updateConfigs(
              id: 'e',
              title: 'test',
            ));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrLeft = await updateConfig();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('delete config', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'test');
        final Future<Unit?> Function() deleteConfigs = () async {
          try {
            final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
            return await commonDatasource.deleteConfigs(id: configId!);
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await deleteConfigs();
        final List<ConfigModel>? listConfigs = await commonDatasource.selectAllConfigs();
        // Assert
        expect(resultOrNull, unit);
        expect(listConfigs, null);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, Unit?>> Function() deleteConfigs = () async {
          try {
            return Right(await commonDatasource.deleteConfigs(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrLeft = await deleteConfigs();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
  });
}
