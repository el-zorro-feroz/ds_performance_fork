import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    //?? Things about add some cache logic into controller
    void openFullLog() {
      final _id = 'id'; //TODO NEEDS TO BE CONTROLLED BY OVER CONTROLLER
      final _sensor = 'sensor'; //TODO NEEDS TO BE CONTROLLED BY OVER CONTROLLER

      GoRouter.of(context).go('/config/$_id/$_sensor');
    }

    return GestureDetector(
      onTap: openFullLog,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sensor Title',
              style: typography.subtitle,
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: FluentTheme.of(context).micaBackgroundColor,
                ),
                child: SfSparkLineChart(
                  width: 1.0,
                  axisLineWidth: 0.0,
                  data: List.generate(80, (_) => (_ * _) << _),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
