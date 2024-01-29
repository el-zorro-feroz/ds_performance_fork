import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:sensors_monitoring/core/services/services.config.dart';

/// Global Service locator implementation
final GetIt services = GetIt.I;

/// Global [services] initialization method
@InjectableInit()
Future<void> servicesInit() async {
  services.init();
}
