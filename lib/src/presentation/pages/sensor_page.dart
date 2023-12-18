import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/presentation/dialogs/about_sensor_dialog.dart';

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
        title: Text(
          '$configID - $sensorID',
        ),
        commandBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: IconButton(
            icon: const Icon(FluentIcons.info),
            onPressed: openInfoDialog,
          ),
        ),
      ),
      content: Row(
        children: [
          const Expanded(
            flex: 2,
            child: Card(
              child: SizedBox.shrink(
                child: Placeholder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
