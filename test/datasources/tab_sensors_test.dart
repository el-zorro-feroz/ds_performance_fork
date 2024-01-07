// ignore_for_file: prefer_function_declarations_over_variables, unnecessary_non_null_assertion

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/tab_sensors_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM configs;');

  final CommonDatasource commonDatasource = services<CommonDatasource>();

  group('Common datasource tab sensors:', () {
    group('insert tab sensor', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final Future<Unit?> Function() insertTabSensors = () async {
          try {
            await commonDatasource.insertConfigs(title: 'config');
            final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
            await commonDatasource.insertSensors(
              configId: configId!,
              title: 'test',
              sensorType: SensorType.humidity,
              details: 'test_details',
            );
            await commonDatasource.insertTabs(
              configId: configId!,
              title: 'tab',
            );
            final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;
            final String? tabId = (await commonDatasource.selectAllTabs())?.first.id;
            return await commonDatasource.insertTabSensors(
              sensorId: sensorId!,
              tabId: tabId!,
            );
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await insertTabSensors();
        // Assert
        expect(resultOrNull, unit);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        final Future<Either<Unit, Unit?>> Function() insertTabSensors = () async {
          try {
            return Right(await commonDatasource.insertTabSensors(
              sensorId: 'e',
              tabId: 'e',
            ));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrNull = await insertTabSensors();
        // Assert
        expect(resultOrNull.isLeft(), true);
      });
    });
    group('select all sensors', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final List<TabSensorsModel>? resultOrNull = await commonDatasource.selectAllTabSensors();
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');

        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

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
        await commonDatasource.insertTabs(
          configId: configId!,
          title: 'tab1',
        );
        final String? tabId = (await commonDatasource.selectAllTabs())?.first.id;
        await commonDatasource.insertTabSensors(
          sensorId: sensorsId!.first,
          tabId: tabId!,
        );
        await commonDatasource.insertTabSensors(
          sensorId: sensorsId!.last,
          tabId: tabId!,
        );
        // Arrange
        final List<String> resultSensorsIdOrNull = [];
        final Set<String> resultTabsIdOrNull = {};
        (await commonDatasource.selectAllTabSensors())?.forEach((e) {
          resultSensorsIdOrNull.add(e.sensorId);
          resultTabsIdOrNull.add(e.tabId);
        });
        // Assert
        expect(resultSensorsIdOrNull, sensorsId);
        expect(resultTabsIdOrNull.length, 1);
        expect(resultTabsIdOrNull.first, tabId);
      });
    });
    group('select all tab sensors by sensor id', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        await commonDatasource.insertSensors(
          configId: configId!,
          title: 'sensor',
          sensorType: SensorType.humidity,
          details: 'details',
        );
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;
        // Arrange
        final List<TabSensorsModel>? resultOrNull = await commonDatasource.selectAllTabSensorsBySensorId(sensorId: sensorId!);
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

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

        await commonDatasource.insertTabs(
          configId: configId!,
          title: 'tab1',
        );
        await commonDatasource.insertTabs(
          configId: configId!,
          title: 'tab2',
        );
        await commonDatasource.insertTabs(
          configId: configId!,
          title: 'tab3',
        );
        final List<String>? tabsId = (await commonDatasource.selectAllTabs())?.map((e) => e.id).toList();

        await commonDatasource.insertTabSensors(
          sensorId: sensorsId!.first,
          tabId: tabsId![0],
        );
        await commonDatasource.insertTabSensors(
          sensorId: sensorsId!.first,
          tabId: tabsId![1],
        );
        await commonDatasource.insertTabSensors(
          sensorId: sensorsId!.last,
          tabId: tabsId![2],
        );
        // Arrange
        final List<String>? resultIdOrNullByFisrtSensorId = (await commonDatasource.selectAllTabSensorsBySensorId(sensorId: sensorsId!.first))?.map((e) => e.tabId).toList();
        final List<String>? resultIdOrNullByLastSensorId = (await commonDatasource.selectAllTabSensorsBySensorId(sensorId: sensorsId!.last))?.map((e) => e.tabId).toList();
        // Assert
        expect(resultIdOrNullByFisrtSensorId, tabsId.sublist(0, 2));
        expect(resultIdOrNullByLastSensorId, tabsId.sublist(2));
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, List<TabSensorsModel>?>> Function() selectAllTabSensorsBySensorId = () async {
          try {
            return Right(await commonDatasource.selectAllTabSensorsBySensorId(sensorId: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, List<TabSensorsModel>?> resultOrLeft = await selectAllTabSensorsBySensorId();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('select all tab sensors by tab id', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;
        await commonDatasource.insertTabs(
          configId: configId!,
          title: 'tab',
        );
        final String? tabId = (await commonDatasource.selectAllTabs())?.first.id;
        // Arrange
        final List<TabSensorsModel>? resultOrNull = await commonDatasource.selectAllTabSensorsByTabId(tabId: tabId!);
        // Assert
        expect(resultOrNull, null);
      });
      test('correct call test', () async {
        // Act
        await clearTables();
        await commonDatasource.insertConfigs(title: 'config1');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

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
        await commonDatasource.insertSensors(
          configId: configId!,
          title: 'sensor3',
          sensorType: SensorType.temperature,
          details: 'test_details',
        );
        final List<String>? sensorsId = (await commonDatasource.selectAllSensors())?.map((e) => e.id).toList();

        await commonDatasource.insertTabs(
          configId: configId!,
          title: 'tab1',
        );
        await commonDatasource.insertTabs(
          configId: configId!,
          title: 'tab2',
        );
        final List<String>? tabsId = (await commonDatasource.selectAllTabs())?.map((e) => e.id).toList();

        await commonDatasource.insertTabSensors(
          sensorId: sensorsId![0],
          tabId: tabsId!.first,
        );
        await commonDatasource.insertTabSensors(
          sensorId: sensorsId![1],
          tabId: tabsId!.first,
        );
        await commonDatasource.insertTabSensors(
          sensorId: sensorsId![2],
          tabId: tabsId!.last,
        );
        // Arrange
        final List<String>? resultIdOrNullByFisrtTabId = (await commonDatasource.selectAllTabSensorsByTabId(tabId: tabsId!.first))?.map((e) => e.sensorId).toList();
        final List<String>? resultIdOrNullByLastTabId = (await commonDatasource.selectAllTabSensorsByTabId(tabId: tabsId!.last))?.map((e) => e.sensorId).toList();
        // Assert
        expect(resultIdOrNullByFisrtTabId, sensorsId.sublist(0, 2));
        expect(resultIdOrNullByLastTabId, sensorsId.sublist(2));
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, List<TabSensorsModel>?>> Function() selectAllTabSensorsByTabId = () async {
          try {
            return Right(await commonDatasource.selectAllTabSensorsByTabId(tabId: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, List<TabSensorsModel>?> resultOrLeft = await selectAllTabSensorsByTabId();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('select one tab sensor by id', () {
      test('correct call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final TabSensorsModel? resultOrNull = await commonDatasource.selectOneTabSensorsById(id: 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee');
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
        await commonDatasource.insertTabs(
          configId: configId!,
          title: 'tab',
        );
        final String? tabId = (await commonDatasource.selectAllTabs())?.first.id;
        await commonDatasource.insertTabSensors(
          sensorId: sensorId!,
          tabId: tabId!,
        );
        final String? tabSensorId = (await commonDatasource.selectAllTabSensors())?.first.id;
        // Arrange
        final TabSensorsModel? resultOrNull = await commonDatasource.selectOneTabSensorsById(id: tabSensorId!);
        // Assert
        expect(resultOrNull?.sensorId, sensorId);
        expect(resultOrNull?.tabId, tabId);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, TabSensorsModel?>> Function() selectOneTabSensorsById = () async {
          try {
            return Right(await commonDatasource.selectOneTabSensorsById(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, TabSensorsModel?> resultOrLeft = await selectOneTabSensorsById();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('update tab sensor', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        late final String? tabChangedId;

        final Future<Unit?> Function() updateTabSensor = () async {
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

            await commonDatasource.insertTabs(
              configId: configId!,
              title: 'tab',
            );
            final String? tabId = (await commonDatasource.selectAllTabs())?.first.id;

            await commonDatasource.insertTabs(
              configId: configId!,
              title: 'tab',
            );
            tabChangedId = (await commonDatasource.selectAllTabs())?.last.id;

            await commonDatasource.insertTabSensors(
              sensorId: sensorId!,
              tabId: tabId!,
            );
            final String? tabSensorId = (await commonDatasource.selectAllTabSensors())?.first.id;

            return await commonDatasource.updateTabSensors(id: tabSensorId!, tabId: tabChangedId!);
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await updateTabSensor();
        final String? resultTitleOrNull = (await commonDatasource.selectAllTabSensors())?.first.tabId;
        // Assert
        expect(resultOrNull, unit);
        expect(resultTitleOrNull, tabChangedId);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, Unit?>> Function() updateTabSensor = () async {
          try {
            return Right(await commonDatasource.updateTabSensors(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrLeft = await updateTabSensor();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
    group('delete sensor', () {
      test('correct call test', () async {
        // Act
        await clearTables();
        final Future<Unit?> Function() deleteTabSensors = () async {
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
            await commonDatasource.insertTabs(
              configId: configId!,
              title: 'tab',
            );
            final String? tabId = (await commonDatasource.selectAllTabs())?.last.id;

            await commonDatasource.insertTabSensors(
              sensorId: sensorId!,
              tabId: tabId!,
            );
            final String? tabSensorId = (await commonDatasource.selectAllTabSensors())?.first.id;

            return await commonDatasource.deleteTabSensors(id: tabSensorId!);
          } catch (_) {
            return null;
          }
        };
        // Arrange
        final Unit? resultOrNull = await deleteTabSensors();
        final List<TabSensorsModel>? listSensors = await commonDatasource.selectAllTabSensors();
        // Assert
        expect(resultOrNull, unit);
        expect(listSensors, null);
      });
      test('incorrect call test', () async {
        // Act
        await clearTables();
        Future<Either<Unit, Unit?>> Function() deleteTabSensors = () async {
          try {
            return Right(await commonDatasource.deleteTabSensors(id: 'e'));
          } catch (_) {
            return Left(unit);
          }
        };
        // Arrange
        final Either<Unit, Unit?> resultOrLeft = await deleteTabSensors();
        // Assert
        expect(resultOrLeft.isLeft(), true);
      });
    });
  });
}
