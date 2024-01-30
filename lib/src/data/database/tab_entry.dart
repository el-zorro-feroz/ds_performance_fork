import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:postgres/postgres.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/core/types/fail_or.dart';
import 'package:sensors_monitoring/src/data/core/postgres.dart';

/// Represent database tab table
class TabEntry extends Equatable {
  /// Creates an istance of [TabEntry]
  ///
  /// [id] - Unique entry ID.
  /// [config] - Unique config ID. Referenced to Config entry
  /// [title] - Tab title. Displayed inside tab button on config page
  TabEntry({
    required String id,
    required String config,
    required String title,
  }) {
    _id = id;
    _config = config;
    _title = title;
  }

  /// Creates an instance of [TabEntry] from postgress [ResultRow]
  factory TabEntry.fromResultRow(ResultRow data) {
    try {
      final id = data.elementAt(0)! as String;
      final config = data.elementAt(1)! as String;
      final title = data.elementAt(2)! as String;

      return TabEntry(id: id, config: config, title: title);
    } catch (_) {
      throw Exception(
        'Passed incorrect [ResultRow] in [TabEntry.fromResultRow] factory',
      );
    }
  }

  late String _id;
  late String _config;
  late String _title;

  @override
  List<Object?> get props => [_id, _config, _title];

  /// Execute [TabEntry] creating from server
  FFailOr<TabEntry> _create() async {
    final server = services<PostgresServer>();

    return server.execute<TabEntry>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'INSERT INTO Tabs VALUES ($1, $2, $3)',
              parameters: props,
            );

            if (result.affectedRows < 1) {
              return const Left(
                Failure(
                  message: 'Configuration has not been created',
                ),
              );
            }
          } catch (_) {
            return const Left(
              Failure(
                message: 'Request was executed incorrectly',
              ),
            );
          }

          return Right(this);
        });
      },
    );
  }

  /// Execute [TabEntry] reading from server
  ///
  /// [id] - Unique Tab ID
  FFailOr<TabEntry> _read(String id) async {
    final server = services<PostgresServer>();

    return server.execute<TabEntry>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'SELECT * FROM Tabs WHERE config = $1',
              parameters: [id],
            );

            if (result.affectedRows < 1) {
              return const Left(
                Failure(
                  message: 'Tab with this ID does not exist',
                ),
              );
            }
          } catch (_) {
            return const Left(
              Failure(
                message: 'Request was executed incorrectly',
              ),
            );
          }

          return Right(this);
        });
      },
    );
  }

  /// Execute [TabEntry] reading from server
  ///
  /// [id] - Unique Config ID
  FFailOr<List<TabEntry>> _readAllForConfig(String id) async {
    final server = services<PostgresServer>();

    return server.execute<List<TabEntry>>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'SELECT * FROM Tabs WHERE config = $1',
              parameters: [id],
            );

            if (result.affectedRows < 1) {
              return const Left(
                Failure(
                  message: 'Tab with this ID does not exist',
                ),
              );
            }

            return Right(
              result.map((e) {
                return TabEntry.fromResultRow(e);
              }).toList(),
            );
          } catch (_) {
            return const Left(
              Failure(
                message: 'Request was executed incorrectly',
              ),
            );
          }
        });
      },
    );
  }

  /// Execute [TabEntry] updating on server
  FFailOr<TabEntry> _update(TabEntry data) async {
    final server = services<PostgresServer>();

    return server.execute<TabEntry>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'UPDATE Tabs SET config = $1, title = $2 WHERE id = $3',
              parameters: [data._config, data._title, _id],
            );

            if (result.affectedRows < 1) {
              return const Left(
                Failure(
                  message: 'Tab has not been updated',
                ),
              );
            }
          } catch (_) {
            return const Left(
              Failure(
                message: 'Request was executed incorrectly',
              ),
            );
          }

          _id = data._id;
          _config = data._config;
          _title = data._title;

          return Right(this);
        });
      },
    );
  }

  /// Execute [TabEntry] deleting on server
  FFailOrUnit _delete() async {
    final server = services<PostgresServer>();

    return server.execute<Unit>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'DELETE FROM Tabs WHERE id = $1',
              parameters: [_id],
            );

            if (result.affectedRows < 1) {
              return const Left(
                Failure(
                  message: 'Tab has not been deleted',
                ),
              );
            }
          } catch (_) {
            return const Left(
              Failure(
                message: 'Request was executed incorrectly',
              ),
            );
          }

          return const Right(unit);
        });
      },
    );
  }
}
