// ignore_for_file: prefer_function_declarations_over_variables
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/alerts_model.dart';
import 'package:sensors_monitoring/src/data/models/enum/alert_type.dart';
import 'package:sensors_monitoring/src/data/models/rules_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM rules;');

  final CommonDatasource commonDatasource = services<CommonDatasource>();

  group('alerts', () async {
    test('insert_alerts call test', () async {
      // Act
      await clearTables();
      // Arrange
      final Unit resultOrNull = await commonDatasource.insertRules(description: 'test');
      // Assert
      expect(resultOrNull, unit);
    });
    group('select all alerts', () {
      test('call select_all empty result test', () async {
        // Act
        await clearTables();
        // Arrange
        List<AlertsModel>? resultOrNull = await commonDatasource.selectAllAlerts();
        // Assert
        expect(resultOrNull, null);
      });
      test('call select_all result test', () async {
        // Act
        final Future<List<AlertsModel>?> Function() selectAllAlerts = () async {
          await clearTables();
          try {
            return await commonDatasource.selectAllAlerts();
          } catch (e) {
            return null;
          }
        };
        // Arrange
        final List<AlertsModel>? resultOrNull = await selectAllAlerts();
        // Assert
        expect(resultOrNull, unit);
      });
    });

    group('select one alerts by id', () {
      test('call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final AlertsModel? resultOrNull = await commonDatasource.selectOneAlerts(id: 'dsadasdsad');
        // Assert
        expect(resultOrNull, null);
      });
      test('call test correct result', () async {
        // Act
        await clearTables();

        String correctMessage = 'correctTest';
        AlertType testType = AlertType.info;
        String testRuleId = 'testRuleId';
        String testSensorId = 'testSensorId';

        await commonDatasource.insertAlerts(sensorId: testSensorId, ruleId: testRuleId, message: correctMessage, type: testType);
        // Arrange
        final String? id = (await commonDatasource.selectAllAlerts())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectOneAlerts(id: id!))?.message;
        // Assert
        expect(resultOrNull, correctMessage);
      });
    });
    group('select one alerts by rule_id', () {
      test('call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final AlertsModel? resultOrNull = await commonDatasource.selectAlertByRuleId(id: '893218038');
        // Assert
        expect(resultOrNull, null);
      });
      test('call test correct result', () async {
        // Act
        await clearTables();

        String correctMessage = 'correctTest';
        AlertType testType = AlertType.info;
        String testRuleId = 'testRuleId';
        String testSensorId = 'testSensorId';

        await commonDatasource.insertAlerts(sensorId: testSensorId, ruleId: testRuleId, message: correctMessage, type: testType);
        // Arrange
        final String? id = (await commonDatasource.selectAllAlerts())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectAlertByRuleId(id: id!))?.message;
        // Assert
        expect(resultOrNull, correctMessage);
      });
    });
    group('select one alerts by sensor_id', () {
      test('call test with empty request', () async {
        // Act
        await clearTables();
        // Arrange
        final AlertsModel? resultOrNull = await commonDatasource.selectAlertBySensorId(id: '893218038');
        // Assert
        expect(resultOrNull, null);
      });
      test('call test correct result', () async {
        // Act
        await clearTables();

        String correctMessage = 'correctTest';
        AlertType testType = AlertType.info;
        String testRuleId = 'testRuleId';
        String testSensorId = 'testSensorId';

        await commonDatasource.insertAlerts(sensorId: testSensorId, ruleId: testRuleId, message: correctMessage, type: testType);
        // Arrange
        final String? id = (await commonDatasource.selectAllAlerts())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectAlertBySensorId(id: id!))?.message;
        // Assert
        expect(resultOrNull, correctMessage);
      });
    });
    test('update alerts correct call test', () async {
      // Act
      await clearTables();

      String correctMessage = 'correctTest';
      String message = 'test';
      AlertType testType = AlertType.info;
      String testRuleId = 'testRuleId';
      String testSensorId = 'testSensorId';

      await commonDatasource.insertAlerts(sensorId: testSensorId, ruleId: testRuleId, message: message, type: testType);

      final Future<Unit?> Function() updateAlerts = () async {
        try {
          final String? id = (await commonDatasource.selectAllRules())?.first.id;
          return await commonDatasource.updateAlerts(
            id: id!,
            message: correctMessage,
          );
        } catch (_) {
          return null;
        }
      };
      // Arrange
      final Unit? resultOrNull = await updateAlerts();
      final String? resultMessageOrNull = (await commonDatasource.selectAllAlerts())?.first.message;
      // Assert
      expect(resultOrNull, unit);
      expect(resultMessageOrNull, correctMessage);
    });

    test('delete_alerts correct call test', () async {
      // Act
      await clearTables();
      final Future<Unit?> Function() deleteAlerts = () async {
        try {
          final String? id = (await commonDatasource.selectAllAlerts())?.first.id;
          if (id == null) {
            return null;
          }
          return await commonDatasource.deleteAlerts(id: id);
        } catch (e) {
          return null;
        }
      };
      // Arrange
      final Unit? resultOrNull = await deleteAlerts();
      // Assert
      expect(resultOrNull, unit);
    });
  });
}
