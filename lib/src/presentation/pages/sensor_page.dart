import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sensors_monitoring/src/presentation/dialogs/about_sensor_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
      GoRouter.of(context).go('/config/$configID');
    }

    void openInfoDialog() {
      showAboutSensorDialog(context);
    }

    return ScaffoldPage.scrollable(
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
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Wrap(
            spacing: 8.0,
            children: [
              Button(
                child: Text(
                  'AVG',
                  style: typography.caption,
                ),
                onPressed: () => null,
              ),
              Button(
                child: Text(
                  'MIN',
                  style: typography.caption,
                ),
                onPressed: () => null,
              ),
              Button(
                child: Text(
                  'MAX',
                  style: typography.caption,
                ),
                onPressed: () => null,
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 4,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: FluentTheme.of(context).micaBackgroundColor,
                  ),
                  child: const SfCartesianChart(),
                  // child: SfCartesianChart(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: CommandBar(
            overflowBehavior: CommandBarOverflowBehavior.wrap,
            compactBreakpointWidth: 600,
            primaryItems: <CommandBarItem>[
              CommandBarButton(label: const Text('1H'), onPressed: () {}),
              CommandBarButton(label: const Text('4H'), onPressed: () {}),
              CommandBarButton(label: const Text('1D'), onPressed: () {}),
              CommandBarButton(label: const Text('1W'), onPressed: () {}),
              CommandBarButton(label: const Text('1M'), onPressed: () {}),
              CommandBarButton(label: const Text('3M'), onPressed: () {}),
              CommandBarButton(label: const Text('ALL'), onPressed: () {}),
              const CommandBarSeparator(),
              CommandBarButton(icon: const Icon(FluentIcons.calendar), onPressed: () {}),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FractionColumnWidth(0.05),
              1: FractionColumnWidth(0.95 / 2),
              2: FractionColumnWidth(0.95 / 2),
            },
            children: <TableRow>[
              TableRow(
                children: ['#', 'Date', 'Value']
                    .map(
                      (_) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          _,
                          style: typography.bodyStrong,
                        ),
                      ),
                    )
                    .toList(),
              ),
              ...List.generate(
                20,
                (_) => TableRow(
                  children: [
                    '${_ + 1}',
                    DateFormat.MMMMEEEEd().format(DateTime.now()),
                    '$_ oC (+${_ << _}.${_ >> _})',
                  ]
                      .map(
                        (_) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            _,
                            style: typography.body,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
