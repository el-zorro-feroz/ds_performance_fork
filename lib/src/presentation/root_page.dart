import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/src/presentation/service_app.dart';

class RootPage extends StatelessWidget {
  static final GlobalKey _navigationViewKey = GlobalKey(debugLabel: 'Navigation View Global Key');
  static final GlobalKey _searchBarKey = GlobalKey(debugLabel: 'Search Bar Global Key');

  final Widget child;
  final BuildContext? shellContext;

  const RootPage({
    super.key,
    required this.child,
    this.shellContext,
  });

  @override
  Widget build(BuildContext context) {
    // final FocusNode searchFocusNode = FocusNode();
    // final TextEditingController searchController = TextEditingController();

    //TODO: implement available configurations controller.
    final navigation = [
      PaneItem(
        key: const ValueKey('/'),
        icon: const Icon(FluentIcons.home),
        title: const Text('Control Panel'),
        body: const SizedBox.shrink(),
      ),
      PaneItemSeparator(),
      PaneItem(
        key: const ValueKey('/config/{ABCD-EFGH-IJKL-MNOP}'),
        icon: const Icon(FluentIcons.bank),
        title: const Text('{ABCD-EFGH-IJKL-MNOP}'),
        body: const SizedBox.shrink(),
      ),
      PaneItem(
        key: const ValueKey('/config/{EFGH-ABCD-IJKL-MNOP}'),
        icon: const Icon(FluentIcons.checkbox_composite),
        title: const Text('{ABCD-EFGH-IJKL-MNOP}'),
        body: const SizedBox.shrink(),
      ),
      PaneItem(
        key: const ValueKey('/config/{IJKL-ABCD-EFGH-MNOP}'),
        icon: const Icon(FluentIcons.checkbox_composite),
        title: const Text('{ABCD-EFGH-IJKL-MNOP}'),
        body: const SizedBox.shrink(),
      ),
      PaneItem(
        key: const ValueKey('/config/{MNOP-ABCD-EFGH-IJKL}'),
        icon: const Icon(FluentIcons.checkbox_composite),
        title: const Text('{ABCD-EFGH-IJKL-MNOP}'),
        body: const SizedBox.shrink(),
      ),
      PaneItemSeparator(),
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
          style: FluentTheme.of(context).typography.bodyStrong,
        ),
        leading: const SizedBox.shrink(),
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.open,
        // header: const SizedBox(
        //   height: kOneLineTileHeight,
        //   child: FlutterLogo(
        //     style: FlutterLogoStyle.horizontal,
        //     size: 80.0,
        //     textColor: Colors.black,
        //     duration: Duration.zero,
        //   ),
        // ),
        items: navigation,
      ),
      paneBodyBuilder: (item, _) {
        final name = item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('paneBody$name'),
          child: child,
        );
      },
    );
  }
}
