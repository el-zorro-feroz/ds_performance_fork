import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/presentation/alert_manager.dart';
import 'package:sensors_monitoring/src/presentation/service_app.dart';

class RootPage extends StatelessWidget {
  static final GlobalKey _navigationViewKey =
      GlobalKey(debugLabel: 'Navigation View Global Key');
  static final GlobalKey _searchBarKey =
      GlobalKey(debugLabel: 'Search Bar Global Key');

  final Widget child;
  final BuildContext? shellContext;

  const RootPage({
    super.key,
    required this.child,
    this.shellContext,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode searchFocusNode = FocusNode();
    final TextEditingController searchTextEditingController =
        TextEditingController();

    //TODO: implement available configurations controller.
    final items = [
      PaneItemHeader(
        header: const Text('Configurations'),
      ),
      // PaneItem(
      //   key: const ValueKey('/'),
      //   icon: const Icon(FluentIcons.home),
      //   title: const Text('Configuration Panel'),
      //   body: const SizedBox.shrink(),
      // ),
      // PaneItemSeparator(),
      PaneItem(
        key: const ValueKey('/config/{ABCD-EFGH-IJKL-MNOP}'),
        icon: const Icon(FluentIcons.database),
        title: const Text('{ABCD-EFGH-IJKL-MNOP}'),
        body: const SizedBox.shrink(),
      ),
      PaneItem(
        key: const ValueKey('/config/{EFGH-ABCD-IJKL-MNOP}'),
        icon: const Icon(FluentIcons.database),
        title: const Text('{EFGH-ABCD-IJKL-MNOP}'),
        body: const SizedBox.shrink(),
      ),
      PaneItem(
        key: const ValueKey('/config/{IJKL-ABCD-EFGH-MNOP}'),
        icon: const Icon(FluentIcons.database),
        title: const Text('{IJKL-ABCD-EFGH-MNOP}'),
        body: const SizedBox.shrink(),
      ),
      PaneItem(
        key: const ValueKey('/config/{MNOP-ABCD-EFGH-IJKL}'),
        icon: const Icon(FluentIcons.database),
        title: const Text('{MNOP-ABCD-EFGH-IJKL}'),
        body: const SizedBox.shrink(),
      ),
    ].map((e) {
      if (e is PaneItem) {
        return PaneItem(
          key: e.key,
          icon: e.icon,
          title: e.title,
          body: e.body,
          onTap: () {
            final path = (e.key as ValueKey).value;
            if (GoRouterState.of(context).uri.toString() != path) {
              context.go(path);
            }
            e.onTap?.call();
          },
        );
      }
      return e;
    }).toList();

    final footerItems = [
      PaneItemSeparator(),
      PaneItem(
        key: const ValueKey('/add'),
        icon: const Icon(FluentIcons.add),
        title: const Text('Add Configuration'),
        body: const SizedBox.shrink(),
      ),
      PaneItem(
        key: const ValueKey('/settings'),
        icon: const Icon(FluentIcons.settings),
        title: const Text('Settings'),
        body: const SizedBox.shrink(),
      ),
    ].map((e) {
      if (e is PaneItem) {
        return PaneItem(
          key: e.key,
          icon: e.icon,
          title: e.title,
          body: e.body,
          onTap: () {
            final path = (e.key as ValueKey).value;
            if (GoRouterState.of(context).uri.toString() != path) {
              context.go(path);
            }
            e.onTap?.call();
          },
        );
      }
      return e;
    }).toList();

    return NavigationView(
      key: _navigationViewKey,
      appBar: NavigationAppBar(
        title: Text(
          ServiceApp.serviceName,
          style: FluentTheme.of(context).typography.subtitle,
        ),
        leading: const SizedBox.shrink(),
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.open,
        autoSuggestBox: Builder(builder: (context) {
          return AutoSuggestBox(
            key: _searchBarKey,
            focusNode: searchFocusNode,
            controller: searchTextEditingController,
            unfocusedColor: Colors.transparent,
            items: items.whereType<PaneItem>().map((item) {
              assert(item.title is Text);

              final String text = (item.title as Text).data!;
              return AutoSuggestBoxItem(
                label: text,
                value: text,
                onSelected: () {
                  item.onTap?.call();

                  searchTextEditingController.clear();
                  searchFocusNode.unfocus();

                  final navView = NavigationView.of(context);
                  if (navView.compactOverlayOpen) {
                    navView.compactOverlayOpen = false;
                  } else if (navView.minimalPaneOpen) {
                    navView.minimalPaneOpen = false;
                  }
                },
              );
            }).toList(),
            trailingIcon: IgnorePointer(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(FluentIcons.search),
              ),
            ),
            placeholder: 'Search',
          );
        }),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        items: items,
        footerItems: footerItems,
      ),
      paneBodyBuilder: (item, _) {
        final name =
            item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('paneBody$name'),
          child: Row(
            children: [
              Expanded(flex: 4, child: child),
              const SizedBox(
                width: kOpenNavigationPaneWidth,
                child: AlertManager(),
              )
            ],
          ),
        );
      },
    );
  }
}
