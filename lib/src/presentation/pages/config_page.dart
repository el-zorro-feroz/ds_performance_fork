import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart' as config_tab show Tab;
import 'package:sensors_monitoring/src/presentation/controllers/config_controller.dart';

class ConfigPage extends StatelessWidget {
  final String id;

  const ConfigPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final ConfigController controller = services<ConfigController>();

    void onChanged(index) async {}

    void onNewPressed() async {
      GoRouter.of(context).go('/taboptions/$id');
    }

    // DEPRECATED DEV STUFF
    //
    // final ActiveTab activeTab = ActiveTab();
    // final List<Tab> tabs = [
    //   Tab(
    //     text: const Text('Tab 1'),
    //     body: activeTab,
    //   ),
    //   Tab(
    //     text: const Text('Tab 2'),
    //     body: activeTab,
    //   ),
    //   Tab(
    //     text: const Text('Tab 3'),
    //     body: activeTab,
    //   ),
    // ];

    List<Tab> buildTabs(List<config_tab.Tab> tabs) {
      return tabs.map(
        (tab) {
          return Tab(
            text: Text(tab.title),
            body: const Center(
              child: Text('Loading'),
            ),
          );
        },
      ).toList();
    }

    return FutureBuilder<Config>(
      future: controller.getConfigData(id),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: ProgressRing());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final Config config = snapshot.data!;
        final List<Tab> tabs = buildTabs(config.tabList);

        return ScaffoldPage(
          header: PageHeader(
            title: Text(
              'Configuration ${config.title}',
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
      },
    );
  }
}
