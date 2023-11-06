import 'package:fluent_ui/fluent_ui.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/presentation/widgets/config/active_tab.dart';

class ConfigPage extends StatelessWidget {
  final String id;

  const ConfigPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final ActiveTab activeTab = services<ActiveTab>();
    final Typography typography = FluentTheme.of(context).typography;

    final List<Tab> tabs = [
      Tab(
        text: const Text('Tab 1'),
        body: activeTab,
      ),
      Tab(
        text: const Text('Tab 2'),
        body: activeTab,
      ),
      Tab(
        text: const Text('Tab 3'),
        body: activeTab,
      ),
    ];

    return ScaffoldPage(
      header: PageHeader(
        title: Text(
          'Configuration - $id',
        ),
      ),
      content: TabView(
        currentIndex: 0,
        tabs: tabs,
      ),
    );
  }
}
