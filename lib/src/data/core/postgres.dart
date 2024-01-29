import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

/// Simple connector to postgres database which handle this connection
@Singleton()
class PostgresServer with ChangeNotifier {
  /// Postgres connection endpoint
  Connection? connection;

  /// Connection state getter
  bool get isConnected => connection != null;

  /// Represent bool state of error for last tring to make connection
  bool hasError = false;

  /// Connection error type message if exist
  String? error;

  /// Trying to connect to postgres database and handle it
  Future<void> openConnection() async {
    try {
      connection = await Connection.open(
        // TODO(env): Retrieve [Endpoint] values from device (docker) environment.
        Endpoint(
          host: 'localhost',
          database: 'database',
          username: 'postgres',
          password: 'password',
        ),
      );

      hasError = false;
      error = null;
    } catch (_) {
      hasError = true;
      error = '${_.runtimeType}';
    } finally {
      notifyListeners();
    }
  }

  /// Trying to close active postgres connection if possible
  Future<void> closeConnection() async {
    try {
      if (connection?.isOpen ?? false) {
        await connection?.close();
      }
    } finally {
      notifyListeners();
    }
  }
}
