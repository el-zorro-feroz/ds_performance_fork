import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/core/types/fail_or.dart';
import 'package:sensors_monitoring/src/data/core/postgres.dart';
import 'package:sensors_monitoring/src/data/enums/sensor_type_enum.dart';

/// Represent config sensor
class SensorEntry extends Equatable {
  /// Creates an instance of [SensorEntry]
  ///
  /// [id] - Unique entry ID.
  /// [config] - [ConfigEntry] ID.
  /// [type] - Type of sensor. Should not be changed as well as possible. 
  /// [title] - Sensor title. Shows up on all possible sensor positions e.g. cards, notifications.
  /// [details] - Sensor description. Shows up on this sensor page.
  SensorEntry({
    required String id,
    required String config,
    required SensorType type,
    required String title,
    required String details,
  }) {
    _id = id;
    _config = config;
    _type = type;
    _title = title;
    _details = details;
  }

  late String _id;
  late String _config;
  late SensorType _type;
  late String _title;
  late String _details;

  @override
  List<Object?> get props => [_id, _config, _type, _title, _details];

  /// Execute [SensorEntry] reading from server
  FFailOr<SensorEntry> _read(String id) async {
    final server = services<PostgresServer>();

    return server.execute<SensorEntry>(
      (connection) async {
        return connection.runTx((session) async {
          try {
            final result = await session.execute(
              r'SELECT * FROM Sensors WHERE id = $1',
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
}
