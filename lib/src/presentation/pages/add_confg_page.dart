import 'package:dartz/dartz.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:sensors_monitoring/src/presentation/dialogs/sensor_rule_selector_dialog.dart';

class AddConfigPage extends StatelessWidget {
  const AddConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    void addAlertRule() {
      showSensorRuleSelectorDialog(context);
    }

    void onRemoveConfigurationPressed() {}
    void onCreateConfigurationPressed() {}

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(
          'New Configuration',
          style: typography.title,
        ),
        commandBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                FluentIcons.remove_content,
              ),
              onPressed: onRemoveConfigurationPressed,
            ),
            const SizedBox(width: 2.0),
            IconButton(
              icon: const Icon(
                FluentIcons.accept,
              ),
              onPressed: onCreateConfigurationPressed,
            ),
          ],
        ),
      ),
      bottomBar: Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(8.0),
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: ButtonState.all(
              const Color(0xFFFF6655),
            ),
          ),
          child: const Text('DELETE CONFIGURATION КРОВЬ'),
          onPressed: () => null,
        ),
      ),
      children: [
        const TextBox(
          placeholder: 'Configuration title',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(),
        ),
        Column(
          children: List.generate(
            5,
            (_) {
              return Expander(
                trailing: Row(
                  children: [
                    IconButton(
                      icon: const Icon(FluentIcons.edit),
                      onPressed: () => null,
                    ),
                    IconButton(
                      icon: const Icon(FluentIcons.delete),
                      onPressed: () => null,
                    ),
                  ],
                ),
                header: Text('Sensor $_'),
                content: Wrap(
                  runSpacing: 8.0,
                  children: [
                    const TextBox(
                      placeholder: 'Description',
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
                                  'Select sensor type',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      items: <MenuFlyoutItemBase>[
                        MenuFlyoutItem(text: const Text('Type 1'), onPressed: () => null),
                        MenuFlyoutItem(text: const Text('Type 2'), onPressed: () => null),
                        MenuFlyoutItem(text: const Text('Type 3'), onPressed: () => null),
                        MenuFlyoutItem(text: const Text('Type 4'), onPressed: () => null),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          3,
                          (_) => ListTile(
                            leading: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                                color: Color(0xFFFF6655),
                              ),
                              child: Text(
                                'Warning',
                                style: typography.caption,
                              ),
                            ),
                            title: Text(
                              'Temperature notification',
                              style: typography.caption,
                            ),
                            subtitle: Text(
                              '3 rules active',
                              style: typography.caption,
                            ),
                            trailing: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(FluentIcons.edit),
                                  onPressed: () => null,
                                ),
                                IconButton(
                                  icon: const Icon(FluentIcons.delete),
                                  onPressed: () => null,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Button(
                          onPressed: addAlertRule,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(4.0),
                            child: const Text(
                              'Add notification',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: CommandBar(
            primaryItems: <CommandBarItem>[
              CommandBarBuilderItem(
                builder: (context, mode, w) => Tooltip(
                  message: "Add new Sensor to Configuration",
                  child: w,
                ),
                wrappedItem: CommandBarButton(
                  icon: const Icon(FluentIcons.add),
                  label: const Text('Add Sensor'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
