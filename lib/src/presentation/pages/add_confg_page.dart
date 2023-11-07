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
      children: const [
        TextBox(
          placeholder: 'Configuration title',
        ),
        PageHeader(
          title: Text('Sensors'),
        ),
        TextBox(
          placeholder: 'Configuration title',
        ),
      ],
    );
  }
}
