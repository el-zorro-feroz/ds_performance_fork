import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    void openFullLog() {
      const id = 'id'; //TODO NEEDS TO BE CONTROLLED BY OVER CONTROLLER
      const sensor = 'sensor'; //TODO NEEDS TO BE CONTROLLED BY OVER CONTROLLER

      GoRouter.of(context).go('/config/$id/$sensor');
    }

    return GestureDetector(
      onTap: openFullLog,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sensor Title',
              style: typography.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Sensor Short Description',
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
                child: const SfCartesianChart(), //! CHART HERE
              ),
            ),
          ],
        ),
      ),
    );
  }
}
