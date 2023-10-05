import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'services.config.dart';

final GetIt services = GetIt.I;

@InjectableInit()
void servicesInit() => services.init();
