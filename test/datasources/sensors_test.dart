// ignore_for_file: prefer_function_declarations_over_variables, unnecessary_non_null_assertion

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/sensors_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM configs;');

  final CommonDatasource commonDatasource = services<CommonDatasource>();

  group('Common datasource sensors:', () {
    group('insert sensor', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final Future<Unit?> Function() insertSensors = () async {
          try {
            await commonDatasource.insertConfigs(title: 'config');
            final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
            return await commonDatasource.insertSensors(
              configId: configId!,
              title: 'test',
              sensorType: SensorType.humidity,
              details: 'test_details',
            );
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await insertSensors();
        // Assert
        expect(resultOrNull, unit);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        final Future<Either<Unit, Unit?>> Function() insertSensors = () async {
          try {
            return Right(
              await commonDatasource.insertSensors(
                configId: 'e',
                title: 'test',
                sensorType: SensorType.humidity,
                details: 'test_details',
              ),
            );
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrNull = await insertSensors();
        // Assert
        expect(resultOrNull.isLeft(), true);
      });
    });
    group('select all sensors', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final List<SensorsModel>? resultOrNull = await commonDatasource.selectAllSensors();
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        await commonDatasource.insertConfigs(title: 'config2');

        final List<String>? configsId = (await commonDatasource.selectAllConfigs())?.map((e) => e.id).toList();
        final List<String> correctResultTitles = [
          'sensor1',
          'sensor2',
        ];
        await commonDatasource.insertSensors(
          configId: configsId!.first,
          title: correctResultTitles.first,
          sensorType: SensorType.humidity,
          details: 'test_details',
        );
        await commonDatasource.insertSensors(
          configId: configsId!.last,
          title: correctResultTitles.last,
          sensorType: SensorType.temperature,
          details: 'test_details',
        );
        // Arrange
        final List<String>? resultTitlesOrNull = (await commonDatasource.selectAllSensors())?.map((e) => e.title).toList();
        // Assert
        expect(resultTitlesOrNull, correctResultTitles);
      });
    });
    group('select all sensors by config id', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        // Arrange
        final List<SensorsModel>? resultOrNull = await commonDatasource.selectAllSensorsByConfigId(configId: configId!);
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        await commonDatasource.insertConfigs(title: 'config2');

        final List<String>? configsId = (await commonDatasource.selectAllConfigs())?.map((e) => e.id).toList();
        final List<String> correctResultTitles = [
          'sensor1',
          'sensor2',
          'sensor3',
        ];
        await commonDatasource.insertSensors(
          configId: configsId!.first,
          title: correctResultTitles[0],
          sensorType: SensorType.humidity,
          details: 'test_details',
        );
        await commonDatasource.insertSensors(
          configId: configsId!.first,
          title: correctResultTitles[1],
          sensorType: SensorType.temperature,
          details: 'test_details',
        );
        await commonDatasource.insertSensors(
          configId: configsId!.last,
          title: correctResultTitles[2],
          sensorType: SensorType.temperature,
          details: 'test_details',
        );
        // Arrange
        final List<String>? resultTitlesOrNullByFisrtConfigId = (await commonDatasource.selectAllSensorsByConfigId(configId: configsId!.first))?.map((e) => e.title).toList();
        final List<String>? resultTitlesOrNullByLastConfigId = (await commonDatasource.selectAllSensorsByConfigId(configId: configsId!.last))?.map((e) => e.title).toList();
        // Assert
        expect(resultTitlesOrNullByFisrtConfigId, correctResultTitles.sublist(0, 2));
        expect(resultTitlesOrNullByLastConfigId, correctResultTitles.sublist(2));
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, List<SensorsModel>?>> Function() selectAllSensorsByConfigId = () async {
          try {
            return Right(await commonDatasource.selectAllSensorsByConfigId(configId: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, List<SensorsModel>?> resultOrLeft = await selectAllSensorsByConfigId();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('select one sensor by id', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final SensorsModel? resultOrNull = await commonDatasource.selectOneSensorsById(id: 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee');
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        final String correctTitle = 'sensor_test';
        await commonDatasource.insertConfigs(title: 'config');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        await commonDatasource.insertSensors(
          configId: configId!,
          title: correctTitle,
          sensorType: SensorType.temperature,
          details: 'test_details',
        );
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        // Arrange
        final SensorsModel? resultOrNull = await commonDatasource.selectOneSensorsById(id: sensorId!);
        // Assert
        expect(resultOrNull?.title, correctTitle);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, SensorsModel?>> Function() selectOneSensorsById = () async {
          try {
            return Right(await commonDatasource.selectOneSensorsById(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, SensorsModel?> resultOrLeft = await selectOneSensorsById();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('update sensor', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final String correctTitle = 'sensor_updated';

        final Future<Unit?> Function() updateSensors = () async {
          try {
            await commonDatasource.insertConfigs(title: 'config');
            final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
            await commonDatasource.insertSensors(
              configId: configId!,
              title: 'sensor_test',
              sensorType: SensorType.humidity,
              details: 'test_details',
            );
            final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

            return await commonDatasource.updateSensors(
              id: sensorId!,
              title: correctTitle,
            );
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await updateSensors();
        final String? resultTitleOrNull = (await commonDatasource.selectAllSensors())?.first.title;
        // Assert
        expect(resultOrNull, unit);
        expect(resultTitleOrNull, correctTitle);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, Unit?>> Function() updateSensors = () async {
          try {
            return Right(await commonDatasource.updateSensors(
              id: 'e',
              title: 'test',
            ));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrLeft = await updateSensors();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('delete sensor', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final Future<Unit?> Function() deleteSensors = () async {
          try {
            await commonDatasource.insertConfigs(title: 'config');
            final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
            await commonDatasource.insertSensors(
              configId: configId!,
              title: 'sensor_test',
              sensorType: SensorType.humidity,
              details: 'test_details',
            );
            final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

            return await commonDatasource.deleteSensorsById(id: sensorId!);
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await deleteSensors();
        final List<SensorsModel>? listSensors = await commonDatasource.selectAllSensors();
        // Assert
        expect(resultOrNull, unit);
        expect(listSensors, null);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, Unit?>> Function() deleteSensors = () async {
          try {
            return Right(await commonDatasource.deleteSensorsById(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrLeft = await deleteSensors();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
  });
}
