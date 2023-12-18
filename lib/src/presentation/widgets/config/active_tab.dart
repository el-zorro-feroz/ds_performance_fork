import 'package:fluent_ui/fluent_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/presentation/controllers/active_tab_controller.dart';
import 'package:sensors_monitoring/src/presentation/widgets/tab/sensor_card.dart';

@Singleton()
class ActiveTab extends StatelessWidget {
  static final GlobalKey _activeTabKey =
      GlobalKey(debugLabel: 'Active Tab Global Key');

  ActiveTab() : super(key: _activeTabKey);

  @override
  Widget build(BuildContext context) {
    final ActiveTabController activeTabController =
        services<ActiveTabController>();

    return ChangeNotifierProvider.value(
      value: activeTabController,
      builder: (context, child) {
        if (!activeTabController.isReady) {
          return const Center(
            child: ProgressRing(),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
          ),
          itemCount: 20,
          itemBuilder: (_, __) => const SensorCard(),
        );

        // return ListView.custom(
        //   childrenDelegate: SliverChildListDelegate.fixed(
        //     List.generate(
        //       20,
        //       (index) => const SensorCard(),
        //     ),
        //   ),
        // );

        // return Wrap(
        //   children: List.generate(
        //     20,
        //     (index) => const SensorCard(),
        //   ),
        // );
      },
    );
  }
}
