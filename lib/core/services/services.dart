import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

import 'services.config.dart';

final GetIt services = GetIt.I;

@InjectableInit()
Future<void> servicesInit() async => services.init();

@Injectable()
class PostgresModule {
  static late PostgreSQLConnection postgreSQLConnection;

  FutureOr<void> initPostgres() async {
    postgreSQLConnection = PostgreSQLConnection("127.0.0.1", 5432, "postgres", username: "postgres", password: "1");
    await postgreSQLConnection.open();
  }
}
