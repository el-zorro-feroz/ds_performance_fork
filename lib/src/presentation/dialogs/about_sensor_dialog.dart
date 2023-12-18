import 'package:fluent_ui/fluent_ui.dart';

Future<void> showAboutSensorDialog(BuildContext context) async {
  final Typography typography = FluentTheme.of(context).typography;

  showDialog(
      context: context,
      builder: (_) {
        return ContentDialog(
          title: Text(
            'About Sensor',
            style: typography.subtitle,
          ),
          content: Table(
            children: <TableRow>[
              TableRow(children: [
                Text(
                  'ID',
                  style: typography.body,
                ),
                Text(
                  '{ABCD-DEFG}',
                  style: typography.body,
                )
              ]),
              TableRow(children: [
                Text(
                  'Configuration Name',
                  style: typography.body,
                ),
                Text(
                  '{ABCD-DEFG}',
                  style: typography.body,
                )
              ]),
              TableRow(children: [
                Text(
                  'Tab Name',
                  style: typography.body,
                ),
                Text(
                  '{ABCD-DEFG}',
                  style: typography.body,
                )
              ]),
              TableRow(children: [
                Text(
                  'Title',
                  style: typography.body,
                ),
                Text(
                  '{ABCD-DEFG}',
                  style: typography.body,
                )
              ]),
              TableRow(children: [
                Text(
                  'Description',
                  style: typography.body,
                ),
                Text(
                  '{ABCD-DEFG}',
                  style: typography.body,
                )
              ]),
            ],
          ),
        );
      });
}
