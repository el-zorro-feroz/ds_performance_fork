import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/core/enum/graph_dependency.dart';
import 'package:sensors_monitoring/core/enum/graph_type.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/graph_sensors_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTablesGraphsSensors() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM graphsensors;');
  Future<PostgreSQLResult> clearTablesGraphs() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM graphs;');
  Future<PostgreSQLResult> clearTablesConsigs() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM configs;');
  Future<PostgreSQLResult> clearTablesSensors() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM sensors;');
  final CommonDatasource commonDatasource = services<CommonDatasource>();

  final GraphDependency graphDependency = GraphDependency.maximum;
  final GraphType graphType = GraphType.columnar;

  group('graph sensors', () {
    test('insert_graph_sensors call test', () async {
      //!Act
      await clearTablesGraphsSensors();
      await clearTablesGraphs();
      await clearTablesSensors();
      await clearTablesConsigs();
      //!Arrange
      await commonDatasource.insertGraphs(dependency: graphDependency, type: graphType);
      final String? graphsId = (await commonDatasource.selectAllGraphs())?.first.id;

      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      final Unit resultOrNull = await commonDatasource.insertGraphSensors(sensorId: sensorId!, graphsId: graphsId!);
      //!Assert
      expect(resultOrNull, unit);
    });

    group('select all graph sensors', () {
      test('call select_all empty result test', () async {
        //!Act
        await clearTablesGraphsSensors();
        await clearTablesGraphs();
        await clearTablesSensors();
        await clearTablesConsigs();
        //!Arrange
        final List<GraphSensorsModel>? resultOrNull = await commonDatasource.selectAllGraphSensors();
        //!Assert
        expect(resultOrNull, null);
      });
      test('call select_all result test', () async {
        //!Act
        await clearTablesGraphsSensors();
        await clearTablesGraphs();
        await clearTablesSensors();
        await clearTablesConsigs();

        //!Arrange
        await commonDatasource.insertGraphs(dependency: graphDependency, type: graphType);
        final String? graphsId = (await commonDatasource.selectAllGraphs())?.first.id;

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertSensors(configId: configId, title: 'title_sensors_test', sensorType: SensorType.temperature, details: 'details');
        final String? sensorId2 = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertGraphSensors(sensorId: sensorId!, graphsId: graphsId!);
        await commonDatasource.insertGraphSensors(sensorId: sensorId2!, graphsId: graphsId);

        List<String> listResult = [sensorId, sensorId2];

        final List<String>? resultOrNull = (await commonDatasource.selectAllGraphSensors())?.map((e) => e.sensorId).toList();
        //!Assert
        expect(resultOrNull, listResult);
      });
    });

    group('select one graph sensors by graphs_id', () {
      test('call test with empty request', () async {
        //!Act
        await clearTablesGraphsSensors();
        await clearTablesGraphs();
        await clearTablesSensors();
        await clearTablesConsigs();
        //!Arrange
        final GraphSensorsModel? resultOrNull = await commonDatasource.selectGraphSensorsByGraphsId(graphsId: '87f0a680-815d-11ee-b962-0242ac120002');
        //!Assert
        expect(resultOrNull, null);
      });
      test('call test', () async {
        //!Act
        await clearTablesGraphsSensors();
        await clearTablesGraphs();
        await clearTablesSensors();
        await clearTablesConsigs();

        await commonDatasource.insertGraphs(dependency: graphDependency, type: graphType);
        final String? graphsId = (await commonDatasource.selectAllGraphs())?.first.id;

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertGraphSensors(sensorId: sensorId!, graphsId: graphsId!);

        //!Arrange
        final String? id = (await commonDatasource.selectAllGraphSensors())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectGraphSensorsByGraphsId(graphsId: graphsId))?.id;

        //!Assert
        expect(resultOrNull, id);
      });
    });

    group('select one graph sensor by sensor_id', () {
      test('call test with empty request', () async {
        //!Act
        await clearTablesGraphsSensors();
        await clearTablesGraphs();
        await clearTablesSensors();
        await clearTablesConsigs();
        //!Arrange
        final GraphSensorsModel? resultOrNull = await commonDatasource.selectGraphSensorsBySensorId(sensorId: '87f0a680-815d-11ee-b962-0242ac120002');
        //!Assert
        expect(resultOrNull, null);
      });
      test('call test', () async {
        //!Act
        await clearTablesGraphsSensors();
        await clearTablesGraphs();
        await clearTablesSensors();
        await clearTablesConsigs();

        await commonDatasource.insertGraphs(dependency: graphDependency, type: graphType);
        final String? graphsId = (await commonDatasource.selectAllGraphs())?.first.id;

        await commonDatasource.insertConfigs(title: 'title_configs');
        final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

        await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
        final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

        await commonDatasource.insertGraphSensors(sensorId: sensorId!, graphsId: graphsId!);

        //!Arrange
        final String? id = (await commonDatasource.selectAllGraphSensors())?.first.id;
        final String? resultOrNull = (await commonDatasource.selectGraphSensorsBySensorId(sensorId: sensorId))?.id;

        //!Assert
        expect(resultOrNull, id);
      });
    });

    test('update graph sensor correct call test', () async {
      //!Act
      await clearTablesGraphsSensors();
      await clearTablesGraphs();
      await clearTablesSensors();
      await clearTablesConsigs();

      await commonDatasource.insertGraphs(dependency: graphDependency, type: graphType);
      final String? graphsId = (await commonDatasource.selectAllGraphs())?.first.id;

      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertConfigs(title: 'title');
      final String? configId2 = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId2!, title: 'title', sensorType: SensorType.temperature, details: 'details_test');
      final String? sensorId2 = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertGraphSensors(sensorId: sensorId!, graphsId: graphsId!);

      //!Arrange
      final String? id = (await commonDatasource.selectAllGraphSensors())?.first.id;

      final Unit resultOrNull = await commonDatasource.updateGraphSensors(id: id!, sensorId: sensorId2);

      final String? resultDepTypeOrNull = (await commonDatasource.selectAllGraphSensors())?.first.sensorId;
      //!Assert
      expect(resultOrNull, unit);
      expect(resultDepTypeOrNull, sensorId);
    });

    test('delete_graph_sensor correct call test', () async {
      //!Act
      await clearTablesGraphsSensors();
      await clearTablesGraphs();
      await clearTablesSensors();
      await clearTablesConsigs();

      await commonDatasource.insertGraphs(dependency: graphDependency, type: graphType);
      final String? graphsId = (await commonDatasource.selectAllGraphs())?.first.id;

      await commonDatasource.insertConfigs(title: 'title_configs');
      final String? configId = (await commonDatasource.selectAllConfigs())?.first.id;

      await commonDatasource.insertSensors(configId: configId!, title: 'title_sensors', sensorType: SensorType.humidity, details: 'details');
      final String? sensorId = (await commonDatasource.selectAllSensors())?.first.id;

      await commonDatasource.insertGraphSensors(sensorId: sensorId!, graphsId: graphsId!);
      //!Arrange
      final String? id = (await commonDatasource.selectAllGraphSensors())?.first.id;
      final Unit resultOrNull = await commonDatasource.deleteGraphSensors(id: id!);
      //!Assert
      expect(resultOrNull, unit);
    });
  });
}
