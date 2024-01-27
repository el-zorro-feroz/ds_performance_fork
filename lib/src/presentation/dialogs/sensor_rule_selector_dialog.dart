import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/presentation/widgets/dialog_elements/notification_rule_table.dart';

Future<void> showSensorRuleSelectorDialog(
  BuildContext context, {
  Function()? onCompleteRuleSelect,
}) async {
  final Size size = MediaQuery.of(context).size;
  final Typography typography = FluentTheme.of(context).typography;

  showDialog(
    context: context,
    builder: (_) => ContentDialog(
      actions: [
        Button(
          onPressed: () => GoRouter.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: onCompleteRuleSelect,
          child: const Text('Accept'),
        ),
      ],
      content: SizedBox(
        width: 600,
        height: size.height,
        child: ScaffoldPage.scrollable(
          header: const PageHeader(
            // commandBar: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     IconButton(
            //       icon: const Icon(
            //         FluentIcons.remove_content,
            //       ),
            //       onPressed: () => null,
            //     ),
            //     const SizedBox(width: 2.0),
            //     IconButton(
            //       icon: const Icon(
            //         FluentIcons.accept,
            //       ),
            //       onPressed: () => null,
            //     ),
            //   ],
            // ),
            title: SizedBox(
              width: double.infinity,
              child: TextBox(
                placeholder: 'Notification title',
              ),
            ),
          ),
          children: [
            const TextBox(
              placeholder: 'Notification text',
            ),
            const TextBox(
              placeholder: 'Notification description',
            ),
            DropDownButton(
              buttonBuilder: (_, __) {
                return Button(
                  onPressed: __,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: const Wrap(
                      spacing: 8.0,
                      children: [
                        Icon(
                          FluentIcons.chevron_down_med,
                        ),
                        Text(
                          'Notification type',
                        ),
                      ],
                    ),
                  ),
                );
              },
              items: <MenuFlyoutItemBase>[
                MenuFlyoutItem(text: const Text('Info'), onPressed: () => null),
                MenuFlyoutItem(text: const Text('Error'), onPressed: () => null),
                MenuFlyoutItem(text: const Text('Alert'), onPressed: () => null),
                MenuFlyoutItem(text: const Text('Warning'), onPressed: () => null),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                bottom: 16.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Rules',
                      style: typography.subtitle,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.add),
                    onPressed: () => null,
                  ),
                ],
              ),
            ),
            AutoSuggestBox(
              placeholder: 'Add Exists Rule',
              items: List.generate(
                5,
                (_) => AutoSuggestBoxItem(
                  value: _,
                  label: 'lable $_',
                ),
              ),
            ),
            ...List.generate(
              3,
              (_) => const NotificationRuleTable(),
            ),
            // Button(
            //   onPressed: () => null,
            //   child: Container(
            //     width: double.infinity,
            //     padding: const EdgeInsets.all(4.0),
            //     child: const Text(
            //       'Add notification rule',
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16.0),
            // Wrap(
            //   alignment: WrapAlignment.end,
            //   spacing: 8.0,
            //   children: [
            //     Expanded(
            //       child: Button(
            //         child: const Text('Cancel'),
            //         onPressed: () => null,
            //       ),
            //     ),
            //     Expanded(
            //       child: FilledButton(
            //         child: const Text('Add'),
            //         onPressed: () => null,
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    ),
  );
}
