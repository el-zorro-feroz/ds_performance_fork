import 'package:fluent_ui/fluent_ui.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/presentation/controllers/active_tab_controller.dart';
import 'package:sensors_monitoring/src/presentation/widgets/config/active_tab.dart';

class ConfigPage extends StatelessWidget {
  final String id;

  const ConfigPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final ActiveTabController activeTabController = services<ActiveTabController>();

    final ActiveTab activeTab = services<ActiveTab>();
    // final Typography typography = FluentTheme.of(context).typography;

    void onChanged(index) async {
      //TODO: replace tab index with actual tab id (server)
      activeTabController.loadTab(id);
    }

    void onNewPressed() async {
      //TODO: implement tab creation feature
    }

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
