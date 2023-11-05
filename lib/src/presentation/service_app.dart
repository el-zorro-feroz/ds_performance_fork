import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/presentation/pages/home_page.dart';
import 'package:sensors_monitoring/src/presentation/root_page.dart';

class ServiceApp extends StatelessWidget {
  static const String serviceName = 'Monitoring Service';

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

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
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const HomePage(),
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
