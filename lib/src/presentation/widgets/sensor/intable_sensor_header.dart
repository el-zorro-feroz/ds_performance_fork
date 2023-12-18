import 'package:fluent_ui/fluent_ui.dart';

class IntableSensorHeader extends StatelessWidget {
  const IntableSensorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Date',
              style: typography.bodyStrong,
            ),
          ),
          Expanded(
            child: Text(
              'Value',
              style: typography.bodyStrong,
            ),
          ),
          Expanded(
            child: Text(
              'Change',
              style: typography.bodyStrong,
            ),
          ),
        ],
      ),
    );
  }
}
