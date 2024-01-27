import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/alerts_model.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTablesAlerts() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM alerts;');
  Future<PostgreSQLResult> clearTablesConfigs() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM configs;');
  Future<PostgreSQLResult> clearTablesSensors() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM sensors;');
  Future<PostgreSQLResult> clearTablesRules() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM rules;');

  AlertType testType1 = AlertType.info;
  AlertType testType2 = AlertType.warning;
  String message1 = "message_test1";
  String message2 = "message_test2";
  final CommonDatasource commonDatasource = services<CommonDatasource>();
  group('alerts', () {
    test('insert_alerts call test', () async {
      // Act
      await clearTablesAlerts();
      await clearTablesConfigs();
      await clearTablesSensors();
      await clearTablesRules();
      // Arrange
      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertRules(description: 'description');
      final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

      final Unit resultOrNull = await commonDatasource.insertAlerts(
        sensorId: sensorId!,
        ruleId: ruleId!,
        type: testType1,
        message: message1,
      );
      // Assert
      expect(resultOrNull, unit);
    });
    group('select all alerts', () {
      test('call select_all empty result test', () async {
        // Act
        await clearTablesAlerts();
        await clearTablesConfigs();
        await clearTablesSensors();
        await clearTablesRules();

        // Arrange
        List<AlertsModel>? resultOrNull = await commonDatasource.selectAllAlerts();
        // Assert
        expect(resultOrNull, null);
      });
      test('call select_all result test', () async {
        // Act
        await clearTablesAlerts();
        await clearTablesConfigs();
        await clearTablesSensors();
        await clearTablesRules();

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: 'description');
        final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertAlerts(sensorId: sensorId!, ruleId: ruleId!, type: testType1, message: message1);
        await commonDatasource.insertAlerts(sensorId: sensorId, ruleId: ruleId, type: testType2, message: message2);

        List<AlertType>? listResult = [testType1, testType2];
        // Arrange
        final List<AlertType> resultOrNull = (await commonDatasource.selectAllAlerts())!.map((e) {
          debugPrint(e.type.name);
          return e.type;
        }).toList();
        // Assert
        expect(resultOrNull, listResult);
      });
    });

    group('select one alerts by id', () {
      test('call test with empty request', () async {
        // Act
        await clearTablesAlerts();
        // Arrange
        final AlertsModel? resultOrNull = await commonDatasource.selectOneAlerts(id: '51ab5296-816c-11ee-b962-0242ac120002');
        // Assert
        expect(resultOrNull, null);
      });
      test('call test correct result', () async {
        // Act
        await clearTablesAlerts();
        await clearTablesConfigs();
        await clearTablesSensors();
        await clearTablesRules();

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: 'description');
        final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertAlerts(sensorId: sensorId!, ruleId: ruleId!, type: testType1, message: message1);

        // Arrange
        final String? id = (await commonDatasource.selectAllAlerts())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectOneAlerts(id: id!))?.message;
        // Assert
        expect(resultOrNull, message1);
      });
    });
    group('select one alerts by rule_id', () {
      test('call test with empty request', () async {
        // Act
        await clearTablesAlerts();
        await clearTablesConfigs();
        await clearTablesSensors();
        await clearTablesRules();

        final AlertsModel? resultOrNull = await commonDatasource.selectAlertByRuleId(ruleId: '51ab5296-816c-11ee-b962-0242ac120002');
        // Assert
        expect(resultOrNull, null);
      });
      test('call test correct result', () async {
        // Act
        await clearTablesAlerts();
        await clearTablesConfigs();
        await clearTablesSensors();
        await clearTablesRules();

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: 'description');
        final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertAlerts(sensorId: sensorId!, ruleId: ruleId!, type: testType1, message: message1);

        // Arrange
        final String? resultOrNull = (await commonDatasource.selectAlertByRuleId(ruleId: ruleId))?.message;
        // Assert
        expect(resultOrNull, message1);
      });
    });
    group('select one alerts by sensor_id', () {
      test('call test with empty request', () async {
        // Act
        await clearTablesAlerts();
        // Arrange
        final AlertsModel? resultOrNull = await commonDatasource.selectAlertBySensorId(sensorId: '51ab5296-816c-11ee-b962-0242ac120002');
        // Assert
        expect(resultOrNull, null);
      });
      test('call test correct result', () async {
        // Act
        await clearTablesAlerts();
        await clearTablesConfigs();
        await clearTablesSensors();
        await clearTablesRules();

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: 'description');
        final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertAlerts(sensorId: sensorId!, ruleId: ruleId!, type: testType1, message: message1);

        // Arrange
        final AlertType? resultOrNull = (await commonDatasource.selectAlertBySensorId(sensorId: sensorId))?.type;
        // Assert
        expect(resultOrNull, testType1);
      });
    });
    test('update alerts correct call test', () async {
      // Act
      await clearTablesAlerts();
      await clearTablesConfigs();
      await clearTablesSensors();
      await clearTablesRules();

      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertRules(description: 'description');
      final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

      await commonDatasource.insertAlerts(sensorId: sensorId!, ruleId: ruleId!, type: testType1, message: message1);

      // Arrange
      final String? id = (await commonDatasource.selectAllAlerts())?.first.id;
      final Unit resultOrNull = await commonDatasource.updateAlerts(
        id: id!,
        message: message2,
      );
      final String? resultMessageOrNull = (await commonDatasource.selectAllAlerts())?.first.message;
      // Assert
      expect(resultOrNull, unit);
      expect(resultMessageOrNull, message2);
    });

    test('delete_alerts correct call test', () async {
      // Act
      await clearTablesAlerts();
      await clearTablesConfigs();
      await clearTablesSensors();
      await clearTablesRules();

      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertRules(description: 'description');
      final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

      await commonDatasource.insertAlerts(sensorId: sensorId!, ruleId: ruleId!, type: testType1, message: message1);

      // Arrange
      final String? id = (await commonDatasource.selectAllAlerts())?.first.id;
      final Unit resultOrNull = await commonDatasource.deleteAlertsById(id: id!);
      // Assert
      expect(resultOrNull, unit);
    });
  });
}
