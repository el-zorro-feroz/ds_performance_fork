import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/core/types/fail_or.dart';
import 'package:sensors_monitoring/src/data/core/postgres.dart';
import 'package:uuid/uuid.dart';

/// Represent config database table entry
class ConfigEntry extends Equatable {
  /// Creates an instance of [ConfigEntry].
  ///
  /// [id] - Unique entry ID.
  /// [title] - Config title. Displayed in the left nav panel
  ///   and as page header title of this config.
  ConfigEntry({
    required String id,
    required String title,
  }) {
    _id = id;
    _title = title;
  }

  /// Creates an instance of [ConfigEntry] with new
  /// unique [id] and default [title]
  factory ConfigEntry.empty() {
    return ConfigEntry(
      id: const Uuid().v4(),
      title: 'New Configuration',
    );
  }

  late String _id;

  /// Returns [_id]
  String get id => _id;

  late String _title;

  /// Returns [_title]
  String get title => _title;

  // TODO(events): Add public config "CRUD" events.
  // TODO(events): Possible needs to be static and pass [this] throw argv,
  // TODO(events): but also we need to have rights to change e.g title directly
  // TODO(events): from real instance

  @override
  List<Object?> get props => [_id, _title];

  /// Execute [ConfigEntry] creating on server
  FFailOr<ConfigEntry> _create() async {
    final server = services<PostgresServer>();

    return server.execute<ConfigEntry>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'INSERT INTO Configs VALUES ($1, $2)',
              parameters: [_id, _title],
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

  /// Execute [ConfigEntry] reading from server
  FFailOr<ConfigEntry> _read(String id) async {
    final server = services<PostgresServer>();

    return server.execute<ConfigEntry>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'SELECT * FROM Configs WHERE id = $1',
              parameters: [id],
            );

            if (result.affectedRows < 1) {
              return const Left(
                Failure(
                  message: 'Configuration with this ID does not exist',
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

  /// Execute [ConfigEntry] updating on server
  FFailOr<ConfigEntry> _update(ConfigEntry data) async {
    final server = services<PostgresServer>();

    return server.execute<ConfigEntry>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'UPDATE Configs SET title = $1 WHERE id = $2',
              parameters: [_id, data.title],
            );

            if (result.affectedRows < 1) {
              return const Left(
                Failure(
                  message: 'Configuration has not been updated',
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
          _title = data.title;

          return Right(this);
        });
      },
    );
  }

  /// Execute [ConfigEntry] deleting on server
  FFailOrUnit _delete() async {
    final server = services<PostgresServer>();

    return server.execute<Unit>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'DELETE FROM Configs WHERE id = $1',
              parameters: [_id],
            );

            if (result.affectedRows < 1) {
              return const Left(
                Failure(
                  message: 'Configuration has not been deleted',
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
