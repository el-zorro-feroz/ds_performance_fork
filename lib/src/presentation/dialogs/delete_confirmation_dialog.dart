import 'package:fluent_ui/fluent_ui.dart';

const String _defaultTitle = 'Delete permanently?';
const String _defaultDescription = 'If you delete this, you won\'t be able to recover it. Do you want to delete it?';

Future<bool> deleteConfirmationDialog(
  BuildContext context, {
  String title = _defaultTitle,
  String description = _defaultDescription,
}) async {
  final bool? response = await showDialog<bool>(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        Button(
          child: const Text('Delete'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        FilledButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    ),
  );

  return response ?? false;
}
