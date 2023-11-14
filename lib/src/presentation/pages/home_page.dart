import 'package:fluent_ui/fluent_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var typography = FluentTheme.of(context).typography;

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(
          'Control Panel',
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
