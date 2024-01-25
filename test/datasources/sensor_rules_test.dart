import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/sensors_rules_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTablesSensorsRules() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM sensorrules;');
  Future<PostgreSQLResult> clearTablesRules() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM rules;');
  Future<PostgreSQLResult> clearTablesSensors() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM sensors;');
  Future<PostgreSQLResult> clearTablesConfigs() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM configs;');
  final CommonDatasource commonDatasource = services<CommonDatasource>();

  String description1 = 'test1';
  String description2 = 'test2';
  double value1 = 2.0000;
  group('sensors rules', () {
    test('insert_sensors_rules call test', () async {
      //!Act
      await clearTablesRules();
      await clearTablesSensorsRules();
      await clearTablesSensors();
      await clearTablesConfigs();
      //!Arrange
      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertRules(description: description1);
      final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

      final Unit resultOrNull = await commonDatasource.insertSensorRules(
        sensorId: sensorId!,
        value: value1,
        ruleId: ruleId!,
      );
      //!Assert
      expect(resultOrNull, unit);
    });

    group('select all sensors rules', () {
      test('call select_all empty result test', () async {
        //!Act
        await clearTablesRules();
        await clearTablesSensorsRules();
        await clearTablesSensors();
        await clearTablesConfigs();
        //!Arrange
        final List<SensorRulesModel>? resultOrNull = await commonDatasource.selectAllSensorRules();
        //!Assert
        expect(resultOrNull, null);
      });
      test('call select_all result test', () async {
        //!Act
        await clearTablesRules();
        await clearTablesSensorsRules();
        await clearTablesSensors();
        await clearTablesConfigs();

        //!Arrange
        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: description1);
        final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertSensorRules(sensorId: sensorId!, value: value1, ruleId: ruleId!);

        await commonDatasource.insertConfigs(title: 'title');
        final String? configId2 = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId2!, title: 'title_sensors__', sensorType: SensorType.temperature, details: 'details');
        final String? sensorId2 = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: description2);
        final String? ruleId2 = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertSensorRules(sensorId: sensorId2!, value: value1, ruleId: ruleId2!);

        List<double> listResult = [value1, value1];

        final List<double>? resultOrNull = (await commonDatasource.selectAllSensorRules())?.map((e) => e.value).toList();
        //!Assert
        expect(resultOrNull, listResult);
      });
    });
    group('select one sensors rules by id', () {
      test('call test with empty request', () async {
        //!Act
        await clearTablesRules();
        await clearTablesSensorsRules();
        await clearTablesSensors();
        await clearTablesConfigs();
        //!Arrange
        final SensorRulesModel? resultOrNull = await commonDatasource.selectSensorRulesById(id: '87f0a680-815d-11ee-b962-0242ac120002');
        //!Assert
        expect(resultOrNull, null);
      });
      test('call test', () async {
        //!Act
        await clearTablesRules();
        await clearTablesSensorsRules();
        await clearTablesSensors();
        await clearTablesConfigs();

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: description1);
        final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertSensorRules(sensorId: sensorId!, value: value1, ruleId: ruleId!);

        //!Arrange
        final String? id = (await commonDatasource.selectAllSensorRules())?.first.id;
        final double? resultOrNull = (await commonDatasource.selectSensorRulesById(id: id!))?.value;

        //!Assert
        expect(resultOrNull, value1);
      });
    });

    group('select one sensors rules by rule_id', () {
      test('call test with empty request', () async {
        //!Act
        await clearTablesRules();
        await clearTablesSensorsRules();
        await clearTablesSensors();
        await clearTablesConfigs();
        //!Arrange
        final SensorRulesModel? resultOrNull = await commonDatasource.selectSensorRulesByRuleId(ruleId: '87f0a680-815d-11ee-b962-0242ac120002');
        //!Assert
        expect(resultOrNull, null);
      });
      test('call test', () async {
        //!Act
        await clearTablesRules();
        await clearTablesSensorsRules();
        await clearTablesSensors();
        await clearTablesConfigs();

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: description1);
        final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertSensorRules(sensorId: sensorId!, value: value1, ruleId: ruleId!);

        //!Arrange
        final String? id = (await commonDatasource.selectAllSensorRules())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectSensorRulesByRuleId(ruleId: ruleId))?.id;

        //!Assert
        expect(resultOrNull, id);
      });
    });

    group('select one sensor rules by sensor_id', () {
      test('call test with empty request', () async {
        //!Act
        await clearTablesRules();
        await clearTablesSensorsRules();
        await clearTablesSensors();
        await clearTablesConfigs();
        //!Arrange
        final SensorRulesModel? resultOrNull = await commonDatasource.selectSensorRulesBySensorId(sensorId: '87f0a680-815d-11ee-b962-0242ac120002');
        //!Assert
        expect(resultOrNull, null);
      });
      test('call test', () async {
        //!Act
        await clearTablesRules();
        await clearTablesSensorsRules();
        await clearTablesSensors();
        await clearTablesConfigs();

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertRules(description: description1);
        final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

        await commonDatasource.insertSensorRules(sensorId: sensorId!, value: value1, ruleId: ruleId!);

        //!Arrange
        final String? id = (await commonDatasource.selectAllSensorRules())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectSensorRulesBySensorId(sensorId: sensorId))?.id;

        //!Assert
        expect(resultOrNull, id);
      });
    });

    test('update graph sensor correct call test', () async {
      //!Act
      await clearTablesRules();
      await clearTablesSensorsRules();
      await clearTablesSensors();
      await clearTablesConfigs();

      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertRules(description: description1);
      final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

      await commonDatasource.insertSensorRules(sensorId: sensorId!, value: value1, ruleId: ruleId!);
      //!Arrange
      double value2 = 1.00;
      final String? id = (await commonDatasource.selectAllSensorRules())?.first.id;
      final Unit resultOrNull = await commonDatasource.updateSensorRules(id: id!, value: value2);

      final double? resultDepTypeOrNull = (await commonDatasource.selectAllSensorRules())?.first.value;
      //!Assert
      expect(resultOrNull, unit);
      expect(resultDepTypeOrNull, value2);
    });

    test('delete_graph_sensor correct call test', () async {
      //!Act
      await clearTablesRules();
      await clearTablesSensorsRules();
      await clearTablesSensors();
      await clearTablesConfigs();

      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertRules(description: description1);
      final String? ruleId = (await commonDatasource.selectAllRules())?.first.id;

      await commonDatasource.insertSensorRules(sensorId: sensorId!, value: value1, ruleId: ruleId!);
      //!Arrange
      final String? id = (await commonDatasource.selectAllSensorRules())?.first.id;
      final Unit resultOrNull = await commonDatasource.deleteSensorRulesById(id: id!);
      //!Assert
      expect(resultOrNull, unit);
    });
  });
}
