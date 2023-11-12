// ignore_for_file: prefer_function_declarations_over_variables, unnecessary_non_null_assertion

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/sensor_history_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM configs;');

  final CommonDatasource commonDatasource = services<CommonDatasource>();

  group('Common datasource sensor history:', () {
    group('insert sensor history', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final Future<Unit?> Function() insertSensorsHistory = () async {
          try {
            await commonDatasource.insertConfigs(title: 'config');
            final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
            await commonDatasource.insertSensors(
              configId: configId!,
              title: 'test',
              sensorType: SensorType.humidity,
              details: 'test_details',
            );
            final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;
            return await commonDatasource.insertSensorHistory(
              sensorId: sensorId!,
              date: DateTime.now(),
              value: 1.0,
            );
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await insertSensorsHistory();
        // Assert
        expect(resultOrNull, unit);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        final Future<Either<Unit, Unit?>> Function() insertSensors = () async {
          try {
            return Right(
              await commonDatasource.insertSensorHistory(
                sensorId: 'e',
                date: DateTime.now(),
                value: 1.0,
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
    group('select all sensor history', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final List<SensorHistoryModel>? resultOrNull = await commonDatasource.selectAllSensorHistory();
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        await commonDatasource.insertConfigs(title: 'config2');
        final List<String>? configsId = (await commonDatasource.selectAllConfigs())?.map((e) => e.id).toList();
        await commonDatasource.insertSensors(
          configId: configsId!.first,
          title: 'sensor1',
          sensorType: SensorType.humidity,
          details: 'test_details',
        );
        await commonDatasource.insertSensors(
          configId: configsId!.last,
          title: 'sensor2',
          sensorType: SensorType.temperature,
          details: 'test_details',
        );
        final List<String>? sensorsId = (await commonDatasource.selectAllSensors())?.map((e) => e.id).toList();
        final List<double> correctResultValues = [1.0, 15.0];
        await commonDatasource.insertSensorHistory(
          sensorId: sensorsId!.first,
          date: DateTime.now(),
          value: correctResultValues.first,
        );
        await commonDatasource.insertSensorHistory(
          sensorId: sensorsId!.last,
          date: DateTime.now(),
          value: correctResultValues.last,
        );
        // Arrange
        final List<double>? resultValuesOrNull = (await commonDatasource.selectAllSensorHistory())?.map((e) => e.value).toList();
        // Assert
        expect(resultValuesOrNull, correctResultValues);
      });
    });
    group('select all sensor history by sensor id', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        await commonDatasource.insertSensors(
          configId: configId!,
          title: 'sensor1',
          sensorType: SensorType.humidity,
          details: 'details',
        );
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;
        // Arrange
        final List<SensorHistoryModel>? resultOrNull = await commonDatasource.selectAllSensorHistoryBySensorId(sensorId: sensorId!);
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        final List<double> correctResultValues = [
          1.0,
          6.0,
          10.0,
        ];
        await commonDatasource.insertSensors(
          configId: configId!,
          title: 'sensor1',
          sensorType: SensorType.humidity,
          details: 'test_details',
        );
        await commonDatasource.insertSensors(
          configId: configId!,
          title: 'sensor2',
          sensorType: SensorType.temperature,
          details: 'test_details',
        );
        final List<String>? sensorsId = (await commonDatasource.selectAllSensors())?.map((e) => e.id).toList();
        await commonDatasource.insertSensorHistory(
          sensorId: sensorsId!.first,
          date: DateTime.now(),
          value: correctResultValues[0],
        );
        await commonDatasource.insertSensorHistory(
          sensorId: sensorsId!.first,
          date: DateTime.now(),
          value: correctResultValues[1],
        );
        await commonDatasource.insertSensorHistory(
          sensorId: sensorsId!.last,
          date: DateTime.now(),
          value: correctResultValues[2],
        );
        // Arrange
        final List<double>? resultValuesOrNullByFisrtSensorId = (await commonDatasource.selectAllSensorHistoryBySensorId(sensorId: sensorsId!.first))?.map((e) => e.value).toList();
        final List<double>? resultValuesOrNullByLastSensorId = (await commonDatasource.selectAllSensorHistoryBySensorId(sensorId: sensorsId!.last))?.map((e) => e.value).toList();
        // Assert
        expect(resultValuesOrNullByFisrtSensorId, correctResultValues.sublist(0, 2));
        expect(resultValuesOrNullByLastSensorId, correctResultValues.sublist(2));
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, List<SensorHistoryModel>?>> Function() selectAllSensorHistoryBySensorId = () async {
          try {
            return Right(await commonDatasource.selectAllSensorHistoryBySensorId(sensorId: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, List<SensorHistoryModel>?> resultOrLeft = await selectAllSensorHistoryBySensorId();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('select all sensor history by sensor id and period', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        await commonDatasource.insertSensors(
          configId: configId!,
          title: 'sensor1',
          sensorType: SensorType.humidity,
          details: 'details',
        );
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;
        // Arrange
        final List<SensorHistoryModel>? resultOrNull = await commonDatasource.selectAllSensorHistoryBySensorIdAndPeriod(
          sensorId: sensorId!,
          beginningPeriod: DateTime(2022),
          endingPeriod: DateTime(2023),
        );
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        final List<double> correctResultValues = [
          1.0,
          6.0,
          10.0,
        ];
        await commonDatasource.insertSensors(
          configId: configId!,
          title: 'sensor1',
          sensorType: SensorType.humidity,
          details: 'test_details',
        );
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;
        await commonDatasource.insertSensorHistory(
          sensorId: sensorId!,
          date: DateTime(2022),
          value: correctResultValues[0],
        );
        await commonDatasource.insertSensorHistory(
          sensorId: sensorId!,
          date: DateTime(2022),
          value: correctResultValues[1],
        );
        await commonDatasource.insertSensorHistory(
          sensorId: sensorId!,
          date: DateTime(2023),
          value: correctResultValues[2],
        );
        // Arrange
        final List<double>? resultValuesOrNullByFisrtPeriod = (await commonDatasource.selectAllSensorHistoryBySensorIdAndPeriod(
          sensorId: sensorId!,
          beginningPeriod: DateTime(2022),
          endingPeriod: DateTime(2022),
        ))
            ?.map((e) => e.value)
            .toList();
        final List<double>? resultValuesOrNullBySecondPeriod = (await commonDatasource.selectAllSensorHistoryBySensorIdAndPeriod(
          sensorId: sensorId!,
          beginningPeriod: DateTime(2023),
          endingPeriod: DateTime(2023),
        ))
            ?.map((e) => e.value)
            .toList();
        // Assert
        expect(resultValuesOrNullByFisrtPeriod, correctResultValues.sublist(0, 2));
        expect(resultValuesOrNullBySecondPeriod, correctResultValues.sublist(2));
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, List<SensorHistoryModel>?>> Function() selectAllSensorHistoryBySensorIdAndPeriod = () async {
          try {
            return Right(await commonDatasource.selectAllSensorHistoryBySensorIdAndPeriod(
              sensorId: 'e',
              beginningPeriod: DateTime(2022),
              endingPeriod: DateTime(2023),
            ));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, List<SensorHistoryModel>?> resultOrLeft = await selectAllSensorHistoryBySensorIdAndPeriod();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('select one sensor history by id', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final SensorHistoryModel? resultOrNull = await commonDatasource.selectOneSensorHistoryById(id: 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee');
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        final double correctValue = 2.0;
        await commonDatasource.insertConfigs(title: 'config');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        await commonDatasource.insertSensors(
          configId: configId!,
          title: 'sensor_test',
          sensorType: SensorType.temperature,
          details: 'test_details',
        );
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;
        await commonDatasource.insertSensorHistory(
          sensorId: sensorId!,
          date: DateTime.now(),
          value: correctValue,
        );
        final String? sensorHistoryId = (await commonDatasource.selectAllSensorHistory())?.first.id;
        // Arrange
        final SensorHistoryModel? resultOrNull = await commonDatasource.selectOneSensorHistoryById(id: sensorHistoryId!);
        // Assert
        expect(resultOrNull?.value, correctValue);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, SensorHistoryModel?>> Function() selectOneSensorHistoryById = () async {
          try {
            return Right(await commonDatasource.selectOneSensorHistoryById(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, SensorHistoryModel?> resultOrLeft = await selectOneSensorHistoryById();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('update sensor', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final double correctValue = 2.0;

        final Future<Unit?> Function() updateSensorHistory = () async {
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
            await commonDatasource.insertSensorHistory(
              sensorId: sensorId!,
              date: DateTime.now(),
              value: 1.0,
            );
            final String? sensorHistoryId = (await commonDatasource.selectAllSensorHistory())?.first.id;

            return await commonDatasource.updateSensorHistory(
              id: sensorHistoryId!,
              value: correctValue,
            );
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await updateSensorHistory();
        final double? resultValueOrNull = (await commonDatasource.selectAllSensorHistory())?.first.value;
        // Assert
        expect(resultOrNull, unit);
        expect(resultValueOrNull, correctValue);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, Unit?>> Function() updateSensors = () async {
          try {
            return Right(await commonDatasource.updateSensorHistory(
              id: 'e',
              value: 1.0,
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
    group('delete sensor history', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final Future<Unit?> Function() deleteSensorHistory = () async {
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
            await commonDatasource.insertSensorHistory(sensorId: sensorId!, date: DateTime.now(), value: 1.0);
            final String? sensorHistoryId = (await commonDatasource.selectAllSensorHistory())?.first.id;

            return await commonDatasource.deleteSensorHistory(id: sensorHistoryId!);
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await deleteSensorHistory();
        final List<SensorHistoryModel>? listSensorHistory = await commonDatasource.selectAllSensorHistory();
        // Assert
        expect(resultOrNull, unit);
        expect(listSensorHistory, null);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, Unit?>> Function() deleteSensorHistory = () async {
          try {
            return Right(await commonDatasource.deleteSensorHistory(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrLeft = await deleteSensorHistory();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
  });
}
