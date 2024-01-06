import 'package:fluent_ui/fluent_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    return ScaffoldPage(
      content: Center(
        child: Text(
          'Monitoring Service',
          style: typography.title?.copyWith(
            color: const Color(0xFFDDDDDD),
          ),
        ),
      ),
    );
  }
}

// Deprecated [AlertManager] variant

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Typography typography = FluentTheme.of(context).typography;

//     return ScaffoldPage.scrollable(
//       header: PageHeader(
//         title: Text(
//           'Quick Overview',
//           style: typography.title,
//         ),
//       ),
//       children: [
//         Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24.0,
//                       vertical: 12.0,
//                     ),
//                     child: Text(
//                       'Notifications',
//                       style: typography.subtitle,
//                     ),
//                   ),
//                   ListTile.selectable(
//                     autofocus: true,
//                     leading: Icon(
//                       FluentIcons.error,
//                       color: Colors.orange,
//                     ),
//                     title: const Text(
//                       'Temperature value is to high - 98C (Normal - 75C)',
//                     ),
//                     trailing: const Text(
//                       '2023-02-02 20:20',
//                     ),
//                     subtitle: const Text(
//                       'Configuration {ABCD-...} - Sensor {DABC-...}',
//                     ),
//                   ),
//                   ListTile.selectable(
//                     autofocus: true,
//                     leading: Icon(
//                       FluentIcons.alert_settings,
//                       color: Colors.blue,
//                     ),
//                     title: const Text(
//                       'Sensor configuration updated',
//                     ),
//                     trailing: const Text(
//                       '2023-02-02 20:20',
//                     ),
//                     subtitle: const Text(
//                       'Configuration {ABCD-...} - Sensor {DABC-...}',
//                     ),
//                   ),
//                   ListTile.selectable(
//                     autofocus: true,
//                     leading: Icon(
//                       FluentIcons.error,
//                       color: Colors.red,
//                     ),
//                     title: const Text(
//                       'Unexpected logic. Sensor was disconnected. Trying to reconnect.',
//                     ),
//                     trailing: const Text(
//                       '2023-02-02 20:20',
//                     ),
//                     subtitle: const Text(
//                       'Configuration {ABCD-...} - Sensor {DABC-...}',
//                     ),
//                   ),
//                   ListTile.selectable(
//                     autofocus: true,
//                     leading: Icon(
//                       FluentIcons.warning,
//                       color: Colors.red,
//                     ),
//                     title: const Text(
//                       'Sensor unreachable. Configuration disabled.',
//                     ),
//                     trailing: const Text(
//                       '2023-02-02 20:20',
//                     ),
//                     subtitle: const Text(
//                       'Configuration {ABCD-...} - Sensor {DABC-...}',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
