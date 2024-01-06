import 'package:fluent_ui/fluent_ui.dart';

class AddConfigPage extends StatelessWidget {
  const AddConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

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
                content: Text('Sensor $_ options list'),
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
