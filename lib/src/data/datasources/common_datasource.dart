import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/enum/rule_type.dart';

import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/data/models/alerts_model.dart';
import 'package:sensors_monitoring/src/data/models/configs_model.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/enum/graph_dependency.dart';
import 'package:sensors_monitoring/core/enum/graph_type.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/src/data/models/graph_sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/graphs_model.dart';
import 'package:sensors_monitoring/src/data/models/rule_groups_model.dart';
import 'package:sensors_monitoring/src/data/models/sensor_history_model.dart';
import 'package:sensors_monitoring/src/data/models/sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/sensors_rules_model.dart';
import 'package:sensors_monitoring/src/data/models/tab_sensors_model.dart';
import 'package:sensors_monitoring/src/data/models/tabs_model.dart';

part './configs_datasource.dart';
part './sensor_history_datasource.dart';
part './sensors_datasource.dart';
part './tab_sensors_datasource.dart';
part './tabs_datasource.dart';
part './graphs_datasource.dart';
part './graph_sensors_datasource.dart';
part './sensor_rules_datasource.dart';
part './alerts_datasource.dart';
part './rule_groups_datasource.dart';

@Injectable()
class CommonDatasource {
  final PostgresModule postgresModule;

  CommonDatasource({required this.postgresModule});
}
