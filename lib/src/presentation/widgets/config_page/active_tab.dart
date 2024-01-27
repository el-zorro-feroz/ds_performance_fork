import 'package:fluent_ui/fluent_ui.dart';
import 'package:sensors_monitoring/src/presentation/widgets/sensor_page/sensor_card.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart' as config_tab show Tab;

class ActiveTab extends StatelessWidget {
  final config_tab.Tab data;

  const ActiveTab({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 8 / 6,
      ),
      itemCount: data.sensorInfoList.length,
      itemBuilder: (_, index) => SensorCard(
        configId: 'ASDASDASD', //TODO: PARAMS MISSTAKE
        sensorData: data.sensorInfoList.elementAt(index),
      ),
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
