import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorCard extends StatelessWidget {
  final String configId;
  final SensorInfo sensorData;

  const SensorCard({
    super.key,
    required this.configId,
    required this.sensorData,
  });

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/config/$configId/${sensorData.id}');
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sensorData.title,
              style: typography.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              sensorData.details,
              style: typography.body,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: FluentTheme.of(context).micaBackgroundColor,
                ),
                //TODO: paint graph with [data] values
                child: const SfCartesianChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
