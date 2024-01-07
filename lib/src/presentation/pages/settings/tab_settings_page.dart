import 'package:fluent_ui/fluent_ui.dart';

class TabSettingsPage extends StatelessWidget {
  final String id;

  const TabSettingsPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    void onRemoveTabPressed() {}
    void onCreateTabPressed() {}

    final lazyItems = [
      TreeViewItem(
        content: const Text('Tab Enabled Sensors'),
        value: 'tab_enabled_sensors',
        children: [
          TreeViewItem(
            content: const Text('Tab Sensor 1'),
            value: 'tab_sensor_1',
          ),
          TreeViewItem(
            content: const Text('Tab Sensor 2'),
            value: 'tab_sensor_2',
          ),
          TreeViewItem(
            content: const Text('Tab Sensor 3'),
            value: 'tab_sensor_3',
          ),
        ],
      ),
      TreeViewItem(
        content: const Text('Cross-Tab Enabled Sensors'),
        value: 'cross_enabled_sensors',
        children: [
          TreeViewItem(
            content: const Text('Cross Sensor 1'),
            value: 'cross_sensor_1',
          ),
          TreeViewItem(
            content: const Text('Cross Sensor 2'),
            value: 'cross_sensor_2',
          ),
          TreeViewItem(
            content: const Text('Cross Sensor 3'),
            value: 'cross_sensor_3',
          ),
          TreeViewItem(
            content: const Text('Cross Sensor 4'),
            value: 'cross_sensor_4',
          ),
        ],
      ),
    ];

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(
          'New Configuration Tab',
          style: typography.title,
        ),
        commandBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                FluentIcons.remove_content,
              ),
              onPressed: onRemoveTabPressed,
            ),
            const SizedBox(width: 2.0),
            IconButton(
              icon: const Icon(
                FluentIcons.accept,
              ),
              onPressed: onCreateTabPressed,
            ),
          ],
        ),
      ),
      children: [
        const TextBox(
          placeholder: 'Tab title',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(),
        ),
        TreeView(
          shrinkWrap: true,
          items: lazyItems,
          selectionMode: TreeViewSelectionMode.multiple,
          onSelectionChanged: (selectedItems) async => debugPrint(
            'onSelectionChanged: ${selectedItems.map((i) => i.value)}',
          ),
          onSecondaryTap: (item, details) async {
            debugPrint('onSecondaryTap $item at ${details.globalPosition}');
          },
        )
      ],
    );
  }
}
