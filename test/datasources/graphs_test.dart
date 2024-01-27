import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/core/enum/graph_dependency.dart';
import 'package:sensors_monitoring/core/enum/graph_type.dart';
import 'package:sensors_monitoring/src/data/models/graphs_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM graphs;');

  GraphDependency testDependency1 = GraphDependency.minimal;
  GraphDependency testDependency2 = GraphDependency.maximum;
  GraphType testType1 = GraphType.columnar;
  GraphType testType2 = GraphType.curve;

  final CommonDatasource commonDatasource = services<CommonDatasource>();
  group('graphs', () {
    test('insert_graphs call test', () async {
      //!Act
      await clearTables();
      //!Arrange
      final Unit resultOrNull = await commonDatasource.insertGraphs(
        dependency: testDependency1,
        type: testType1,
      );
      //!Assert
      expect(resultOrNull, unit);
    });
    group('select all graphs', () {
      test('call select_all empty result test', () async {
        //!Act
        await clearTables();
        //!Arrange
        final List<GraphsModel>? resultOrNull = await commonDatasource.selectAllGraphs();
        //!Assert
        expect(resultOrNull, null);
      });
      test('call select_all result test', () async {
        //!Act
        await clearTables();

        //!Arrange
        await commonDatasource.insertGraphs(dependency: testDependency1, type: testType1);
        await commonDatasource.insertGraphs(dependency: testDependency1, type: testType2);

        List<GraphType>? correctResult = [testType1, testType2];

        final List<GraphType>? resultOrNull = (await commonDatasource.selectAllGraphs())?.map((e) => e.type).toList();
        //!Assert
        expect(resultOrNull, correctResult);
      });
    });

    group('select one graphs by id', () {
      test('call test with empty request', () async {
        //!Act
        await clearTables();
        //!Arrange
        final GraphsModel? resultOrNull = await commonDatasource.selectOneGraphs(id: '87f0a680-815d-11ee-b962-0242ac120002');
        //!Assert
        expect(resultOrNull, null);
      });
      test('call test', () async {
        //!Act
        await clearTables();
        await commonDatasource.insertGraphs(dependency: testDependency1, type: testType1);
        //!Arrange
        final String? id = (await commonDatasource.selectAllGraphs())?.first.id;
        final GraphType? resultOrNull = (await commonDatasource.selectOneGraphs(id: id!))?.type;
        //!Assert
        expect(resultOrNull, testType1);
      });
    });
    test('update graphs correct call test', () async {
      //!Act
      await clearTables();
      await commonDatasource.insertGraphs(dependency: testDependency1, type: testType1);
      final String? id = (await commonDatasource.selectAllGraphs())?.first.id;
      final Unit resultOrNull = await commonDatasource.updateGraphs(id: id!, dependency: testDependency2);
      //!Arrange
      final GraphDependency? resultDepTypeOrNull = (await commonDatasource.selectAllGraphs())?.first.dependency;
      //!Assert
      expect(resultOrNull, unit);
      expect(resultDepTypeOrNull, testDependency2);
    });

    test('delete_graphs correct call test', () async {
      //!Act
      await clearTables();
      await commonDatasource.insertGraphs(dependency: testDependency1, type: testType1);
      //!Arrange
      final String? id = (await commonDatasource.selectAllGraphs())?.first.id;
      final Unit resultOrNull = await commonDatasource.deleteGraphs(id: id!);
      //!Assert
      expect(resultOrNull, unit);
    });
  });
}
