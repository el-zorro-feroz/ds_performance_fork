import 'package:flutter/cupertino.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/presentation/service_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await servicesInit();

  runApp(const ServiceApp());
}
