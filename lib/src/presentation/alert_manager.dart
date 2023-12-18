import 'package:fluent_ui/fluent_ui.dart';

class AlertManager extends StatelessWidget {
  const AlertManager({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    return ListView.builder(
      itemCount: 13,
      itemBuilder: (_, __) {
        return Card(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      FluentIcons.report_alert,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              color: Color(0xFFFF6655),
                            ),
                            child: Text(
                              'Temperature alert',
                              style: typography.caption,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            '2023-02-02 10:20',
                            style: typography.bodyStrong,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Configuration {ABCD-EFGH}',
                        style: typography.body,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Sensor {ABCD-EFGH}',
                        style: typography.body,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
