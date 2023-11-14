import 'package:fluent_ui/fluent_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var typography = FluentTheme.of(context).typography;

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(
          'Settings',
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
