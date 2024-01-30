import 'package:fluent_ui/fluent_ui.dart';

class IntableSensorData extends StatelessWidget {
  const IntableSensorData({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    return Column(
      children: List.generate(
        20,
        (_) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '2024-02-01 23:20',
                  style: typography.body,
                ),
              ),
              Expanded(
                child: Text(
                  '23.3 oC',
                  style: typography.body,
                ),
              ),
              Expanded(
                child: Text(
                  '-2.1 oC',
                  style: typography.body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
