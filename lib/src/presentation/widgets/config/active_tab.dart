import 'package:fluent_ui/fluent_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/presentation/controllers/active_tab_controller.dart';

@Singleton()
class ActiveTab extends StatelessWidget {
  static final GlobalKey _activeTabKey = GlobalKey(debugLabel: 'Active Tab Global Key');

  ActiveTab() : super(key: _activeTabKey);

  @override
  Widget build(BuildContext context) {
    final ActiveTabController activeTabController = services<ActiveTabController>();

    return ChangeNotifierProvider.value(
      value: activeTabController,
      builder: (context, child) {
        if (!activeTabController.isReady) {
          return const Center(
            child: ProgressRing(),
          );
        }

        return const Center(
          child: Text('data'),
        );
      },
    );
  }
}
