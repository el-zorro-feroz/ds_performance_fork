import 'package:fluent_ui/fluent_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/src/presentation/widgets/sensor_page/sensor_card.dart';

@Singleton()
class ActiveTab extends StatelessWidget {
  static final GlobalKey _activeTabKey = GlobalKey(debugLabel: 'Active Tab Global Key');

  ActiveTab() : super(key: _activeTabKey);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 8 / 6,
      ),
      itemCount: 20,
      itemBuilder: (_, __) => const SensorCard(),
    );

    //? Controller Builder Example

    // final ActiveTabController activeTabController = services<ActiveTabController>();

    // return ChangeNotifierProvider.value(
    //   value: activeTabController,
    //   builder: (context, child) {
    //     if (!activeTabController.isReady) {
    //       return const Center(
    //         child: ProgressRing(),
    //       );
    //     }

    //     return GridView.builder(
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 3,
    //         childAspectRatio: 8 / 6,
    //       ),
    //       itemCount: 20,
    //       itemBuilder: (_, __) => const SensorCard(),
    //     );
    //   },
    // );
  }
}
