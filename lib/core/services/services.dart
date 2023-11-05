import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'services.config.dart';

final GetIt services = GetIt.I;

@InjectableInit()
FutureOr<void> servicesInit() {
  services.init();
}
