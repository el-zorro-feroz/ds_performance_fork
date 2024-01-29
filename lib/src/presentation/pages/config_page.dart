import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart' as config_tab show Tab;
import 'package:sensors_monitoring/src/presentation/controllers/config_controller.dart';
import 'package:sensors_monitoring/src/presentation/controllers/tab_controller.dart';
import 'package:sensors_monitoring/src/presentation/widgets/config_page/active_tab.dart';

class ConfigPage extends StatelessWidget {
  final String id;

  const ConfigPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final ConfigController controller = services<ConfigController>();

    List<Tab> buildTabs(List<config_tab.Tab> tabs) {
      return tabs.map(
        (config_tab.Tab tab) {
          return Tab(
            text: Text(tab.title),
            body: Center(
              child: ActiveTab(
                configID: id,
                data: tab,
              ),
            ),
          );
        },
      ).toList();
    }

    final TabController tabController = services<TabController>();

    return ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final config = controller.getConfigData(id);
          final tabs = buildTabs(config.tabList);
          return ScaffoldPage(
            header: PageHeader(
              title: Text(
                'Configuration ${config.title}',
              ),
            ),
            content: TabView(
              tabs: tabs,
              currentIndex: tabController.active,
              closeButtonVisibility: CloseButtonVisibilityMode.never,
              onChanged: (i) => tabController.active = i,
              onNewPressed: () => GoRouter.of(context).go('/taboptions/$id'),
            ),
          );
        });
  }
}
