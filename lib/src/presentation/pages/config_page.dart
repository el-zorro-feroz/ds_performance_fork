import 'package:fluent_ui/fluent_ui.dart';

class ConfigPage extends StatelessWidget {
  final String id;

  const ConfigPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    var typography = FluentTheme.of(context).typography;

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(
          'Configuration - $id',
          style: typography.title,
        ),
      ),
      children: [
        Text(
          'Comming soon',
          style: typography.subtitle,
        )
      ],
    );
  }
}
