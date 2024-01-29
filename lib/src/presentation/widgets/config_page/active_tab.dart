import 'package:fluent_ui/fluent_ui.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/presentation/controllers/tab_controller.dart';
import 'package:sensors_monitoring/src/presentation/widgets/sensor_page/sensor_card.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart' as config_tab show Tab;

class ActiveTab extends StatelessWidget {
  final String configID;
  final config_tab.Tab data;

  const ActiveTab({
    super.key,
    required this.configID,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.sensorInfoList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'No added configurations yet',
          style: FluentTheme.of(context).typography.bodyStrong,
        ),
      );
    }

    return ListenableBuilder(
        listenable: services<TabController>(),
        builder: (context, _) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 8 / 6,
            ),
            itemCount: data.sensorInfoList.length,
            itemBuilder: (_, index) => SensorCard(
              configId: configID,
              sensorData: data.sensorInfoList.elementAt(index),
            ),
          );
        });

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
