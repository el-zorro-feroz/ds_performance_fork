import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/presentation/dialogs/about_sensor_dialog.dart';
import 'package:sensors_monitoring/src/presentation/widgets/sensor/intable_sensor_data.dart';
import 'package:sensors_monitoring/src/presentation/widgets/sensor/intable_sensor_header.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SensorDataPage extends StatelessWidget {
  final String configID;
  final String sensorID;

  const SensorDataPage({
    super.key,
    required this.configID,
    required this.sensorID,
  });

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    void onBackToSensorsPressed() {
      //TODO: cpntroller stuff. Things about dispose data from back.
      //? Things about adding some cache things to save database freq
      GoRouter.of(context).go('/config/$configID');
    }

    void openInfoDialog() {
      showAboutSensorDialog(context);
    }

    return ScaffoldPage(
      header: PageHeader(
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: IconButton(
            icon: const Icon(FluentIcons.back),
            onPressed: onBackToSensorsPressed,
          ),
        ),
        title: Wrap(
          spacing: 4.0,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Text(
              '$configID - $sensorID',
            ),
            IconButton(
              icon: const Icon(FluentIcons.info),
              onPressed: openInfoDialog,
            ),
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                top: 24.0,
                bottom: 8.0,
              ),
              child: Text(
                'Graph View',
                style: typography.subtitle,
              ),
            ),
            AspectRatio(
              aspectRatio: 6,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        color: FluentTheme.of(context).micaBackgroundColor,
                      ),
                      child: SfSparkLineChart(
                        width: 1.0,
                        axisLineWidth: 0.0,
                        data: List.generate(80, (_) => (_ * _) << _),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ListView(
                      children: List.generate(
                        4,
                        (_) => Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Button(
                            onPressed: () {
                              print('DEBUG: pressed $_ on Active Sensor');
                            },
                            child: Text('$_'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                top: 24.0,
                bottom: 8.0,
              ),
              child: Text(
                'Detailed Values',
                style: typography.subtitle,
              ),
            ),
            const IntableSensorHeader(),
            SizedBox.fromSize(
              size: MediaQuery.of(context).size,
              child: const IntableSensorData(),
            ),
          ],
        ),
      ),
    );
  }
}
