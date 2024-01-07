import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/presentation/widgets/config_page/active_tab.dart';

class ConfigPage extends StatelessWidget {
  final String id;

  const ConfigPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    void onChanged(index) async {}

    void onNewPressed() async {
      GoRouter.of(context).go('/taboptions/$id');
    }

    final ActiveTab activeTab = ActiveTab();
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
        closeButtonVisibility: CloseButtonVisibilityMode.never,
        onChanged: onChanged,
        onNewPressed: onNewPressed,
      ),
    );
  }
}
