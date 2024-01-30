import 'package:fluent_ui/fluent_ui.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/presentation/controllers/config_controller.dart';
import 'package:sensors_monitoring/src/presentation/controllers/notification_controller.dart';
import 'package:sensors_monitoring/src/presentation/service_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await servicesInit();
  services<NotificationController>().fetchNotifications();
  services<ConfigController>().fetchAllConfigs();

  runApp(const ServiceApp());
}
