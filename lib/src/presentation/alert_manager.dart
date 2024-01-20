import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/presentation/controllers/notification_controller.dart';

class AlertManager extends StatelessWidget {
  const AlertManager({super.key});

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;
    final NotificationController notificationController = services<NotificationController>();

    return ListenableBuilder(
      listenable: notificationController,
      builder: (_, __) {
        if (notificationController.notifications.isEmpty) {
          return const Center(
            child: ProgressRing(),
          );
        }

        return ListView.builder(
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            final AlertData notificationData = notificationController.notifications.elementAt(index);

            return Card(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          <AlertType, IconData>{
                            AlertType.info: FluentIcons.info,
                            AlertType.error: FluentIcons.warning,
                            AlertType.warning: FluentIcons.report_alert,
                          }[notificationData.type],
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
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  color: <AlertType, Color>{
                                    AlertType.info: const Color(0xFF5566FF),
                                    AlertType.error: const Color(0xFFFF9955),
                                    AlertType.warning: const Color(0xFFFF6655),
                                  }[notificationData.type],
                                  // color: Color(0xFFFF6655),
                                ),
                                child: Text(
                                  <AlertType, String>{
                                        AlertType.info: 'Info',
                                        AlertType.error: 'Error',
                                        AlertType.warning: 'Warning',
                                      }[notificationData.type] ??
                                      'Report',
                                  style: typography.caption,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                'dfg',
                                style: typography.bodyStrong,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            notificationData.title,
                            style: typography.body,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            notificationData.description,
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
      },
    );
  }
}
