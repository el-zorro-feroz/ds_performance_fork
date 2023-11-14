import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/presentation/pages/add_confg_page.dart';
import 'package:sensors_monitoring/src/presentation/pages/config_page.dart';
import 'package:sensors_monitoring/src/presentation/pages/home_page.dart';
import 'package:sensors_monitoring/src/presentation/pages/settings_page.dart';
import 'package:sensors_monitoring/src/presentation/root_page.dart';

class ServiceApp extends StatelessWidget {
  static const String serviceName = 'Monitoring Service';

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return RootPage(
            shellContext: context,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/config/:id',
            builder: (context, state) {
              final String? id = state.pathParameters['id'];
              if (id == null) throw Exception('Config id must not be null');
              return ConfigPage(id: id);
            },
          ),
          GoRoute(
            path: '/add',
            builder: (context, state) => const AddConfigPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );

  const ServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      title: serviceName,
      themeMode: ThemeMode.light,
      color: Colors.blue.toAccentColor(),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
