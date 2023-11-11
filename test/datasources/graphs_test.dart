// ignore_for_file: prefer_function_declarations_over_variables
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart';
import 'package:sensors_monitoring/src/data/models/enum/graph_dependency.dart';
import 'package:sensors_monitoring/src/data/models/enum/graph_type.dart';
import 'package:sensors_monitoring/src/data/models/graphs_model.dart';

Future<void> main() async {
  await servicesInit();

  Future<PostgreSQLResult> clearTables() async => await PostgresModule.postgreSQLConnection.query('DELETE FROM graphs;');

  GraphDependency dependency = GraphDependency.average;
  GraphType type = GraphType.columnar;
  final CommonDatasource commonDatasource = services<CommonDatasource>();
  group('graphs', () async {
    test('insert_graphs call test', () async {
      //!Act
      final Future<Unit?> Function() insertGraphs = () async {
        await clearTables();
        try {
          return await commonDatasource.insertGraphs(dependency: dependency, type: type);
        } catch (e) {
          return null;
        }
      };

      //!Arrange
      final Unit? resultOrNull = await insertGraphs();
      //!Assert
      expect(resultOrNull, unit);
    });
    group('select all graphs', () {
      test('call select_all empty result test', () async {
        //!Act
        final Future<List<GraphsModel>?> Function() selectAll = () async {
          await clearTables();
          try {
            return await commonDatasource.selectAllGraphs();
          } catch (e) {
            return null;
          }
        };
        //!Arrange
        final List<GraphsModel>? resultOrNull = await selectAll();
        //!Assert
        expect(resultOrNull, null);
      });
      test('call select_all result test', () async {
        //!Act
        final Future<List<GraphsModel>?> Function() selectAll = () async {
          await clearTables();
          try {
            return await commonDatasource.selectAllGraphs();
          } catch (e) {
            return null;
          }
        };
        //!Arrange
        final List<GraphsModel>? resultOrNull = await selectAll();
        //!Assert
        expect(resultOrNull, unit);
      });
    });

    group('select one graphs by id', () {
      test('call test with empty request', () async {
        //!Act
        final Future<GraphsModel?> Function() selectOne = () async {
          await clearTables();
          try {
            return await commonDatasource.selectOneGraphs(id: '     fud d  d d d d d d d d');
          } catch (e) {
            return null;
          }
        };
        //!Arrange
        final GraphsModel? resultOrNull = await selectOne();
        //!Assert
        expect(resultOrNull, null);
      });
      test('call test', () async {
        //!Act
        await clearTables();
        GraphsModel graphsModel = GraphsModel(id: '1', type: type, dependency: dependency);
        await commonDatasource.insertGraphs(dependency: dependency, type: type);
        //!Arrange
        final String? id = (await commonDatasource.selectAllGraphs())?.first.id;
        final GraphsModel? resultOrNull = await commonDatasource.selectOneGraphs(id: id!);
        //!Assert
        expect(resultOrNull, graphsModel);
      });
    });
    test('update graphs correct call test', () async {
      //!Act
      await clearTables();
      await commonDatasource.insertGraphs(dependency: dependency, type: type);
      GraphDependency dependencyTest = GraphDependency.sensors;
      final Future<Unit?> Function() updateGraphs = () async {
        try {
          final String? id = (await commonDatasource.selectAllGraphs())?.first.id;
          return await commonDatasource.updateGraphs(id: id!, dependency: GraphDependency.sensors);
        } catch (_) {
          return null;
        }
      };
      //!Arrange
      final Unit? resultOrNull = await updateGraphs();
      final GraphDependency? resultDepTypeOrNull = (await commonDatasource.selectAllGraphs())?.first.dependency;
      //!Assert
      expect(resultOrNull, unit);
      expect(resultDepTypeOrNull, dependencyTest);
    });

    test('delete_graphs correct call test', () async {
      //!Act
      final Future<Unit?> Function() deleteGraphs = () async {
        await clearTables();
        try {
          final String? id = (await commonDatasource.selectAllGraphs())?.first.id;
          if (id == null) {
            return null;
          }
          return await commonDatasource.deleteGraphs(id: id);
        } catch (e) {
          return null;
        }
      };
      //!Arrange
      final Unit? resultOrNull = await deleteGraphs();
      //!Assert
      expect(resultOrNull, unit);
    });
  });
}
