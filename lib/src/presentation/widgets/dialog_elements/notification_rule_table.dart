import 'package:fluent_ui/fluent_ui.dart';

class NotificationRuleTable extends StatelessWidget {
  const NotificationRuleTable({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Rule Description',
                    style: typography.body,
                  ),
                ),
                IconButton(
                  icon: const Icon(FluentIcons.delete),
                  onPressed: () => null,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'State',
                      style: typography.body,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Value',
                      style: typography.body,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    'AvG',
                    style: typography.caption,
                  ),
                  TextBox(
                    placeholder: '0.0',
                    placeholderStyle: typography.caption,
                    style: typography.caption,
                  )
                ]),
                TableRow(children: [
                  Text(
                    'Max Limit',
                    style: typography.caption,
                  ),
                  TextBox(
                    placeholder: '0.0',
                    placeholderStyle: typography.caption,
                    style: typography.caption,
                  )
                ]),
                TableRow(children: [
                  Text(
                    'Min Limit',
                    style: typography.caption,
                  ),
                  TextBox(
                    placeholder: '0.0',
                    placeholderStyle: typography.caption,
                    style: typography.caption,
                  ),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
